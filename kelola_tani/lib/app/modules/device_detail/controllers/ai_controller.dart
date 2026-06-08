import 'package:get/get.dart';

class AiController extends GetxController {
  final RxBool showRecommendations = false.obs;
  String deviceName = Get.arguments?['deviceName'] ?? 'Perangkat';

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void toggleRecommendations() {
    showRecommendations.value = !showRecommendations.value;
  }
}
