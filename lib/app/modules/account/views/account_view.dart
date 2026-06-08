import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kelola_tani/app/core/theme/app_fonts.dart';
import 'package:kelola_tani/app/core/theme/app_style.dart';
import 'package:kelola_tani/app/modules/account/views/privacy_policy_view.dart';
import 'package:kelola_tani/app/modules/auth/controllers/auth_controller.dart';
import 'package:kelola_tani/app/services/dialog_service.dart';
import 'package:kelola_tani/app/shared/widgets/app_button.dart';
import 'package:kelola_tani/app/shared/widgets/app_material_round.dart';

import '../controllers/account_controller.dart';

class AccountView extends GetView<AccountController> {
  const AccountView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 80.h,
            decoration: BoxDecoration(
              color: AppStyle.primary,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30.r),
                bottomRight: Radius.circular(30.r),
              ),
            ),
            child: Center(
              child: Text(
                'Akun',
                style: AppFonts.xlSemiBold.copyWith(color: AppStyle.white),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15.r),
            child: Column(
              spacing: 15.h,
              children: [
                AppMaterialRound(
                  height: 190.h,
                  width: double.infinity,
                  paddingValue: 15.r,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: controller.photoURL != null
                            ? NetworkImage(controller.photoURL!)
                            : null,
                        child: controller.photoURL == null
                            ? Text(
                                FirebaseAuth.instance.currentUser?.displayName
                                        ?.substring(0, 1)
                                        .toUpperCase() ??
                                    '?',
                                style: const TextStyle(fontSize: 24),
                              )
                            : null,
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        controller.user?.displayName ?? 'User',
                        style: AppFonts.xlBold,
                      ),
                      // Tambahan Email
                      Text(
                        controller.user?.email ?? 'Tidak ada email',
                        style: AppFonts.mdRegular.copyWith(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                AppMaterialRound(
                  child: ListTile(
                    leading: const Icon(Icons.build),
                    title: Text('Perawatan Alat', style: AppFonts.lgSemiBold),
                    onTap: () {},
                  ),
                ),
                AppMaterialRound(
                  child: ListTile(
                    leading: const Icon(Icons.privacy_tip_outlined),
                    title: Text(
                      'Kebijakan Privasi',
                      style: AppFonts.lgSemiBold,
                    ),
                    onTap: () {
                      Get.to(() => const PrivacyPolicyView());
                    },
                  ),
                ),
                SizedBox(height: 15.h),
                AppButton(
                  onTap: () => DialogService.confirmation(
                    title: 'Logout',
                    message: 'Apakah Anda yakin ingin keluar?',
                    onConfirm: () => AuthController.to.logout(),
                  ),
                  text: 'Keluar',
                  // ...
                ),
                TextButton(
                  onPressed: () {
                    DialogService.confirmation(
                      title: 'Hapus Akun',
                      message: 'Apakah Anda yakin ingin menghapus akun?',
                      onConfirm: () => AuthController.to.deleteAccount(),
                    );
                  },
                  child: Text(
                    'Hapus Akun',
                    style: AppFonts.mdSemiBold.copyWith(color: AppStyle.danger),
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  'Versi 1.0.1',
                  style: AppFonts.smRegular.copyWith(color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
