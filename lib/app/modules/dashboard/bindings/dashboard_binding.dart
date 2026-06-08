import 'package:get/get.dart';
import 'package:kelola_tani/app/modules/dashboard/controllers/scan_device_controller.dart';

import '../controllers/dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(() => DashboardController());
    Get.lazyPut(() => ScanDeviceController());
  }
}
