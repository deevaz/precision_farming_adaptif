import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kelola_tani/app/core/utils/result_state.dart';
import 'package:kelola_tani/app/shared/widgets/app_button.dart';
import 'package:kelola_tani/app/services/snackbar_service.dart';
import 'package:kelola_tani/app/shared/widgets/app_text_field.dart';

import '../controllers/auth_controller.dart';

class AuthView extends GetView<AuthController> {
  const AuthView({super.key});
  @override
  Widget build(BuildContext context) {
    final bool isLogin = (Get.arguments is bool) ? Get.arguments as bool : true;
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: 15.w,
          vertical: isLogin ? 270.h : 100.h,
        ),
        child: Form(
          key: controller.formKey,
          child: Column(
            spacing: 8.h,
            children: [
              Text(
                isLogin ? 'Masuk' : 'Daftar',
                style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
              ),
              Text(
                isLogin ? 'Masuk ke akun Anda' : 'Daftar untuk membuat akun',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.sp),
              ),
              SizedBox(height: 25.h),
              Visibility(
                visible: !isLogin,
                child: Column(
                  children: [
                    SizedBox(height: 10.h),
                    AppTextField(
                      title: 'Nama Lengkap',
                      hintText: 'Masukkan nama lengkap Anda',
                      controller: controller.nameController,
                    ),
                  ],
                ),
              ),
              AppTextField(
                title: 'Username',
                hintText: 'Masukkan username Anda',
                controller: controller.usernameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Username tidak boleh kosong';
                  }
                  return null;
                },
              ),
              Visibility(
                visible: !isLogin,
                child: AppTextField(
                  title: 'Email',
                  hintText: 'Masukkan email Anda',
                  controller: controller.emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email tidak boleh kosong';
                    }
                    if (!GetUtils.isEmail(value)) {
                      return 'Email tidak valid';
                    }
                    return null;
                  },
                ),
              ),
              AppTextField(
                title: 'Password',
                hintText: 'Masukkan password Anda',
                controller: controller.passwordController,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password tidak boleh kosong';
                  }
                  if (value.length < 6) {
                    return 'Password minimal 6 karakter';
                  }
                  return null;
                },
              ),
              Visibility(
                visible: !isLogin,
                child: AppTextField(
                  title: 'Konfirmasi Password',
                  hintText: 'Masukkan kembali password Anda',
                  obscureText: true,
                  controller: controller.confirmPasswordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Konfirmasi password tidak boleh kosong';
                    }
                    if (value != controller.passwordController.text) {
                      return 'Password tidak cocok';
                    }
                    return null;
                  },
                ),
              ),
              Visibility(
                visible: isLogin,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: AppButton.text(
                    onTap: () {
                      // DialogService.input(
                      //   title: 'enter-email'.tr,
                      //   hintText: 'example@email.com',
                      //   keyboardType: TextInputType.emailAddress,
                      //   onConfirm: (String value) {
                      //     if (value.isNotEmpty) {
                      //       Get.back();
                      //       controller.resetPassword(
                      //         email: value.trim(),
                      //         onSuccess: () => SnackbarService.info(
                      //           'success'.tr,
                      //           'password-reset-success'.tr,
                      //         ),
                      //         onFailed: (message) =>
                      //             SnackbarService.error('error'.tr, message),
                      //       );
                      //     } else {
                      //       SnackbarService.warning(
                      //         'Oops',
                      //         'input-cannot-be-empty'.tr,
                      //       );
                      //     }
                      //   },
                      // );
                    },
                    text: 'Lupa Password?',
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Obx(
                () => AppButton(
                  isLoading: controller.loginState.value is ResultLoading,
                  onTap: () {
                    if (isLogin) {
                      controller.login(
                        onFailed: (message) =>
                            SnackbarService.error('Login Gagal', message),
                        onSuccess: () => SnackbarService.success(
                          'Berhasil',
                          'Selamat datang!',
                        ),
                      );
                    } else {
                      controller.register(
                        onFailed: (message) =>
                            SnackbarService.error('Registrasi Gagal', message),
                        onSuccess: () => SnackbarService.success(
                          'Berhasil',
                          'Akun berhasil dibuat!',
                        ),
                      );
                    }
                  },
                  text: isLogin ? 'Masuk' : 'Daftar',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
