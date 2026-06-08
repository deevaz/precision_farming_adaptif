import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kelola_tani/app/core/theme/app_fonts.dart';
import 'package:kelola_tani/app/core/theme/app_style.dart';
import 'package:kelola_tani/app/modules/device_detail/views/widgets/dashboard_section.dart';
import 'package:kelola_tani/app/modules/device_detail/views/widgets/detail_card.dart';
import 'package:kelola_tani/app/modules/device_detail/views/widgets/history_table.dart';
import 'package:kelola_tani/app/modules/device_detail/views/widgets/menu_card.dart';
import 'package:kelola_tani/app/modules/device_detail/views/widgets/nutrisi_chart.dart';
import 'package:kelola_tani/app/modules/device_detail/views/widgets/sensor_tile.dart';
import 'package:kelola_tani/app/services/app_refresher.dart';
import 'package:kelola_tani/app/services/dialog_service.dart';
import 'package:kelola_tani/app/shared/widgets/app_header.dart';

import '../controllers/device_detail_controller.dart';

class DeviceDetailView extends GetView<DeviceDetailController> {
  const DeviceDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.light,
      body: AppRefresher(
        onRefresh: () => controller.onRefresh(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Obx(() {
                final onlineStatus = controller.isDeviceOnline.value;
                return AppHeader(
                  leading: Row(
                    children: [
                      Text(
                        controller.device.value?.name ?? 'Memuat...',
                        style: AppFonts.xlSemiBold.copyWith(
                          color: AppStyle.white,
                        ),
                      ),
                      SizedBox(width: 5.w),
                      Icon(
                        Icons.circle,
                        color: onlineStatus
                            ? AppStyle.secondary
                            : AppStyle.danger,
                        size: 12.sp,
                      ),
                    ],
                  ),
                  trailing: ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: Image.asset(
                      'assets/icons/app_icon.png',
                      height: 40.w,
                      width: 40.w,
                    ),
                  ),
                );
              }),
              _buildDashboardGrid(controller),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDashboardGrid(DeviceDetailController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
      child: Column(
        children: [
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 4,
                  child: Obx(() {
                    final sensor = controller.latestSensor.value;
                    return Column(
                      children: [
                        SensorTile(
                          label: 'Suhu',
                          value: sensor != null
                              ? '${sensor.suhu.toStringAsFixed(1)} C'
                              : '-- C',
                          icon: Ionicons.thermometer,
                          accentColor: AppStyle.danger,
                        ),
                        SizedBox(height: 10.h),
                        SensorTile(
                          label: 'Kelembapan Tanah',
                          value: sensor != null
                              ? '${sensor.kelembapanTanah.toStringAsFixed(1)} %'
                              : '-- %',
                          icon: Ionicons.water,
                          accentColor: AppStyle.primary,
                        ),
                        SizedBox(height: 10.h),
                        SensorTile(
                          label: 'Kelembapan Udara',
                          value: sensor != null
                              ? '${sensor.kelembapanUdara.toStringAsFixed(1)} %'
                              : '-- %',
                          icon: Ionicons.cloudy,
                          accentColor: AppStyle.secondary,
                        ),
                      ],
                    );
                  }),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  flex: 5,
                  child: Obx(() {
                    final config = controller.config.value;
                    final command = controller.command.value;
                    return Column(
                      children: [
                        DetailCard(
                          title: 'Target EC',
                          value: config != null
                              ? '${config.targetEC} mS/cm'
                              : '-- mS/cm',
                          footer: 'Fase: ${config?.growthPhase ?? '--'}',
                          icon: Ionicons.leaf,
                          color: AppStyle.primary,
                        ),
                        SizedBox(height: 12.h),
                        DetailCard(
                          title: 'Durasi Pompa',
                          value: config != null
                              ? '${config.pumpDurationMin} Menit'
                              : '-- Menit',
                          data: 'Debit: ${config?.pumpDebitMLperS ?? 0} mL/S',
                          footer:
                              'Pompa: ${command?.action == 'on' ? 'Aktif' : 'Mati'}',
                          icon: Ionicons.timer,
                          color: AppStyle.accent,
                        ),
                      ],
                    );
                  }),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              MenuCard(
                label: 'Kendali Pompa\n(Manual/AI)',
                icon: Ionicons.settings,
                color: AppStyle.primary,
                onTap: () {
                  DialogService.controlMode(
                    currentMode: controller.currentMode,
                    pumpMode: controller.pumpMode,
                    onPumpModeSelected: (newPumpMode) {
                      controller.updatePumpMode(newPumpMode);
                      String textFromDialog = newPumpMode.trim().toLowerCase();
                      String action =
                          (textFromDialog == 'nyala' ||
                              textFromDialog == 'hidup')
                          ? 'on'
                          : 'off';
                      controller.sendPumpCommand(action);
                    },
                    onModeSelected: (newMode) {
                      controller.updateMode(newMode);
                    },
                  );
                },
              ),
              SizedBox(width: 12.w),
              MenuCard(
                label: 'Catatan',
                icon: Ionicons.document_text,
                color: AppStyle.secondary,
                onTap: () => Get.toNamed(
                  '/notes',
                  arguments: {
                    'deviceId': controller.deviceId,
                    'deviceName': controller.device.value?.name ?? 'Perangkat',
                  },
                ),
              ),
              SizedBox(width: 12.w),
              MenuCard(
                label: 'Prediksi\nNutrisi (Detail)',
                icon: Ionicons.analytics,
                color: AppStyle.accent,
                onTap: () => Get.toNamed(
                  '/ai',
                  arguments: {
                    'deviceId': controller.deviceId,
                    'deviceName': controller.device.value?.name ?? 'Perangkat',
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Obx(
            () => DashboardSectionCard(
              title: 'Grafik Nutrisi (NPK)',
              dateRangeLabel: controller.chartFilter.value,
              onDateTap: () => _showFilterBottomSheet(
                Get.context!,
                controller,
                isChart: true,
              ),
              content: const NutrisiChart(),
            ),
          ),
          SizedBox(height: 20.h),
          Obx(
            () => DashboardSectionCard(
              title: 'Tabel History Lingkungan',
              dateRangeLabel: controller.tableFilter.value == 'Kustom'
                  ? controller.getFormattedDate(isChart: false)
                  : controller.tableFilter.value,
              onDateTap: () => _showFilterBottomSheet(
                Get.context!,
                controller,
                isChart: false,
              ),
              content: const HistoryTable(),
            ),
          ),
        ],
      ),
    );
  }
}

void _showFilterBottomSheet(
  BuildContext context,
  DeviceDetailController controller, {
  required bool isChart,
}) {
  Get.bottomSheet(
    Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppStyle.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Pilih Rentang Waktu', style: AppFonts.xlSemiBold),
          SizedBox(height: 15.h),
          _buildFilterOption('Hari Ini', controller, isChart),
          _buildFilterOption('3 Hari Terakhir', controller, isChart),
          _buildFilterOption('7 Hari Terakhir', controller, isChart),
          const Divider(),
          ListTile(
            leading: Icon(Ionicons.calendar_outline, color: AppStyle.primary),
            title: Text('Pilih Manual di Kalender', style: AppFonts.mdSemiBold),
            onTap: () {
              Get.back();
              controller.pickDateRange(isChart: isChart);
            },
          ),
        ],
      ),
    ),
  );
}

Widget _buildFilterOption(
  String label,
  DeviceDetailController controller,
  bool isChart,
) {
  return ListTile(
    title: Text(label, style: AppFonts.mdRegular),
    trailing: Obx(
      () => controller.chartFilter.value == label
          ? Icon(Ionicons.checkmark_circle, color: AppStyle.primary)
          : const SizedBox(),
    ),
    onTap: () {
      controller.applyQuickFilter(label, isChart: isChart);
      Get.back();
    },
  );
}
