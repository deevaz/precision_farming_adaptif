import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_style.dart';

class AppButtonStyle {
  static final ButtonStyle mainRounded = ElevatedButton.styleFrom(
    backgroundColor: AppStyle.primary,
    foregroundColor: AppStyle.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.r)),
    padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
    textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
  );

  static final ButtonStyle rounded15 = ElevatedButton.styleFrom(
    backgroundColor: AppStyle.primary,
    foregroundColor: AppStyle.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
    padding: EdgeInsets.symmetric(vertical: 15.w, horizontal: 30.h),
    textStyle: TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.bold,
      color: AppStyle.white,
    ),
  );

  static final ButtonStyle danger = ElevatedButton.styleFrom(
    backgroundColor: AppStyle.danger,
    foregroundColor: AppStyle.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.r), // 15.sp
    ),
    padding: EdgeInsets.symmetric(vertical: 15.w, horizontal: 30.h),
    textStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
  );
}
