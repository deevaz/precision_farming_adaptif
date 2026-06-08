import 'package:get/get.dart';
import 'package:kelola_tani/app/modules/device_detail/controllers/ai_controller.dart';

class AiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AiController>(() => AiController());
  }
}
