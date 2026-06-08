import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kelola_tani/app/core/theme/app_style.dart';
import 'package:kelola_tani/app/shared/widgets/app_material_round.dart';

class AppTextFormField extends StatelessWidget {
  final String title;
  final String? hintText;
  final Widget? prefixIcon;

  final TextEditingController? controller;
  const AppTextFormField({
    super.key,
    required this.title,
    this.hintText,
    this.controller,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return AppMaterialRound(
      child: TextFormField(
        controller: controller,
        maxLines: 6,
        decoration: InputDecoration(
          label: Text(title),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          hintText: hintText,
          prefixIcon: prefixIcon,
          prefixIconColor: AppStyle.grey,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r),
            borderSide: BorderSide.none,
          ),
          filled: true,
          contentPadding: EdgeInsets.all(15.r),
          fillColor: AppStyle.white,
          hintStyle: TextStyle(
            fontSize: 14.sp,
            color: AppStyle.dark.withOpacity(0.5),
          ),
        ),
        style: TextStyle(fontSize: 14.sp, color: AppStyle.dark),
      ),
    );
  }
}
