import 'package:get/get.dart';

import '../controllers/device_detail_controller.dart';

class DeviceDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DeviceDetailController>(
      () => DeviceDetailController(),
    );
  }
}
