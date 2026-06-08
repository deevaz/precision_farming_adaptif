import 'package:get/get.dart';
import 'package:kelola_tani/app/modules/dashboard/bindings/scan_device_binding.dart';
import 'package:kelola_tani/app/modules/dashboard/views/scan_device_view.dart';
import 'package:kelola_tani/app/modules/device_detail/bindings/ai_binding.dart';
import 'package:kelola_tani/app/modules/device_detail/bindings/notes_binding.dart';
import 'package:kelola_tani/app/modules/device_detail/views/ai_view.dart';
import 'package:kelola_tani/app/modules/device_detail/views/notes_view.dart';

import '../modules/account/bindings/account_binding.dart';
import '../modules/account/views/account_view.dart';
import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/views/auth_view.dart';
import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/device_detail/bindings/device_detail_binding.dart';
import '../modules/device_detail/views/device_detail_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(name: _Paths.HOME, page: () => HomeView(), binding: HomeBinding()),
    GetPage(
      name: _Paths.AUTH,
      page: () => const AuthView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => const DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: '/scan-device',
      page: () => const ScanDeviceView(),
      binding: ScanDeviceBinding(),
    ),
    GetPage(
      name: _Paths.ACCOUNT,
      page: () => const AccountView(),
      binding: AccountBinding(),
    ),
    GetPage(
      name: _Paths.DEVICE_DETAIL,
      page: () => const DeviceDetailView(),
      binding: DeviceDetailBinding(),
    ),
    GetPage(
      name: _Paths.NOTES,
      page: () => const NotesView(),
      binding: NotesBinding(),
    ),
    GetPage(name: _Paths.AI, page: () => const AiView(), binding: AiBinding()),
  ];
}
