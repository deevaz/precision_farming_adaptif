import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kelola_tani/app/core/theme/app_style.dart';
import 'package:kelola_tani/app/shared/widgets/app_material_round.dart';

class AppAddImage extends StatelessWidget {
  final GetxController c;
  final bool isCamera;
  final bool? isSelected;
  final int? size;

  const AppAddImage({
    super.key,
    this.isCamera = true,
    required this.c,
    this.isSelected,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return
    // Obx( () =>
    AppMaterialRound(
      child: Container(
        width: size != null ? size!.w : double.infinity,
        height: size != null ? size!.h - 50 : 150.h,
        decoration: isSelected == true
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                image: DecorationImage(
                  image: AssetImage('assets/images/sample_image.png'),
                  fit: BoxFit.cover,
                ),
              )
            : BoxDecoration(borderRadius: BorderRadius.circular(10.r)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(
                Ionicons.camera_outline,
                size: 40.sp,
                color:
                    // c.selectedImage.value != null
                    //     ? Colors.transparent
                    //     :
                    AppStyle.dark,
              ),
              onPressed: () {
                Get.defaultDialog(
                  title: 'select-image'.tr,
                  titleStyle: TextStyle(
                    fontSize: 20.sp,
                    color: AppStyle.dark,
                    fontWeight: FontWeight.bold,
                  ),
                  content: Column(
                    children: [
                      ListTile(
                        leading: Icon(Ionicons.camera_outline),
                        title: Text('camera'.tr),
                        onTap: () {
                          Get.back();
                        },
                      ),
                      ListTile(
                        leading: Icon(Ionicons.image_outline),
                        title: Text('gallery'.tr),
                        onTap: () {
                          Get.back();
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
            Text(
              'add-picture'.tr,
              style: TextStyle(
                fontSize: 12.sp,
                color: AppStyle.dark,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      // ),
    );
  }
}
