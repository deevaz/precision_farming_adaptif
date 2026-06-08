import 'package:get/get.dart';
import '../controllers/scan_device_controller.dart';

class ScanDeviceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ScanDeviceController());
  }
}
