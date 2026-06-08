import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kelola_tani/app/data/models/device_model.dart';
import 'package:kelola_tani/app/services/firestore_service.dart';

class DashboardController extends GetxController {
  final FirestoreService _firestoreService = Get.find();
  final user = FirebaseAuth.instance.currentUser;
  final photoURL = FirebaseAuth.instance.currentUser?.photoURL;

  final devices = <DeviceModel>[].obs;
  final isLoading = true.obs;

  String get uid => FirebaseAuth.instance.currentUser!.uid;

  @override
  void onInit() {
    super.onInit();
    listenDevices();
  }

  void listenDevices() {
    _firestoreService.streamDevices(uid).listen((data) {
      devices.value = data;
      isLoading.value = false;
    });
  }

  void deleteDevice(DeviceModel device) async {
    await _firestoreService.deleteDevice(uid, device.deviceId);
  }

  void goToDetail(DeviceModel device) {
    Get.toNamed(
      '/device-detail',
      arguments: {'deviceId': device.deviceId, 'deviceName': device.name},
    );
    print('Navigating to details of ${device.name} (${device.deviceId})');
  }

  void goToScan() {
    Get.toNamed('/scan-device');
  }
}
