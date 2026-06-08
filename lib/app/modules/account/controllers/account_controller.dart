import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AccountController extends GetxController {
  final user = FirebaseAuth.instance.currentUser;
  final photoURL = FirebaseAuth.instance.currentUser?.photoURL;

  final count = 0.obs;
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

  void increment() => count.value++;
}
