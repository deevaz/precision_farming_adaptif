import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kelola_tani/app/core/theme/app_fonts.dart';
import 'package:kelola_tani/app/core/theme/app_style.dart';
import 'package:kelola_tani/app/shared/widgets/app_material_round.dart';

class DashboardSectionCard extends StatelessWidget {
  final String title;
  final String dateRangeLabel;
  final VoidCallback onDateTap;
  final Widget content;

  const DashboardSectionCard({
    super.key,
    required this.title,
    required this.dateRangeLabel,
    required this.onDateTap,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return AppMaterialRound(
      paddingValue: 16.r,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: AppFonts.lgBold),
                    SizedBox(height: 4.h),
                    Text(
                      dateRangeLabel,
                      style: AppFonts.smMedium.copyWith(
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(width: 12.w),

              InkWell(
                onTap: onDateTap,
                borderRadius: BorderRadius.circular(8.r),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppStyle.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.calendar_month_outlined,
                        color: AppStyle.primary,
                        size: 18.sp,
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        'Filter',
                        style: AppFonts.smMedium.copyWith(
                          color: AppStyle.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          content,
        ],
      ),
    );
  }
}
