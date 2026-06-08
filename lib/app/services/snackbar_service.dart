import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kelola_tani/app/core/theme/app_style.dart';

class SnackbarService {
  static void success(String title, String message) {
    Get.snackbar(
      title,
      message,
      icon: Icon(Ionicons.checkmark_circle, color: AppStyle.white, size: 28.sp),
      shouldIconPulse: false,
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
      borderRadius: 15.r,
      duration: const Duration(seconds: 3),
      colorText: AppStyle.white,
      backgroundColor: AppStyle.success.withOpacity(0.95),
      forwardAnimationCurve: Curves.easeOutBack,
      boxShadows: [
        BoxShadow(
          color: AppStyle.success.withOpacity(0.4),
          blurRadius: 15,
          offset: const Offset(0, 8),
        ),
      ],
    );
  }

  static void error(String title, String message) {
    Get.snackbar(
      title,
      message,
      icon: Icon(Ionicons.close_circle, color: AppStyle.white, size: 28.sp),
      shouldIconPulse: false,
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
      borderRadius: 15.r,
      duration: const Duration(seconds: 3),
      colorText: AppStyle.white,
      backgroundColor: AppStyle.danger.withOpacity(0.95),
      forwardAnimationCurve: Curves.easeOutBack,
      boxShadows: [
        BoxShadow(
          color: AppStyle.danger.withOpacity(0.4),
          blurRadius: 15,
          offset: const Offset(0, 8),
        ),
      ],
    );
  }

  static void warning(String title, String message) {
    Get.snackbar(
      title,
      message,
      icon: Icon(Ionicons.warning, color: AppStyle.white, size: 28.sp),
      shouldIconPulse: false,
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
      borderRadius: 15.r,
      duration: const Duration(seconds: 3),
      colorText: AppStyle.white,
      backgroundColor: AppStyle.warning.withOpacity(0.95),
      forwardAnimationCurve: Curves.easeOutBack,
      boxShadows: [
        BoxShadow(
          color: AppStyle.warning.withOpacity(0.4),
          blurRadius: 15,
          offset: const Offset(0, 8),
        ),
      ],
    );
  }

  static void info(String title, String message) {
    Get.snackbar(
      title,
      message,
      icon: Icon(
        Ionicons.information_circle,
        color: AppStyle.white,
        size: 28.sp,
      ),
      shouldIconPulse: false,
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
      borderRadius: 15.r,
      duration: const Duration(seconds: 3),
      colorText: AppStyle.white,
      backgroundColor: AppStyle.primary.withOpacity(0.95),
      forwardAnimationCurve: Curves.easeOutBack,
      boxShadows: [
        BoxShadow(
          color: AppStyle.primary.withOpacity(0.4),
          blurRadius: 15,
          offset: const Offset(0, 8),
        ),
      ],
    );
  }
}
