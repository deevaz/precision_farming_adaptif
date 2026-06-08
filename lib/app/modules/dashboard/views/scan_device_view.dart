import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kelola_tani/app/core/theme/app_fonts.dart';
import 'package:kelola_tani/app/core/theme/app_style.dart';
import 'package:kelola_tani/app/core/utils/result_state.dart';
import 'package:kelola_tani/app/modules/dashboard/controllers/scan_device_controller.dart';
import 'package:kelola_tani/app/shared/widgets/app_button.dart';
import 'package:kelola_tani/app/shared/widgets/app_text_field.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanDeviceView extends StatelessWidget {
  const ScanDeviceView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ScanDeviceController>();

    return Scaffold(
      backgroundColor: AppStyle.primary,
      body: Stack(
        children: [
          Container(
            height: 320.h,
            width: 1.sw,
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 60.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    AppButton.icon(
                      elevation: 0,
                      color: AppStyle.white.withOpacity(0.3),
                      onTap: () => Get.back(),
                      icon: Icon(Ionicons.chevron_back, color: AppStyle.white),
                    ),
                    SizedBox(width: 20.h),
                    Text(
                      'Tambahkan Perangkat',
                      style: AppFonts.xxlBold.copyWith(color: AppStyle.surface),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Get.height - 180.h,
              width: 1.sw,
              decoration: BoxDecoration(
                color: AppStyle.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.r),
                  topRight: Radius.circular(40.r),
                ),
              ),
              padding: EdgeInsets.all(24.r),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Arahkan ke Kode QR Perangkat',
                      style: AppFonts.xlBold,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16.h),
                    Container(
                      height: 250.h,
                      width: 250.h,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(24.r),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(24.r),
                        child: Obx(
                          () => controller.isScanned
                              ? Center(
                                  child: Icon(
                                    Ionicons.checkmark_circle,
                                    color: AppStyle.primary,
                                    size: 80.sp,
                                  ),
                                )
                              : MobileScanner(
                                  onDetect: (capture) {
                                    final barcodes = capture.barcodes;
                                    print(
                                      'Barcodes detected: ${barcodes.length}',
                                    );
                                    for (final barcode in barcodes) {
                                      print('Raw value: ${barcode.rawValue}');
                                      print('Format: ${barcode.format}');
                                    }
                                    if (barcodes.isNotEmpty) {
                                      final value =
                                          barcodes.first.rawValue ?? '';
                                      if (value.isNotEmpty) {
                                        controller.onQRDetected(value);
                                      }
                                    }
                                  },
                                ),
                        ),
                      ),
                    ),

                    SizedBox(height: 20.h),

                    Obx(() {
                      final state = controller.scanState.value;
                      if (state is ResultSuccess<String>) {
                        return Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(12.r),
                              decoration: BoxDecoration(
                                color: AppStyle.primary.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(
                                  color: AppStyle.primary.withOpacity(0.3),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Ionicons.checkmark_circle,
                                    color: AppStyle.primary,
                                  ),
                                  SizedBox(width: 8.w),
                                  Expanded(
                                    child: Text(
                                      'ID: ${state.data}',
                                      style: AppFonts.smRegular.copyWith(
                                        color: AppStyle.primary,
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: controller.resetScan,
                                    child: Icon(
                                      Ionicons.refresh,
                                      color: AppStyle.primary,
                                      size: 20.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 16.h),
                            AppTextField(
                              controller: controller.deviceNameController,
                              title: 'Nama Perangkat',
                              hintText: 'contoh: Perangkat Kebun Paprika',
                            ),
                          ],
                        );
                      }
                      return Text(
                        'Belum ada perangkat terdeteksi',
                        style: AppFonts.smRegular.copyWith(color: Colors.grey),
                      );
                    }),

                    SizedBox(height: 24.h),
                    Obx(
                      () => AppButton(
                        onTap: controller.isLoading
                            ? null
                            : controller.connectDevice,
                        text: controller.isLoading
                            ? 'Menghubungkan...'
                            : 'Hubungkan',
                        width: double.infinity,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
