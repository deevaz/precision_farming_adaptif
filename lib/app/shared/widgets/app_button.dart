import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kelola_tani/app/core/theme/app_button_style.dart';
import 'package:kelola_tani/app/core/theme/app_style.dart';
import 'package:kelola_tani/app/shared/widgets/app_material_round.dart';

enum AppButtonVariant { elevated, outlined, iconRound, text }

class AppButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String? text;
  final Widget? icon;
  final bool isLoading;
  final ButtonStyle? style;
  final double? width;
  final double? height;
  final double? fontSize;
  final Color? color;
  final Color? foregroundColor;
  final double? size;
  final Color? textColor;
  final double? padding;
  final AppButtonVariant variant;
  final double? borderRadius;
  final double? elevation;

  const AppButton({
    super.key,
    required this.onTap,
    required this.text,
    this.isLoading = false,
    this.style,
    this.textColor,
    this.width,
    this.height,
    this.color,
    this.foregroundColor,
    this.fontSize,
    this.borderRadius,
    this.icon,
  }) : variant = AppButtonVariant.elevated,
       size = null,
       elevation = null,
       padding = null;

  const AppButton.outlined({
    super.key,
    required this.onTap,
    required this.text,
    this.isLoading = false,
    this.style,
    this.color,
    this.foregroundColor,
    this.textColor,
    this.height,
    this.fontSize,
    this.width,
    this.borderRadius,
    this.icon,
  }) : variant = AppButtonVariant.outlined,
       size = null,
       elevation = null,
       padding = null;

  const AppButton.icon({
    super.key,
    required this.onTap,
    required this.icon,
    this.isLoading = false,
    this.color,
    this.borderRadius,
    this.size,
    this.elevation,
    this.padding,
  }) : variant = AppButtonVariant.iconRound,
       text = null,
       style = null,
       textColor = null,
       height = null,
       foregroundColor = null,
       fontSize = null,
       width = null;

  const AppButton.text({
    super.key,
    required this.onTap,
    required this.text,
    this.isLoading = false,
    this.style,
    this.icon,
    this.textColor,
    this.width,
    this.fontSize,
  }) : variant = AppButtonVariant.text,
       color = null,
       elevation = null,
       borderRadius = null,
       size = null,
       foregroundColor = null,
       height = null,
       padding = null;

  @override
  Widget build(BuildContext context) {
    return switch (variant) {
      AppButtonVariant.iconRound => _buildIconRound(),
      AppButtonVariant.text => _buildText(),
      AppButtonVariant.elevated => _buildElevated(),
      AppButtonVariant.outlined => _buildOutlined(),
    };
  }

  Widget _buildText() {
    return icon != null
        ? TextButton(
            onPressed: isLoading ? null : onTap,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                isLoading
                    ? const SizedBox.shrink()
                    : Text(
                        text!,
                        style: TextStyle(
                          color: textColor ?? AppStyle.primary,
                          fontWeight: FontWeight.w700,
                          fontSize: 16.sp,
                        ),
                      ),
                if (!isLoading && icon != null) SizedBox(width: 8.w),
                isLoading
                    ? SizedBox(
                        height: 20.h,
                        width: 20.h,
                        child: CircularProgressIndicator.adaptive(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation(
                            textColor ?? AppStyle.primary,
                          ),
                        ),
                      )
                    : (icon ?? const SizedBox.shrink()),
              ],
            ),
          )
        : TextButton(
            onPressed: isLoading ? null : onTap,
            child: isLoading
                ? SizedBox(
                    height: 20.h,
                    width: 20.h,
                    child: CircularProgressIndicator.adaptive(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation(
                        textColor ?? AppStyle.primary,
                      ),
                    ),
                  )
                : Text(
                    text!,
                    style: TextStyle(
                      color: textColor ?? AppStyle.primary,
                      fontWeight: FontWeight.w600,
                      fontSize: fontSize ?? 16.sp,
                    ),
                  ),
          );
  }

  Widget _buildElevated() {
    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: icon != null
          ? ElevatedButton.icon(
              style:
                  style ??
                  AppButtonStyle.rounded15.copyWith(
                    backgroundColor: MaterialStateProperty.all(
                      color ?? AppStyle.primary,
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          borderRadius ?? 15.r,
                        ),
                      ),
                    ),
                  ),
              onPressed: isLoading ? null : onTap,
              icon: isLoading ? const SizedBox.shrink() : icon!,
              label: isLoading
                  ? SizedBox(
                      height: 20.h,
                      width: 20.h,
                      child: const CircularProgressIndicator.adaptive(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      ),
                    )
                  : Text(text!),
            )
          : ElevatedButton(
              style:
                  style ??
                  AppButtonStyle.rounded15.copyWith(
                    foregroundColor: MaterialStateProperty.all(
                      foregroundColor ?? Colors.white,
                    ),
                    padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          borderRadius ?? 15.r,
                        ),
                      ),
                    ),
                  ),
              onPressed: isLoading ? null : onTap,
              child: isLoading
                  ? SizedBox(
                      height: 20.h,
                      width: 20.h,
                      child: const CircularProgressIndicator.adaptive(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      ),
                    )
                  : Text(
                      text!,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: fontSize ?? 16.sp,
                      ),
                    ),
            ),
    );
  }

  Widget _buildOutlined() {
    return SizedBox(
      width: width ?? double.infinity,
      child: icon != null
          ? OutlinedButton.icon(
              style:
                  style ??
                  OutlinedButton.styleFrom(
                    side: BorderSide(
                      color: color ?? AppStyle.primary,
                      width: 2.w,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(borderRadius ?? 15.r),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                  ),
              onPressed: isLoading ? null : onTap,
              icon: isLoading ? const SizedBox.shrink() : icon!,
              label: isLoading
                  ? SizedBox(
                      height: 20.h,
                      width: 20.h,
                      child: const CircularProgressIndicator.adaptive(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation(AppStyle.primary),
                      ),
                    )
                  : Text(
                      text!,
                      style: TextStyle(
                        color: textColor ?? AppStyle.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: fontSize ?? 16.sp,
                      ),
                    ),
            )
          : OutlinedButton(
              style:
                  style ??
                  OutlinedButton.styleFrom(
                    side: BorderSide(
                      color: color ?? AppStyle.primary,
                      width: 2.w,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(borderRadius ?? 15.r),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                  ),
              onPressed: isLoading ? null : onTap,
              child: isLoading
                  ? SizedBox(
                      height: 20.h,
                      width: 20.h,
                      child: const CircularProgressIndicator.adaptive(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation(AppStyle.primary),
                      ),
                    )
                  : Text(
                      text!,
                      style: TextStyle(
                        color: textColor ?? AppStyle.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: fontSize ?? 16.sp,
                      ),
                    ),
            ),
    );
  }

  Widget _buildIconRound() {
    return InkWell(
      onTap: isLoading ? null : onTap,
      borderRadius: BorderRadius.circular(borderRadius ?? 100.r),
      child: AppMaterialRound(
        color: color ?? AppStyle.white,
        elevation: elevation ?? 2.5,
        child: Padding(
          padding: EdgeInsets.all(padding ?? 8.r),
          child: isLoading
              ? SizedBox(
                  width: size ?? 30.sp,
                  height: size ?? 30.sp,
                  child: CircularProgressIndicator.adaptive(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation(color ?? Colors.black),
                  ),
                )
              : icon!,
        ),
      ),
    );
  }
}
