import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kelola_tani/app/core/theme/app_fonts.dart';
import 'package:kelola_tani/app/core/theme/app_style.dart';
import 'package:kelola_tani/app/shared/widgets/app_material_round.dart';

class DetailCard extends StatelessWidget {
  final String title;
  final String value;
  final String? data;
  final String footer;
  final IconData icon;
  final Color color;

  const DetailCard({
    super.key,
    required this.title,
    required this.value,
    this.data,
    required this.footer,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AppMaterialRound(
        color: AppStyle.white,
        paddingValue: 8.r,
        radius: 15.r,
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: AppFonts.smRegular),
                Text(value, style: AppFonts.xxlBold),
                Text(footer, style: AppFonts.xsMedium),
              ],
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Icon(icon, color: color, size: data != null ? 45.sp : 50.sp),
                const Spacer(),
                if (data != null) Text(data!, style: AppFonts.xsRegular),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
