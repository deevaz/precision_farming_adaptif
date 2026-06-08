import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:kelola_tani/app/modules/auth/controllers/auth_controller.dart';
import 'package:kelola_tani/app/services/firestore_service.dart';
import 'package:kelola_tani/firebase_options.dart';

class AppInitializer {
  static Future<void> init() async {
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      await initializeDateFormatting('id_ID', null);
      await Future.wait([_initNetwork()]);
      await _initServices();
      await _initRepositories();
      await _initGlobalController();

      await _initNotifications();
    } catch (e) {}
  }

  static Future<void> _initNetwork() async {}

  static Future<void> _initServices() async {
    Get.put(FirestoreService());
  }

  static Future<void> _initRepositories() async {}

  static Future<void> _initGlobalController() async {
    Get.put(AuthController(), permanent: true);
  }

  static Future<void> dispose() async {}

  static Future<void> _initNotifications() async {}
}
