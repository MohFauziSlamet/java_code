import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '/modules/features/login/controllers/login_register_controler.dart';
import '/modules/features/login/view/components/title_textfield.dart';
import '/config/routes/app_routes.dart';
import '/config/themes/colours.dart';
import '/constant/core/assets_const.dart';
import '/modules/features/login/view/components/input_textfield.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// MEMANGGIL LoginController
    Get.put(LoginController());
    return Scaffold(
      backgroundColor: Colours.bgColors,
      body: SafeArea(
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
                "Registrasi untuk melanjutkan!",
                style: GoogleFonts.montserrat(
                  color: Colours.darkBlack,
                  fontWeight: FontWeight.w600,
                  fontSize: 22.sp,
                ),
              ),
            ),

            /// TITLE NAMA DAN TEXTFIELD
            SizedBox(height: 40.h),
            TittleTextfield(name: "Nama kamu"),
            SizedBox(height: 5.sp),
            InputTextField(
              controller: LoginController.to.nameRegisterC,
              hintText: "Moh Fauzi Slamet",
              isPassword: false,
              textInputAction: TextInputAction.next,
            ),

            /// TITLE EMAIL DAN TEXTFIELD
            SizedBox(height: 40.h),
            TittleTextfield(name: "Alamat Email"),
            SizedBox(height: 5.sp),
            InputTextField(
              controller: LoginController.to.emailRegisterC,
              hintText: "lorem@gmail.com",
              isPassword: false,
              textInputAction: TextInputAction.next,
            ),

            /// TITLE TGL DAN TEXTFIELD
            SizedBox(height: 40.h),
            TittleTextfield(name: "Tanggal Lahir"),
            SizedBox(height: 30.sp),
            Row(
              children: [
                SizedBox(
                  height: 19.h,
                  width: 360.w,
                  child: InputTextField(
                    controller: LoginController.to.dateRegisterC,
                    hintText: "O5/07/1996",
                    isPassword: false,
                    textInputAction: TextInputAction.next,
                  ),
                ),
                SizedBox(
                  height: 19.w,
                  width: 19.w,
                  child: InkWell(
                    onTap: () async {
                      print('menampilkan date diaog');

                      DateTime? datePicked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100),
                      );

                      LoginController.to.dateRegisterC.text =
                          DateFormat().add_yMd().format(datePicked!);
                      print(LoginController.to.dateRegisterC.text);
                    },
                    child: Image.asset(AssetConts.iconKalender),
                  ),
                ),
                SizedBox(width: 46.w),
              ],
            ),

            /// TITLE NOMOR DAN TEXTFIELD
            SizedBox(height: 40.h),
            TittleTextfield(name: "Nomor Kamu"),
            SizedBox(height: 5.sp),
            InputTextField(
              controller: LoginController.to.phoneRegisterC,
              hintText: "O857731532271",
              isPassword: false,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.phone,
            ),

            /// TITLE PASSWORD DAN TEXTFIELD
            SizedBox(height: 40.h),
            TittleTextfield(name: "Kata Sandi"),
            SizedBox(height: 5.h),
            InputTextField(
              controller: LoginController.to.passRegisterC,
              hintText: "**************",
              isPassword: true,
              isObscuretext: true,
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
                    if (LoginController.to.isLoading.isFalse) {
                      LoginController.to.register();
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
                        ? "Registrasi"
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
                const Text("Sudah Punya Akun ?"),
                TextButton(
                  onPressed: () {
                    Get.toNamed(AppRoutes.login);
                  },
                  child: const Text('Sign In'),
                ),
              ],
            ),

            SizedBox(height: 141.h),
          ],
        ),
      ),
    );
  }
}
