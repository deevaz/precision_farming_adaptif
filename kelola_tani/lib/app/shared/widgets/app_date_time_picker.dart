import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kelola_tani/app/core/theme/app_fonts.dart';
import 'package:kelola_tani/app/core/theme/app_style.dart';
import 'package:kelola_tani/app/shared/widgets/app_material_round.dart';

class AppDateTimePicker extends StatelessWidget {
  final String title;
  final Rx<DateTime> selectedDate;
  final DateTime? firstDate;
  final DateTime? lastDate;

  const AppDateTimePicker({
    super.key,
    required this.title,
    required this.selectedDate,
    this.firstDate,
    this.lastDate,
  });

  Future<void> _pickDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: firstDate ?? DateTime(2000),
      lastDate: lastDate ?? DateTime(2100),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(selectedDate.value),
      );

      if (pickedTime != null) {
        selectedDate.value = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _pickDateTime(context),
      child: AppMaterialRound(
        paddingValue: 10.r,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10.h,
          children: [
            Row(
              children: [
                Icon(Ionicons.calendar_outline, size: 20, color: AppStyle.dark),
                SizedBox(width: 10.w),
                Text(title, style: AppFonts.lgRegular),
                const Spacer(),
                Icon(Ionicons.time_outline, size: 20, color: AppStyle.dark),
              ],
            ),
            Divider(thickness: 1, color: AppStyle.light),
            SizedBox(
              width: double.infinity,
              child: Obx(() {
                final date = selectedDate.value;

                final formattedDate =
                    "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}";
                final formattedTime =
                    "${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}";

                return Text(
                  "$formattedDate  $formattedTime",
                  textAlign: TextAlign.left,
                  style: AppFonts.lgRegular.copyWith(color: AppStyle.dark),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
