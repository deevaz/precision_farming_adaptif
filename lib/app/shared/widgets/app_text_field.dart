import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kelola_tani/app/core/theme/app_style.dart';

class AppTextField extends StatefulWidget {
  final String title;
  final String hintText;
  final TextEditingController? controller;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final TextInputType inputType;
  final bool isPrice;
  final bool obscureText;
  final String? Function(String?)? validator;

  const AppTextField({
    super.key,
    required this.title,
    this.controller,
    this.hintText = '',
    this.prefixIcon,
    this.isPrice = false,
    this.suffixIcon,
    this.inputType = TextInputType.text,
    this.obscureText = false,
    this.validator,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool _isObscure;

  @override
  void initState() {
    super.initState();
    _isObscure = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      elevation: 2,
      child: TextFormField(
        controller: widget.controller,
        keyboardType: widget.inputType,
        obscureText: _isObscure,
        validator: widget.validator,
        inputFormatters: widget.isPrice
            ? [
                MoneyInputFormatter(
                  leadingSymbol: 'Rp ',
                  thousandSeparator: ThousandSeparator.Period,
                  mantissaLength: 0,
                ),
              ]
            : null,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.never,

          prefixIcon: widget.prefixIcon != null
              ? Icon(widget.prefixIcon, color: AppStyle.dark)
              : null,

          suffixIcon: widget.obscureText
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  },
                  icon: Icon(
                    _isObscure ? Icons.visibility_off : Icons.visibility,
                    color: AppStyle.dark.withOpacity(0.6),
                  ),
                )
              : (widget.suffixIcon != null
                    ? Icon(widget.suffixIcon, color: AppStyle.dark)
                    : null),

          label: Text(widget.title),
          labelStyle: TextStyle(fontSize: 14.sp, color: AppStyle.dark),
          hintText: widget.hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.sp),
            borderSide: BorderSide.none,
          ),
          filled: true,
          contentPadding: EdgeInsets.all(16.sp),
          fillColor: AppStyle.white,

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: BorderSide.none,
          ),

          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: const BorderSide(color: Colors.red, width: 1.5),
          ),

          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: const BorderSide(color: Colors.red, width: 2),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: BorderSide(color: AppStyle.primary, width: 1.5),
          ),

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
