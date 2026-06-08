import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kelola_tani/app/core/theme/app_fonts.dart';
import 'package:kelola_tani/app/core/theme/app_style.dart';

class AppEmptyState extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData icon;
  final Color? iconColor;
  final String? buttonText;
  final VoidCallback? onAction;

  const AppEmptyState({
    super.key,
    required this.title,
    this.subtitle,
    required this.icon,
    this.iconColor,
    this.buttonText,
    this.onAction,
  });

  factory AppEmptyState.empty({
    String? title,
    String? subtitle,
    IconData? icon,
  }) {
    return AppEmptyState(
      title: title ?? 'Tidak ada data',
      subtitle: subtitle ?? 'Belum ada data yang bisa ditampilkan saat ini.',
      icon: icon ?? Ionicons.folder_open_outline,
      iconColor: AppStyle.primary,
    );
  }

  factory AppEmptyState.error({
    String? title,
    required String message,
    String? buttonText,
    VoidCallback? onRetry,
  }) {
    String detailError = message.isNotEmpty
        ? '\n\n${'Detail Error'}: $message'
        : '';
    return AppEmptyState(
      title: title ?? 'Terjadi Kesalahan',
      subtitle: '${'Error'.tr}$detailError',
      icon: Ionicons.alert_circle_outline,
      iconColor: AppStyle.danger,
      buttonText: buttonText ?? 'try-again'.tr,
      onAction: onRetry,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(24.r),
              decoration: BoxDecoration(
                color: (iconColor ?? AppStyle.primary).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 80.sp,
                color: iconColor ?? AppStyle.primary,
              ),
            ),
            SizedBox(height: 20.h),

            Text(title, style: AppFonts.lgBold, textAlign: TextAlign.center),

            if (subtitle != null && subtitle!.isNotEmpty) ...[
              SizedBox(height: 8.h),
              Text(
                subtitle!,
                style: AppFonts.smRegular.copyWith(color: Colors.grey.shade600),
                textAlign: TextAlign.center,
              ),
            ],

            if (onAction != null) ...[
              SizedBox(height: 24.h),
              SizedBox(
                width: 200.w,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppStyle.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                  ),
                  onPressed: onAction,
                  child: Text(
                    buttonText ?? 'Aksi',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
