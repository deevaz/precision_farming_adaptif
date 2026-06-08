import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kelola_tani/app/core/theme/app_style.dart';
import 'package:kelola_tani/app/shared/widgets/app_material_round.dart';

class AppImagePicker extends StatelessWidget {
  final File? imageFile;
  final String? imageUrl;
  final VoidCallback onCameraTap;
  final VoidCallback onGalleryTap;
  final VoidCallback? onRemoveTap;

  const AppImagePicker({
    super.key,
    this.imageFile,
    this.imageUrl,
    required this.onCameraTap,
    required this.onGalleryTap,
    this.onRemoveTap,
  });

  @override
  Widget build(BuildContext context) {
    bool hasImage =
        imageFile != null || (imageUrl != null && imageUrl!.isNotEmpty);

    return InkWell(
      onTap: () => _showPickerBottomSheet(context),
      borderRadius: BorderRadius.circular(15.r),
      child: AppMaterialRound(
        child: Container(
          width: 120.w,
          height: 120.w,
          decoration: BoxDecoration(
            color: AppStyle.white,
            borderRadius: BorderRadius.circular(15.r),
            border: Border.all(
              color: hasImage ? AppStyle.primary : Colors.grey[300]!,
              width: 1,
            ),
            image: hasImage
                ? DecorationImage(
                    image: imageFile != null
                        ? FileImage(imageFile!) as ImageProvider
                        : NetworkImage(imageUrl!),
                    fit: BoxFit.cover,
                  )
                : null,
          ),
          child: Stack(
            children: [
              if (!hasImage)
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Ionicons.image_outline,
                        size: 30.r,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        "Tambah",
                        style: TextStyle(fontSize: 10.sp, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              if (hasImage && onRemoveTap != null)
                Positioned(
                  right: 4.w,
                  top: 4.w,
                  child: GestureDetector(
                    onTap: onRemoveTap,
                    child: Container(
                      padding: EdgeInsets.all(4.r),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.close, size: 14.r, color: Colors.white),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  // Bottom Sheet Pilihan
  void _showPickerBottomSheet(BuildContext context) {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(20.r),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Ambil Gambar Dari",
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildOption(
                  icon: Ionicons.camera_outline,
                  label: "Kamera",
                  onTap: () {
                    Get.back();
                    onCameraTap();
                  },
                ),
                _buildOption(
                  icon: Ionicons.images_outline,
                  label: "Galeri",
                  onTap: () {
                    Get.back();
                    onGalleryTap();
                  },
                ),
              ],
            ),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }

  Widget _buildOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(15.r),
            decoration: BoxDecoration(
              color: AppStyle.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppStyle.primary, size: 30.r),
          ),
          SizedBox(height: 8.h),
          Text(label, style: TextStyle(fontSize: 14.sp)),
        ],
      ),
    );
  }
}
