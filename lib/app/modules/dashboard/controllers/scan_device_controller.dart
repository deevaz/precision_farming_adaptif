import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kelola_tani/app/core/utils/result_state.dart';
import 'package:kelola_tani/app/services/firestore_service.dart';
import 'package:kelola_tani/app/services/dialog_service.dart';

class ScanDeviceController extends GetxController {
  final FirestoreService _firestoreService = Get.find();

  final scanState = Rx<ResultState<String>>(const ResultInitial());
  final connectState = Rx<ResultState<void>>(const ResultInitial());
  final deviceNameController = TextEditingController();

  String get uid => FirebaseAuth.instance.currentUser!.uid;
  bool get isScanned => scanState.value is ResultSuccess<String>;
  bool get isLoading => connectState.value is ResultLoading;

  void onQRDetected(String rawValue) {
    if (isScanned) return;
    scanState.value = ResultSuccess(rawValue);
  }

  void resetScan() {
    scanState.value = const ResultInitial();
    connectState.value = const ResultInitial();
    deviceNameController.clear();
  }

  Future<void> connectDevice() async {
    final current = scanState.value;
    if (current is! ResultSuccess<String>) {
      DialogService.showInfo(
        title: 'Gagal',
        message: 'Belum ada perangkat yang di-scan!',
      );
      return;
    }

    final name = deviceNameController.text.trim();
    if (name.isEmpty) {
      DialogService.showInfo(
        title: 'Gagal',
        message: 'Nama perangkat tidak boleh kosong!',
      );
      return;
    }

    connectState.value = const ResultLoading();

    try {
      final deviceId = current.data;

      final isValid = await _firestoreService.isDeviceValid(deviceId);
      if (!isValid) {
        connectState.value = const ResultFailed('Perangkat tidak valid');
        DialogService.showInfo(
          title: 'Gagal',
          message: 'Perangkat tidak ditemukan atau tidak valid!',
        );
        return;
      }

      final isTaken = await _firestoreService.isDeviceTaken(deviceId);
      if (isTaken) {
        connectState.value = const ResultFailed('Perangkat sudah digunakan');
        DialogService.showInfo(
          title: 'Gagal',
          message: 'Perangkat ini sudah terhubung ke akun lain!',
        );
        return;
      }

      await _firestoreService.claimDevice(uid, deviceId, name);

      connectState.value = const ResultSuccess(null);

      DialogService.showInfo(
        title: 'Berhasil',
        message: 'Perangkat "$name" berhasil dihubungkan!',
      );

      Get.back();
      Get.back();
    } catch (e) {
      connectState.value = ResultFailed(e.toString());
      DialogService.showInfo(
        title: 'Gagal',
        message: 'Gagal menghubungkan perangkat: $e',
      );
    }
  }

  @override
  void onClose() {
    deviceNameController.dispose();
    super.onClose();
  }
}
