import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kelola_tani/app/core/theme/app_fonts.dart';
import 'package:kelola_tani/app/core/theme/app_style.dart';
import 'package:kelola_tani/app/modules/device_detail/controllers/ai_controller.dart';
import 'package:kelola_tani/app/shared/widgets/app_button.dart';
import 'package:kelola_tani/app/shared/widgets/app_header.dart';
import 'package:kelola_tani/app/shared/widgets/app_material_round.dart';
import 'package:kelola_tani/app/shared/widgets/app_text_field.dart';

class AiView extends GetView<AiController> {
  const AiView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppHeader(
            leading: Text(
              'Rekomendasi Nutrisi',
              style: AppFonts.xlSemiBold.copyWith(color: AppStyle.white),
            ),
            trailing: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: AppStyle.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(
                  color: AppStyle.white.withOpacity(0.3),
                  width: 1,
                ),
              ),

              child: Center(
                child: Text(
                  'Perangkat: ${controller.deviceName}',
                  style: AppFonts.smBold.copyWith(color: AppStyle.white),
                ),
              ),
            ),
          ),
          Expanded(child: _buildDashboardGrid()),
        ],
      ),
    );
  }
}

Widget _buildDashboardGrid() {
  final controller = Get.put(AiController());
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 15.h,
      children: [
        Text('Masukkan Umur Tanaman ', style: AppFonts.mdSemiBold),
        AppTextField(
          title: 'Contoh: 46 (dalam hari)',
          hintText: 'Masukkan umur tanaman dalam hari',
        ),
        AppButton(
          onTap: () => controller.toggleRecommendations(),
          text: 'Hitung Rekomendasi',
        ),
        Obx(
          () => Visibility(
            visible: controller.showRecommendations.value,
            child: AppMaterialRound(
              paddingValue: 16.r,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Rekomendasi Nutrisi (AI-Adaptive)',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text('Target EC: 1.4 mS/cm (Suhu Panas: 31°C)'),
                  const Divider(),

                  Text(
                    'Analisis Kondisi:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Suhu terdeteksi tinggi (31°C), memicu laju transpirasi tanaman yang cepat. '
                    'Sistem menurunkan Target EC guna mencegah akumulasi garam (Nutrient Burn) '
                    'karena tanaman menyerap lebih banyak air untuk pendinginan suhu.',
                    style: TextStyle(fontSize: 12.sp, color: Colors.black87),
                  ),

                  SizedBox(height: 12.h),
                  Text(
                    'Takaran per 100L Air:',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  Text(
                    'Stok A: 350 ml | Stok B: 350 ml',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp,
                      color: Colors.green[700],
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
