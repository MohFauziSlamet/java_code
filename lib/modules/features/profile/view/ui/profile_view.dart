import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:java_code/config/themes/colours.dart';
import 'package:java_code/constant/core/assets_const.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.bgColors,
      body: SafeArea(
        child: Column(
          children: [
            // APPBAR PROFILE
            Material(
              elevation: 2,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30.sp),
                bottomRight: Radius.circular(30.sp),
              ),
              child: Container(
                width: ScreenUtil().screenWidth,
                height: 66.h,
                decoration: BoxDecoration(
                  color: Colours.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30.sp),
                    bottomRight: Radius.circular(30.sp),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 15.h),
                    Container(
                      height: 40.h,
                      width: ScreenUtil().screenWidth,
                      child: Column(
                        children: [
                          Text(
                            "Profile",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w600,
                              fontSize: 20.sp,
                              color: Colours.green2,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Visibility(
                            child: Container(
                              height: 5.h,
                              width: 65.w,
                              decoration: BoxDecoration(color: Colours.green2),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // CONTENT
            Expanded(
              child: Stack(
                children: [
                  // BG
                  Center(
                    child: Container(
                      width: ScreenUtil().screenWidth,
                      height: ScreenUtil().screenHeight * 0.8,
                      margin: EdgeInsets.symmetric(
                          horizontal: 25.sp, vertical: 17.sp),
                      child: Image.asset(AssetConts.backgroundLoadingLokasi),
                    ),
                  ),
                  // MAIN CONTENT
                  ListView(
                    children: [
                      SizedBox(height: 33.h),
                      // PROFILE
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 171.w,
                            width: 171.w,
                            child: Image.asset(
                              AssetConts.drawEmptyProfile,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),

                      // JARAK
                      SizedBox(height: 21.h),
                      // VERIFIKASI
                      SizedBox(
                        height: 21.h,
                        width: ScreenUtil().scaleWidth,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // ICON KTP
                            SizedBox(
                              height: 16.h,
                              width: 20.w,
                              child: Image.asset(
                                AssetConts.iconKTP,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 7.w),

                            // TEXT VERIFIKASI
                            SizedBox(
                              height: 21.h,
                              width: 198.w,
                              child: Text(
                                "Verifikasi KTP mu sekarang!",
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.sp,
                                  color: Colours.green2,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // INFO AKUN
                      SizedBox(height: 18.h),
                      Container(
                        height: 21.h,
                        width: 173.w,
                        margin: EdgeInsets.only(left: 36.sp),
                        child: Text(
                          "Info Akun",
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w600,
                            fontSize: 20.sp,
                            color: Colours.green2,
                          ),
                        ),
                      ),
                      // DETAIL INFORMASI
                      SizedBox(height: 14.h),
                      Container(
                        height: 306.h,
                        width: 396.w,
                        margin: EdgeInsets.symmetric(horizontal: 16.sp),
                        decoration: BoxDecoration(
                          color: Colours.whiteItem,
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
