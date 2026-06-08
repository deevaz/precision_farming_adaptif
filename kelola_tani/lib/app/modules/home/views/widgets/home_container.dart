import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/gestures.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kelola_tani/app/core/theme/app_style.dart';
import 'package:kelola_tani/app/modules/auth/controllers/auth_controller.dart';
import 'package:kelola_tani/app/modules/home/controllers/home_controller.dart';
import 'package:kelola_tani/app/shared/widgets/app_button.dart';
import 'package:kelola_tani/app/shared/widgets/app_material_round.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeContainer extends GetView<HomeController> {
  const HomeContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 300.h,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: AppStyle.white,
        ),
        child: AppMaterialRound(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 35.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 25.h),
                Text(
                  'Kelola Tani',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Permudah urusan tani Anda menjadi efisien dan efektif.',
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: AppStyle.grey,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 45.h),
                Flexible(
                  child: AppButton.outlined(
                    borderRadius: 30.r,
                    icon: Icon(Ionicons.logo_google, color: AppStyle.dark),
                    text: 'Masuk dengan Akun Google',
                    textColor: AppStyle.dark,
                    onTap: () => AuthController.to.signInWithGoogle(),
                  ),
                ),
                SizedBox(height: 20.h),
                Text.rich(
                  TextSpan(
                    text: 'By continuing, you agree to',
                    style: TextStyle(fontSize: 12.sp, color: Colors.black),
                    children: <TextSpan>[
                      TextSpan(
                        text: ' Term of Service ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppStyle.primary,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            launchUrl(
                              Uri.parse(
                                'https://docs.google.com/document/d/e/2PACX-1vRLPWwftxTnjpNDafXMWqDzhwt3vXkO75omDCo772m_IDz78RiH360rqDJBU0E6KMowpSoPhp-FrgH4/pub',
                              ),
                              mode: LaunchMode.externalApplication,
                            );
                          },
                      ),
                      TextSpan(
                        text: ' and ',
                        style: TextStyle(color: Colors.black),
                      ),
                      TextSpan(
                        text: ' Privacy Policy Kelola Tani',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppStyle.primary,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            launchUrl(
                              Uri.parse(
                                'https://docs.google.com/document/d/e/2PACX-1vRLPWwftxTnjpNDafXMWqDzhwt3vXkO75omDCo772m_IDz78RiH360rqDJBU0E6KMowpSoPhp-FrgH4/pub',
                              ),
                              mode: LaunchMode.externalApplication,
                            );
                          },
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
