import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/modules/features/login/view/components/title_textfield.dart';
import '/config/routes/app_routes.dart';
import '/config/themes/colours.dart';
import '/constant/core/assets_const.dart';
import '/modules/features/login/view/components/input_textfield.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            SizedBox(height: 40.h),
            TittleTextfield(name: "Alamat Email"),
            SizedBox(height: 5.sp),
            InputTextField(
              hintText: "lorem@gmail.com",
              isPassword: false,
            ),
            SizedBox(height: 40.h),
            TittleTextfield(name: "Kata Sandi"),
            SizedBox(height: 5.h),
            InputTextField(
              hintText: "**************",
              isPassword: true,
            ),
            SizedBox(height: 40.h),
            Container(
              height: 44.h,
              margin: EdgeInsets.symmetric(horizontal: 46.sp),
              child: ElevatedButton(
                onPressed: () {
                  Get.toNamed(AppRoutes.loadingLokasi);
                },
                style: ElevatedButton.styleFrom(
                  elevation: 5.sp,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.r),
                  ),
                ),
                child: Text(
                  "Masuk",
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w800,
                    color: Colours.white,
                  ),
                ),
              ),
            ),
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

            SizedBox(height: 9.h),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 46.sp),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.sp),
                color: Colours.white,
              ),
              height: 44.h,
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
      ),
    );
  }
}
