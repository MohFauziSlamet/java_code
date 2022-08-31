import 'dart:ui';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:java_code/modules/features/home/controllers/home_controller.dart';
import 'package:java_code/modules/features/login/controllers/login_register_controler.dart';
import 'package:java_code/modules/features/profile/controller/profile_controller.dart';
import 'package:java_code/modules/features/profile/view/component/bottom_sheet_dialog.dart';
import '/modules/features/profile/view/component/garis_batas.dart';
import '/config/themes/colours.dart';
import '/constant/core/assets_const.dart';
import '/modules/features/profile/view/component/item_info_profile.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ProfileController());

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
                              decoration:
                                  const BoxDecoration(color: Colours.green2),
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
                        padding: EdgeInsets.only(
                            left: 20.sp, right: 20.sp, top: 31.sp),
                        decoration: BoxDecoration(
                          color: Colours.whiteItem,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Column(
                          children: [
                            // ITEM INFO NAME PROFILE
                            ItemInfoProfile(
                                nameInfo: 'Nama',
                                textInfo: 'Fauzi',
                                onTap: () {
                                  Get.bottomSheet(
                                    BottomSheetDialog(
                                        onTap: () {
                                          Get.back();
                                        },
                                        namaBottomSheet: 'Nama'),
                                    barrierColor:
                                        Colours.whiteGrey.withOpacity(0.5),
                                  );
                                }),
                            const GarisBatas(),
                            // ITEM INFO TGL PROFILE
                            ItemInfoProfile(
                                nameInfo: 'Tangal lahir',
                                textInfo: '05/07/1996',
                                onTap: () {
                                  Get.bottomSheet(
                                    BottomSheetDialog(
                                      onTap: () {
                                        Get.back();
                                      },
                                      namaBottomSheet: 'Ubah Nomor',
                                      keyboardType: TextInputType.number,
                                      widget: SizedBox(
                                        height: 19.w,
                                        width: 19.w,
                                        child: InkWell(
                                          onTap: () {
                                            print('Menekan tanggal');
                                          },
                                          child: Image.asset(
                                            AssetConts.iconKalender,
                                            color: Colours.green2,
                                          ),
                                        ),
                                      ),
                                    ),
                                    barrierColor:
                                        Colours.whiteGrey.withOpacity(0.5),
                                  );
                                }),
                            const GarisBatas(),
                            // ITEM INFO NO TLP PROFILE
                            ItemInfoProfile(
                                nameInfo: 'No.Telepon',
                                textInfo: '0857-3153-2271',
                                onTap: () {
                                  Get.bottomSheet(
                                    BottomSheetDialog(
                                      onTap: () {
                                        Get.back();
                                      },
                                      namaBottomSheet: 'Ubah Nomor',
                                      keyboardType: TextInputType.number,
                                    ),
                                    barrierColor:
                                        Colours.whiteGrey.withOpacity(0.5),
                                  );
                                }),
                            const GarisBatas(),
                            // ITEM INFO EMAIL PROFILE
                            ItemInfoProfile(
                                nameInfo: 'Email',
                                textInfo: 'mohfauzislamet@gmail.com',
                                onTap: () {
                                  Get.bottomSheet(
                                    BottomSheetDialog(
                                        onTap: () {
                                          Get.back();
                                        },
                                        namaBottomSheet: 'Ubah Email'),
                                    barrierColor:
                                        Colours.whiteGrey.withOpacity(0.5),
                                  );
                                }),
                            const GarisBatas(),
                            // ITEM INFO UBAH PIN PROFILE
                            ItemInfoProfile(
                                nameInfo: 'Ubah PIN',
                                textInfo: '**********',
                                onTap: () {
                                  Get.bottomSheet(
                                    BottomSheetDialog(
                                        onTap: () {
                                          Get.back();
                                        },
                                        namaBottomSheet: 'Ubah PIN'),
                                    barrierColor:
                                        Colours.whiteGrey.withOpacity(0.5),
                                  );
                                }),
                            const GarisBatas(),
                            ItemInfoProfile(
                              nameInfo: 'Ganti Bahasa',
                              textInfo: 'Indonesia',
                              onTap: () {
                                Get.bottomSheet(
                                  Container(
                                    width: ScreenUtil().screenWidth,
                                    height: 200.h,
                                    decoration: BoxDecoration(
                                      color: Colours.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30.r),
                                        topRight: Radius.circular(30.r),
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        SizedBox(height: 18.h),
                                        // GARIS STRIP
                                        Container(
                                          height: 4.h,
                                          width: 104.w,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            color: Color(0xffc4c4c4)
                                                .withOpacity(0.5),
                                          ),
                                        ),
                                        SizedBox(height: 13.h),
                                        // GANTI BAHASA DAN LOGO BENDERA
                                        Expanded(
                                          child: Container(
                                            width: ScreenUtil().screenWidth,
                                            margin: EdgeInsets.symmetric(
                                              horizontal: 17.sp,
                                            ),
                                            child: SizedBox(
                                              height: 165,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  // GANTI BAHASA
                                                  SizedBox(
                                                    height: 20.h,
                                                    width: 150.w,
                                                    child: Text(
                                                      'Ganti Bahasa',
                                                      style: GoogleFonts
                                                          .montserrat(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 18,
                                                        color: Colours.darkGrey,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 13.h),
                                                  // LOGO BENDERA
                                                  SizedBox(
                                                    width: ScreenUtil()
                                                        .screenWidth,
                                                    height: 57.h,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Material(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.r),
                                                          elevation: 2,
                                                          child: Container(
                                                            height: 57.h,
                                                            width: 189.w,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colours
                                                                  .green2,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.r),
                                                            ),
                                                            child: Row(
                                                              children: [
                                                                SizedBox(
                                                                    width:
                                                                        11.w),
                                                                SizedBox(
                                                                  width: 56.w,
                                                                  height:
                                                                      38.5.h,
                                                                  child: Image.asset(
                                                                      AssetConts
                                                                          .iconIndFlag),
                                                                ),
                                                                SizedBox(
                                                                    width: 9.w),
                                                                SizedBox(
                                                                  height: 20.h,
                                                                  width: 76.w,
                                                                  child: Text(
                                                                    'Indonesia',
                                                                    style: GoogleFonts
                                                                        .montserrat(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontSize:
                                                                          15,
                                                                      color: Colours
                                                                          .white,
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                    width:
                                                                        6.13.w),
                                                                SizedBox(
                                                                  height: 12.h,
                                                                  width: 15.w,
                                                                  child: Image
                                                                      .asset(
                                                                    AssetConts
                                                                        .iconCeklis,
                                                                    color: Colours
                                                                        .white,
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        Material(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.r),
                                                          elevation: 4,
                                                          child: Container(
                                                            height: 57.h,
                                                            width: 189.w,
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  Colours.white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.r),
                                                            ),
                                                            child: Row(
                                                              children: [
                                                                SizedBox(
                                                                    width:
                                                                        11.w),
                                                                SizedBox(
                                                                  width: 56.w,
                                                                  height:
                                                                      38.5.h,
                                                                  child: Image.asset(
                                                                      AssetConts
                                                                          .iconEngFlag),
                                                                ),
                                                                SizedBox(
                                                                    width: 5.w),
                                                                SizedBox(
                                                                  height: 20.h,
                                                                  width: 76.w,
                                                                  child: Text(
                                                                    'Inggris',
                                                                    style: GoogleFonts
                                                                        .montserrat(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontSize:
                                                                          15,
                                                                      color: Colours
                                                                          .darkGrey,
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                    width:
                                                                        6.13.w),
                                                                SizedBox(
                                                                  height: 12.h,
                                                                  width: 15.w,
                                                                  child: Image
                                                                      .asset(
                                                                    AssetConts
                                                                        .iconCeklis,
                                                                    color: Colors
                                                                        .transparent,
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  barrierColor:
                                      Colours.whiteGrey.withOpacity(0.5),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      // BUTTON PENILAIAN
                      SizedBox(height: 18.h),
                      Container(
                        height: 47.h,
                        margin: EdgeInsets.symmetric(horizontal: 16.sp),
                        decoration: BoxDecoration(
                          color: Colours.whiteItem,
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Row(
                          children: [
                            SizedBox(width: 22.w),
                            // ICON
                            SizedBox(
                              height: 18.86.h,
                              width: 20.31.w,
                              child: Image.asset(AssetConts.iconPenilaian),
                            ),
                            SizedBox(width: 8.69.w),
                            SizedBox(
                              height: 20.h,
                              width: 77.w,
                              child: Text(
                                'Penilaian',
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.sp,
                                  color: Colours.darkGrey,
                                ),
                              ),
                            ),
                            SizedBox(width: 114.w),
                            SizedBox(
                              height: 35.h,
                              width: 134.w,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  primary: Colours.green2,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.r),
                                    side: const BorderSide(
                                      color: Colours.white,
                                      width: 1,
                                    ),
                                  ),
                                ),
                                child: Text(
                                  'Nilai Sekarang',
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.sp,
                                    color: Colours.white,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      // INFO LAINNYA
                      SizedBox(height: 18.h),
                      Container(
                        height: 21.h,
                        width: 201.w,
                        margin: EdgeInsets.only(left: 36.sp),
                        child: Text(
                          'Info Lainnya',
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w600,
                            fontSize: 20.sp,
                            color: Colours.green2,
                          ),
                        ),
                      ),
                      SizedBox(height: 14.h),
                      // DETAIL DEVICE
                      Container(
                        height: 114.h,
                        width: ScreenUtil().screenWidth,
                        margin: EdgeInsets.symmetric(horizontal: 16.sp),
                        padding: EdgeInsets.only(
                            left: 20.sp, right: 20.sp, top: 25.sp),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.r),
                          color: Colours.whiteItem,
                        ),
                        child: Column(
                          children: [
                            ItemInfoProfile(
                              nameInfo: 'Device Info',
                              textInfo: 'Iphone 13',
                              onTap: () {},
                            ),
                            const GarisBatas(),
                            ItemInfoProfile(
                              nameInfo: 'Version',
                              textInfo: '1.3',
                              onTap: () {},
                            ),
                          ],
                        ),
                      ),
                      // BUTTON LOGOUT
                      SizedBox(height: 30.h),
                      Obx(
                        () => Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 35.h,
                              width: 205,
                              child: ElevatedButton(
                                onPressed: () {
                                  Get.defaultDialog(
                                    title: 'HALO',
                                    middleText: 'Apakah kamu ingin keluar ?',
                                    actions: [
                                      TextButton(
                                        style: TextButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.r),
                                            side: const BorderSide(
                                              color: Colours.green2,
                                              width: 1,
                                            ),
                                          ),
                                        ),
                                        onPressed: () {
                                          Get.back();
                                        },
                                        child: Text('Batal'),
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: Colours.green2,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.r),
                                            side: const BorderSide(
                                              color: Colours.white,
                                              width: 1,
                                            ),
                                          ),
                                        ),
                                        onPressed: () {
                                          if (ProfileController
                                              .to.isLoading.isFalse) {
                                            ProfileController.to.logout();
                                          }
                                        },
                                        child: Text(
                                          ProfileController.to.isLoading.isFalse
                                              ? "Iya"
                                              : 'Loading...',
                                        ),
                                      ),
                                    ],
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Colours.green2,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.r),
                                    side: const BorderSide(
                                      color: Colours.white,
                                      width: 1,
                                    ),
                                  ),
                                ),
                                child: Text(
                                  ProfileController.to.isLoading.isFalse
                                      ? 'LOGOUT'
                                      : 'Loading...',
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 14.sp,
                                    color: Colours.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30.h),
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
