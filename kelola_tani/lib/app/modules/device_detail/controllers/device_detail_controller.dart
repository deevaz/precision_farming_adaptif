import 'dart:async';

import 'package:date_range_filter/date_range_filter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kelola_tani/app/core/theme/app_style.dart';
import 'package:kelola_tani/app/data/models/device_config_model.dart';
import 'package:kelola_tani/app/data/models/device_model.dart';
import 'package:kelola_tani/app/data/models/pump_command_model.dart';
import 'package:kelola_tani/app/data/models/pump_log_model.dart';
import 'package:kelola_tani/app/data/models/sensor_log_model.dart';
import 'package:kelola_tani/app/services/firestore_service.dart';
import 'package:kelola_tani/app/services/snackbar_service.dart';

class DeviceDetailController extends GetxController {
  final FirestoreService _firestore = FirestoreService();

  String deviceId = Get.arguments?['deviceId'] ?? 'KTANI-A1B2C3D4E5F6';

  final String uid = '02QnFCV4Woh7VAqar9oMY0us4W03';

  final device = Rxn<DeviceModel>();
  final config = Rxn<DeviceConfigModel>();
  final command = Rxn<PumpCommandModel>();
  final latestSensor = Rxn<SensorLogModel>();

  RxString currentMode = 'Otomatis'.obs;
  RxString pumpMode = 'Mati'.obs;

  final chartFilter = 'Hari Ini'.obs;
  final tableFilter = 'Hari Ini'.obs;

  final chartDateRange = Rxn<DateTimeRange>();
  final tableDateRange = Rxn<DateTimeRange>();

  final chartLogs = <SensorLogModel>[].obs;
  final tableLogs = <SensorLogModel>[].obs;

  StreamSubscription? _chartSub;
  StreamSubscription? _tableSub;

  Timer? _statusTimer;
  final isDeviceOnline = false.obs;

  @override
  void onInit() {
    super.onInit();
    _listenToFirestore();

    _statusTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      if (device.value != null) {
        isDeviceOnline.value = device.value!.isOnline;
      }
    });

    final now = DateTime.now();
    final todayRange = DateTimeRange(
      start: DateTime(now.year, now.month, now.day),
      end: DateTime(now.year, now.month, now.day, 23, 59, 59),
    );

    chartDateRange.value = todayRange;
    tableDateRange.value = todayRange;

    ever(chartDateRange, (_) => _fetchChartLogs());
    ever(tableDateRange, (_) => _fetchTableLogs());

    _fetchChartLogs();
    _fetchTableLogs();
  }

  Future<void> sendPumpCommand(String action) async {
    try {
      final currentConfig = config.value;
      print('>>> Action yang dikirim dari UI: $action');
      print('>>> Durasi config saat ini: ${currentConfig?.pumpDurationMin}');

      int durationToUse = currentConfig?.pumpDurationMin ?? 15;
      if (durationToUse == 0) {
        durationToUse = 15;
      }

      final newCommand = PumpCommandModel(
        action: action,
        duration: durationToUse,
        sentAt: DateTime.now(),
        executed: false,
      );

      await _firestore.sendPumpCommand(uid, deviceId, newCommand);

      await _firestore.addPumpLog(
        uid,
        deviceId,
        PumpLogModel(
          logId: '',
          status: action == 'on' ? 'aktif' : 'nonaktif',
          durationMin: durationToUse,
          startedAt: DateTime.now(),
        ),
      );

      pumpMode.value = action == 'on' ? 'Hidup' : 'Mati';

      SnackbarService.success(
        'Berhasil',
        'Pompa berhasil di${action == 'on' ? 'hidupkan' : 'matikan'}',
      );
    } catch (e) {
      SnackbarService.error('Gagal', 'Gagal mengirim perintah pompa: $e');
    }
  }

  Future<void> updateDeviceConfig({
    double? targetEC,
    String? growthPhase,
    int? pumpDurationMin,
    int? pumpDebitMLperS,
  }) async {
    try {
      final current = config.value ?? DeviceConfigModel();
      final updated = DeviceConfigModel(
        targetEC: targetEC ?? current.targetEC,
        growthPhase: growthPhase ?? current.growthPhase,
        pumpDurationMin: pumpDurationMin ?? current.pumpDurationMin,
        pumpDebitMLperS: pumpDebitMLperS ?? current.pumpDebitMLperS,
        updatedAt: DateTime.now(),
      );
      await _firestore.updateConfig(uid, deviceId, updated);
      SnackbarService.success('Berhasil', 'Konfigurasi berhasil disimpan');
    } catch (e) {
      SnackbarService.error('Gagal', 'Gagal menyimpan konfigurasi: $e');
    }
  }

  void _fetchChartLogs() {
    if (chartDateRange.value == null) return;
    _chartSub?.cancel();
    _chartSub = _firestore
        .streamSensorLogsByRange(
          uid,
          deviceId,
          chartDateRange.value!.start,
          chartDateRange.value!.end,
        )
        .listen((logs) => chartLogs.assignAll(logs));
  }

  void _fetchTableLogs() {
    if (tableDateRange.value == null) return;
    _tableSub?.cancel();
    _tableSub = _firestore
        .streamSensorLogsByRange(
          uid,
          deviceId,
          tableDateRange.value!.start,
          tableDateRange.value!.end,
        )
        .listen((logs) => tableLogs.assignAll(logs));
  }

  String getFormattedDate({required bool isChart}) {
    final range = isChart ? chartDateRange.value : tableDateRange.value;

    if (range == null) return 'Pilih Tanggal';

    final start = range.start;
    final end = range.end;

    String startStr = "${start.day}/${start.month}/${start.year}";
    String endStr = "${end.day}/${end.month}/${end.year}";

    if (start.day == end.day &&
        start.month == end.month &&
        start.year == end.year) {
      return startStr;
    }
    return "$startStr - $endStr";
  }

  void applyQuickFilter(String type, {required bool isChart}) {
    final now = DateTime.now();
    DateTimeRange newRange;

    if (type == 'Hari Ini') {
      newRange = DateTimeRange(
        start: DateTime(now.year, now.month, now.day),
        end: DateTime(now.year, now.month, now.day, 23, 59, 59),
      );
    } else if (type == '3 Hari Terakhir') {
      newRange = DateTimeRange(
        start: now.subtract(const Duration(days: 3)),
        end: now,
      );
    } else {
      newRange = DateTimeRange(
        start: now.subtract(const Duration(days: 7)),
        end: now,
      );
    }

    if (isChart) {
      chartFilter.value = type;
      chartDateRange.value = newRange;
    } else {
      tableFilter.value = type;
      tableDateRange.value = newRange;
    }
  }

  Future<void> onRefresh() async {
    final isOnline = device.value?.isOnline ?? false;

    if (!isOnline) {
      SnackbarService.error(
        'Gagal',
        'Perangkat sedang offline. Tidak dapat meminta pembaruan data.',
      );
      return;
    }
    try {
      await _firestore.triggerManualUpdate(uid, deviceId);
      SnackbarService.success(
        'Permintaan Dikirim',
        'Menunggu respon dari perangkat...',
      );
    } catch (e) {
      SnackbarService.error('Gagal', 'Gagal memuat data terbaru');
    }
  }

  void _listenToFirestore() {
    device.bindStream(_firestore.streamSingleDevice(uid, deviceId));

    ever(device, (data) {
      if (data != null) {
        isDeviceOnline.value = data.isOnline;
      }
    });

    _firestore.streamDevices(uid).listen((devices) {
      final currentDevice = devices.firstWhereOrNull(
        (d) => d.deviceId == deviceId,
      );
      if (currentDevice != null) {
        device.value = currentDevice;
      }
    });

    config.bindStream(_firestore.streamConfig(uid, deviceId));

    command.bindStream(_firestore.streamPumpCommand(uid, deviceId));

    latestSensor.bindStream(_firestore.streamLatestSensorLog(uid, deviceId));
  }

  Future<void> pickDateRange({required bool isChart}) async {
    DateRangeResult? picked = await DateRangeFilter(
      context: Get.context!,
      color: Theme.of(Get.context!).primaryColor,
      labelColor: AppStyle.primary,
      title: 'Pilih Rentang Tanggal',
      todayLabel: 'Hari Ini',
      yesterdayLabel: 'Kemarin',
      last7DaysLabel: '7 Hari Terakhir',
      last30DaysLabel: '30 Hari Terakhir',
      thisMonthLabel: 'Bulan Ini',
      lastMonthLabel: 'Bulan Lalu',
      thisYearLabel: 'Tahun Ini',
      lastYearLabel: 'Tahun Lalu',
      customDateTimeLabel: 'Tanggal Kustom',
      customRangeLabel: 'Rentang Kustom',
    ).getSelectedDate;

    if (picked != null) {
      final normalizedStart = DateTime(
        picked.startDate.year,
        picked.startDate.month,
        picked.startDate.day,
        0,
        0,
        0,
      );
      final normalizedEnd = DateTime(
        picked.endDate.year,
        picked.endDate.month,
        picked.endDate.day,
        23,
        59,
        59,
      );

      final newRange = DateTimeRange(
        start: normalizedStart,
        end: normalizedEnd,
      );

      if (isChart) {
        chartDateRange.value = newRange;
        chartFilter.value = 'Kustom';
      } else {
        tableDateRange.value = newRange;
        tableFilter.value = 'Kustom';
      }
    }
  }

  void updateChartFilter(String value) => chartFilter.value = value;
  void updateTableFilter(String value) => tableFilter.value = value;

  void updatePumpMode(String newPumpMode) {
    pumpMode.value = newPumpMode;
  }

  void updateMode(String newMode) async {
    currentMode.value = newMode;

    String modeForDb = newMode.toLowerCase() == 'otomatis'
        ? 'otomatis'
        : 'manual';

    try {
      await _firestore.updateOperatingMode(uid, deviceId, modeForDb);

      SnackbarService.success('Berhasil', 'Sistem beralih ke mode $newMode');
    } catch (e) {
      SnackbarService.error('Gagal', 'Gagal mengubah mode: $e');
    }
  }

  final count = 0.obs;
  void increment() => count.value++;

  @override
  void onClose() {
    _statusTimer?.cancel();
    super.onClose();
  }
}
