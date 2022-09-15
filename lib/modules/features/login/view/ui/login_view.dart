// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:java_code/modules/features/login/controllers/login_controler.dart';
import 'package:java_code/modules/features/no_connecntion/view/ui/no_connection_view.dart';
import 'package:java_code/modules/global_controllers/check_connection_controller.dart';
import '/modules/features/login/view/components/title_textfield.dart';
import '/config/routes/app_routes.dart';
import '/config/themes/colours.dart';
import '/constant/core/assets_const.dart';
import '/modules/features/login/view/components/input_textfield.dart';

// ignore: must_be_immutable
class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);

  // final GlobalKey<FormState>?
  // Form key
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void validation() {
    if (formKey.currentState!.validate()) {
      print('Email valid');
    }
  }

  @override
  Widget build(BuildContext context) {
    /// MEMANGGIL LoginController
    Get.put(LoginController());
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colours.bgColors,
        body: Obx(
          () => ConnectionManagerController.to.connectionType.value != 0
              ? SafeArea(
                  // BUNGKUS DENGAN WIDGET YANG NAMANYA FORM, PASANG FORM KEY
                  child: ListView(
                    children: [
                      /// LOGO JAVACODE
                      Container(
                        height: 91.h,
                        margin: EdgeInsets.only(
                          top: 80.sp,
                          bottom: 121.sp,
                          left: 79.sp,
                          right: 79.sp,
                        ),
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(AssetConts.drawJavaCode),
                          ),
                        ),
                      ),

                      /// JUDUL HALAMAN DEPAN
                      Container(
                        margin: EdgeInsets.only(left: 46.sp),
                        child: Text(
                          "Masuk untuk melanjutkan!",
                          style: GoogleFonts.montserrat(
                            color: Colours.darkBlack,
                            fontWeight: FontWeight.w600,
                            fontSize: 22.sp,
                          ),
                        ),
                      ),

                      /// TITLE EMAIL DAN TEXTFIELD
                      SizedBox(height: 40.h),
                      TittleTextfield(name: "Alamat Email"),
                      SizedBox(height: 5.sp),
                      InputTextField(
                        controller: LoginController.to.emailLoginC,
                        hintText: "lorem@gmail.com",
                        isPassword: false,
                        formKey: formKey,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (!GetUtils.isEmail(value!)) {
                            return 'email tidak valid';
                          }
                          return '';
                        },
                      ),

                      /// TITLE PASSWORD DAN TEXTFIELD
                      SizedBox(height: 40.h),
                      TittleTextfield(name: "Kata Sandi"),
                      SizedBox(height: 5.h),
                      InputTextField(
                        controller: LoginController.to.passLoginC,
                        hintText: "**************",
                        isPassword: true,
                        isObscuretext: LoginController.to.isHidden.value,
                        textInputAction: TextInputAction.done,
                      ),

                      /// BUTTON MASUK
                      SizedBox(height: 40.h),
                      Obx(
                        () => Container(
                          height: 44.h,
                          margin: EdgeInsets.symmetric(horizontal: 46.sp),
                          child: ElevatedButton(
                            onPressed: () {
                              validation();
                              if (LoginController.to.isLoading.isFalse) {
                                LoginController.to.postLogin();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 5.sp,
                              primary: Colours.green2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.r),
                              ),
                            ),
                            child: Text(
                              LoginController.to.isLoading.isFalse
                                  ? "Masuk"
                                  : 'Loading...',
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w800,
                                color: Colours.white,
                              ),
                            ),
                          ),
                        ),
                      ),

                      /// BELUM PUNYA AKUN
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Belum Punya Akun ?"),
                          TextButton(
                            onPressed: () {
                              Get.toNamed(AppRoutes.registerView);
                            },
                            child: const Text('Sign Up'),
                          ),
                        ],
                      ),

                      /// TEXT ATAU
                      SizedBox(height: 77.h),
                      Row(
                        children: [
                          const Spacer(flex: 3),
                          Container(
                              height: 1,
                              width: ScreenUtil().screenWidth * 0.35,
                              color: Colors.grey[500]),
                          const Spacer(flex: 1),
                          Text(
                            "atau",
                            style: GoogleFonts.montserrat(
                              color: Colors.grey[500],
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const Spacer(flex: 1),
                          Container(
                              height: 1,
                              width: ScreenUtil().screenWidth * 0.35,
                              color: Colors.grey[500]),
                          const Spacer(flex: 3),
                        ],
                      ),

                      /// MASUK DENGAN GOOGLE
                      SizedBox(height: 9.h),
                      InkWell(
                        onTap: () {
                          LoginController.to.googleAuthLogin();
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 46.sp),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50.sp),
                            color: Colours.white,
                          ),
                          height: 44.h,
                          child: Material(
                            borderRadius: BorderRadius.circular(50.sp),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(AssetConts.iconGoogle),
                                  SizedBox(width: 17.w),
                                  Row(
                                    children: [
                                      Text(
                                        "Masuk menggunakan ",
                                        style: GoogleFonts.montserrat(
                                          color: Colours.darkBlack,
                                        ),
                                      ),
                                      Text(
                                        "Google",
                                        style: GoogleFonts.montserrat(
                                          color: Colours.darkBlack,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                      /// MASUK DENGAN APPLE
                      SizedBox(height: 17.h),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 46.sp),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.r),
                          color: Colours.darkBlack,
                        ),
                        height: 44.h,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(AssetConts.iconApple),
                              SizedBox(width: 17.w),
                              Row(
                                children: [
                                  Text(
                                    "Masuk menggunakan ",
                                    style: GoogleFonts.montserrat(
                                      color: Colours.white,
                                    ),
                                  ),
                                  Text(
                                    "Apple",
                                    style: GoogleFonts.montserrat(
                                      color: Colours.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 141.h),
                    ],
                  ),
                )
              : const NoConnectionView(),
        ),
      ),
    );
  }
}
