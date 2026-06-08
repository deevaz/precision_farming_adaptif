import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kelola_tani/app/core/theme/app_button_style.dart';
import 'package:kelola_tani/app/core/theme/app_fonts.dart';
import 'package:kelola_tani/app/core/theme/app_style.dart';
import 'package:kelola_tani/app/services/snackbar_service.dart';
import 'package:kelola_tani/app/shared/widgets/app_button.dart';
import 'package:kelola_tani/app/shared/widgets/app_material_round.dart';

class DialogService {
  static void success({
    required String message,
    required VoidCallback onConfirm,
  }) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: AppMaterialRound(
          paddingValue: 20.r,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Ionicons.checkmark_circle,
                color: AppStyle.success,
                size: 60.sp,
              ),
              SizedBox(height: 15.h),
              Text('success'.tr, style: AppFonts.lgBold),
              SizedBox(height: 8.h),
              Text(
                message,
                textAlign: TextAlign.center,
                style: AppFonts.smRegular.copyWith(color: Colors.grey.shade700),
              ),
              SizedBox(height: 20.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppStyle.success,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  onPressed: onConfirm,
                  child: Text('OK', style: TextStyle(color: AppStyle.white)),
                ),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  static void showInfo({
    required String title,
    required String message,
    VoidCallback? onConfirm,
  }) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: AppMaterialRound(
          paddingValue: 20.r,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Ionicons.information_circle,
                color: AppStyle.primary,
                size: 60.sp,
              ),
              SizedBox(height: 15.h),
              Text(title, style: AppFonts.lgBold, textAlign: TextAlign.center),
              SizedBox(height: 8.h),
              Text(
                message,
                textAlign: TextAlign.center,
                style: AppFonts.smRegular.copyWith(color: Colors.grey.shade700),
              ),
              SizedBox(height: 20.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppStyle.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  onPressed: onConfirm ?? () => Get.back(),
                  child: Text('OK', style: TextStyle(color: AppStyle.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void error({
    required String title,
    required String message,
    VoidCallback? onConfirm,
  }) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: AppMaterialRound(
          paddingValue: 20.r,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Ionicons.close_circle, color: AppStyle.danger, size: 60.sp),
              SizedBox(height: 15.h),
              Text(title == '' ? 'error'.tr : title, style: AppFonts.lgBold),
              SizedBox(height: 8.h),
              Text(
                message,
                textAlign: TextAlign.center,
                style: AppFonts.smRegular.copyWith(color: Colors.grey.shade700),
              ),
              SizedBox(height: 20.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppStyle.danger,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  onPressed: onConfirm ?? () => Get.back(),
                  child: Text('OK', style: TextStyle(color: AppStyle.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void confirmation({
    required String title,
    required String message,
    required VoidCallback onConfirm,
    VoidCallback? onCancel,
  }) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: AppMaterialRound(
          paddingValue: 20.r,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Ionicons.help_circle, color: Colors.orange, size: 60.sp),
              SizedBox(height: 15.h),
              Text(title, style: AppFonts.lgBold, textAlign: TextAlign.center),
              SizedBox(height: 8.h),
              Text(
                message,
                textAlign: TextAlign.center,
                style: AppFonts.smRegular.copyWith(color: Colors.grey.shade700),
              ),
              SizedBox(height: 20.h),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: AppStyle.grey),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      onPressed: onCancel ?? () => Get.back(),
                      child: Text(
                        'Tidak',
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppStyle.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      onPressed: onConfirm,
                      child: Text(
                        'Iya',
                        style: TextStyle(color: AppStyle.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void showDetail({
    required String title,
    required Map<String, String> details,
    String? note,
    String? noteLabel,
  }) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.r),
        ),
        child: AppMaterialRound(
          paddingValue: 24.r,
          radius: 30.r,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: AppFonts.lgBold.copyWith(fontSize: 22.sp),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: Icon(
                      Icons.close,
                      color: Colors.grey.shade400,
                      size: 24.sp,
                    ),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),

              const Divider(),
              ...details.entries
                  .map(
                    (e) => Padding(
                      padding: EdgeInsets.only(bottom: 16.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            e.key,
                            style: AppFonts.xsRegular.copyWith(
                              color: AppStyle.grey,
                              letterSpacing: 0.5,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            e.value,
                            style: AppFonts.mdBold.copyWith(
                              color: AppStyle.dark,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),

              if (note != null && note.isNotEmpty) ...[
                Text(
                  noteLabel ?? 'Catatan Tambahan',
                  style: AppFonts.mdMedium.copyWith(color: AppStyle.primary),
                ),
                SizedBox(height: 8.h),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16.r),
                  decoration: BoxDecoration(
                    color: AppStyle.light,
                    borderRadius: BorderRadius.circular(15.r),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Text(
                    note,
                    style: AppFonts.smRegular.copyWith(
                      height: 1.5,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ),
              ],

              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }

  static void input({
    required String title,
    required String hintText,
    required Function(String) onConfirm,
    String? message,
    String? initialValue,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    VoidCallback? onCancel,
  }) {
    final TextEditingController controller = TextEditingController(
      text: initialValue,
    );

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: AppMaterialRound(
          paddingValue: 20.r,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(title, style: AppFonts.lgBold, textAlign: TextAlign.center),
              if (message != null) ...[
                SizedBox(height: 8.h),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: AppFonts.smRegular.copyWith(
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
              SizedBox(height: 15.h),
              TextField(
                controller: controller,
                keyboardType: keyboardType,
                maxLines: maxLines,
                style: AppFonts.mdMedium,
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: AppFonts.smRegular.copyWith(color: Colors.grey),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 15.w,
                    vertical: 12.h,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: BorderSide(color: AppStyle.grey),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: BorderSide(color: AppStyle.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: BorderSide(color: AppStyle.primary, width: 1.5),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: AppStyle.grey),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      onPressed: onCancel ?? () => Get.back(),
                      child: Text(
                        'cancel'.tr,
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppStyle.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      onPressed: () {
                        onConfirm(controller.text);
                      },
                      child: Text(
                        'Simpan',
                        style: TextStyle(color: AppStyle.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void controlMode({
    required RxString currentMode,
    required RxString pumpMode,
    required Function(String) onModeSelected,
    required Function(String) onPumpModeSelected,
  }) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.r),
        ),
        child: AppMaterialRound(
          paddingValue: 24.r,
          radius: 30.r,

          child: Obx(
            () => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Kendali Pompa',
                  style: AppFonts.lgBold.copyWith(fontSize: 24.sp),
                ),
                SizedBox(height: 30.h),
                Row(
                  children: [
                    Text('Mode:', style: AppFonts.mdMedium),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: _buildModeButton(
                        label: 'Manual',
                        isSelected: currentMode.value == 'Manual',
                        onTap: () => onModeSelected('Manual'),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: _buildModeButton(
                        label: 'Otomatis',
                        isSelected: currentMode.value == 'Otomatis',
                        onTap: () {
                          onModeSelected('Otomatis');
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),

                Visibility(
                  visible: currentMode.value != 'Otomatis',
                  child: AppButton(
                    onTap: () {
                      if (pumpMode.value == 'Hidup') {
                        onPumpModeSelected('Mati');
                      } else {
                        onPumpModeSelected('Hidup');
                      }
                    },
                    text: pumpMode.value == 'Hidup'
                        ? 'Matikan Pompa'
                        : 'Hidupkan Pompa',
                    width: double.infinity,
                    style: AppButtonStyle.rounded15.copyWith(
                      backgroundColor: WidgetStateProperty.all(
                        pumpMode.value == 'Hidup'
                            ? AppStyle.danger
                            : AppStyle.primary,
                      ),
                      foregroundColor: WidgetStateProperty.all(AppStyle.white),
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Widget _buildModeButton({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return AppButton(
      onTap: onTap,
      text: label,
      height: 45.h,
      textColor: isSelected ? AppStyle.white : AppStyle.primary,
      fontSize: 15.sp,
      style: AppButtonStyle.rounded15.copyWith(
        backgroundColor: WidgetStateProperty.all(
          isSelected ? AppStyle.primary : AppStyle.light,
        ),
        foregroundColor: WidgetStateProperty.all(
          isSelected ? AppStyle.white : AppStyle.primary,
        ),
        padding: WidgetStateProperty.all(
          EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        ),
      ),
    );
  }

  static void noteForm({
    required String title,
    required DateTime initialTime,
    required String initialContent,
    required Function(DateTime selectedDateTime, String content) onConfirm,
  }) {
    final TextEditingController contentController = TextEditingController(
      text: initialContent,
    );

    final Rx<DateTime> selectedDateTime = initialTime.obs;

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.r),
        ),
        child: AppMaterialRound(
          paddingValue: 24.r,
          radius: 30.r,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(title, style: AppFonts.lgBold.copyWith(fontSize: 24.sp)),
                SizedBox(height: 25.h),

                GestureDetector(
                  onTap: () async {
                    DateTime? date = await showDatePicker(
                      context: Get.context!,
                      initialDate: selectedDateTime.value,
                      firstDate: DateTime(2025),
                      lastDate: DateTime(2101),
                    );

                    if (date != null) {
                      TimeOfDay? time = await showTimePicker(
                        context: Get.context!,
                        initialTime: TimeOfDay.fromDateTime(
                          selectedDateTime.value,
                        ),
                      );

                      if (time != null) {
                        selectedDateTime.value = DateTime(
                          date.year,
                          date.month,
                          date.day,
                          time.hour,
                          time.minute,
                        );
                      }
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 14.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Ionicons.calendar_outline,
                          size: 20.sp,
                          color: AppStyle.primary,
                        ),
                        SizedBox(width: 12.w),
                        Obx(
                          () => Text(
                            "${selectedDateTime.value.day}/${selectedDateTime.value.month}/${selectedDateTime.value.year} - ${TimeOfDay.fromDateTime(selectedDateTime.value).format(Get.context!)}",
                            style: AppFonts.mdBold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 16.h),

                TextField(
                  controller: contentController,
                  maxLines: 4,
                  style: AppFonts.mdMedium,
                  decoration: InputDecoration(
                    hintText: 'Masukkan aktivitas (Contoh: Leaching NPK)',
                    hintStyle: AppFonts.smRegular.copyWith(
                      color: Colors.grey.shade600,
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(height: 25.h),

                AppButton(
                  onTap: () {
                    if (contentController.text.isNotEmpty) {
                      onConfirm(selectedDateTime.value, contentController.text);
                      Get.back();
                    } else {
                      SnackbarService.warning(
                        'Peringatan',
                        'Catatan jangan kosong ya',
                      );
                    }
                  },
                  text: 'Simpan',
                  width: double.infinity,
                  style: AppButtonStyle.rounded15.copyWith(
                    backgroundColor: WidgetStateProperty.all(AppStyle.primary),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
