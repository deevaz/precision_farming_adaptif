import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kelola_tani/app/core/theme/app_fonts.dart';
import 'package:kelola_tani/app/core/theme/app_style.dart';
import 'package:kelola_tani/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:kelola_tani/app/services/dialog_service.dart';
import 'package:kelola_tani/app/shared/widgets/app_button.dart';
import 'package:kelola_tani/app/shared/widgets/app_material_round.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.primary,
      body: Stack(
        children: [
          Container(
            height: 320.h,
            width: 1.sw,
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 60.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: AppButton.icon(
                    elevation: 0,
                    color: AppStyle.white.withOpacity(0.3),
                    onTap: () {
                      Get.toNamed('/account');
                    },
                    icon: Icon(Ionicons.person, color: AppStyle.white),
                  ),
                ),
                SizedBox(height: 20.h),
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.r),
                      child: Image.asset(
                        'assets/icons/app_icon.png',
                        height: 70.w,
                        width: 70.w,
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Selamat Datang',
                          style: AppFonts.xxlBold.copyWith(
                            color: AppStyle.surface,
                          ),
                        ),
                        Text(
                          controller.user?.displayName ?? 'Petani Modern',
                          style: AppFonts.mdRegular.copyWith(
                            color: AppStyle.surface.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Get.height - 240.h,
              width: 1.sw,
              decoration: BoxDecoration(
                color: AppStyle.light,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.r),
                  topRight: Radius.circular(40.r),
                ),
              ),
              padding: EdgeInsets.all(24.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Daftar Perangkat', style: AppFonts.mdMedium),
                  SizedBox(height: 20.h),
                  Expanded(
                    child: Obx(() {
                      if (controller.isLoading.value) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      return GridView.count(
                        crossAxisCount: 3,
                        crossAxisSpacing: 16.w,
                        mainAxisSpacing: 16.h,
                        padding: EdgeInsets.zero,
                        children: [
                          ...controller.devices.map(
                            (device) => _buildDeviceCard(
                              device.name,
                              Ionicons.hardware_chip_outline,
                              () => controller.goToDetail(device),
                              () => DialogService.confirmation(
                                title: 'Hapus Perangkat',
                                message:
                                    'Apakah Anda yakin ingin menghapus perangkat "${device.name}"?',
                                onConfirm: () {
                                  controller.deleteDevice(device);
                                  Get.back();
                                },
                              ),
                            ),
                          ),
                          _buildAddCard(controller),
                        ],
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeviceCard(
    String label,
    IconData icon,
    VoidCallback? onTap,
    VoidCallback? onLongPress,
  ) {
    return AppMaterialRound(
      color: AppStyle.white,
      radius: 16.r,
      elevation: 2,
      onTap: onTap,
      onLongPress: onLongPress,

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppMaterialRound(
            height: 40.w,
            width: 40.w,
            radius: 12.r,
            color: AppStyle.white,
            elevation: 0,
            child: Icon(icon, color: AppStyle.primary, size: 22.sp),
          ),
          SizedBox(height: 12.h),
          Text(label, style: AppFonts.smMedium, textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget _buildAddCard(DashboardController controller) {
    return AppMaterialRound(
      onTap: () => Get.toNamed('/scan-device'),
      color: AppStyle.primary.withOpacity(0.1),
      radius: 16.r,
      elevation: 0,
      borderColor: AppStyle.primary.withOpacity(0.3),
      child: Center(
        child: Icon(Ionicons.add_circle, size: 40.sp, color: AppStyle.primary),
      ),
    );
  }
}
