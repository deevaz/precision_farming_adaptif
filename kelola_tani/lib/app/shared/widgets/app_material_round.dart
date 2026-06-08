import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kelola_tani/app/core/theme/app_style.dart';

class AppMaterialRound extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final double paddingValue;
  final double? radius;
  final double? elevation;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final Color? color;
  final Color? borderColor;
  const AppMaterialRound({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.radius,
    this.color,
    this.elevation,
    this.paddingValue = 0,
    this.onTap,
    this.onLongPress,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Material(
        color: color ?? AppStyle.white,
        borderRadius: BorderRadius.circular(radius ?? 15.r),
        elevation: elevation ?? 2.5,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius ?? 15.r),
            color: color ?? Colors.transparent,
            border: Border.all(color: borderColor ?? Colors.transparent),
          ),
          child: Padding(padding: EdgeInsets.all(paddingValue), child: child),
        ),
      ),
    );
  }
}
