import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kelola_tani/app/shared/widgets/app_material_round.dart';

class AppSearch extends StatelessWidget {
  final TextEditingController controller;
  final Function(String)? onChanged;
  final String? hintText;

  const AppSearch({
    super.key,
    required this.controller,
    this.onChanged,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45.h,
      child: AppMaterialRound(
        child: ValueListenableBuilder<TextEditingValue>(
          valueListenable: controller,
          builder: (context, value, child) {
            return TextField(
              controller: controller,
              onChanged: onChanged,

              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                hintText: hintText ?? "Search...",
                prefixIcon: Icon(Icons.search, size: 22.r),

                suffixIcon: value.text.isNotEmpty
                    ? IconButton(
                        icon: Icon(Icons.clear, size: 20.r, color: Colors.grey),
                        onPressed: () {
                          controller.clear();
                          onChanged?.call('');
                        },

                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      )
                    : null,

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.r),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
                filled: true,
                fillColor: Colors.white,
              ),
            );
          },
        ),
      ),
    );
  }
}
