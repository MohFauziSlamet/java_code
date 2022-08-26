import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:java_code/config/themes/colours.dart';
import 'package:java_code/constant/core/assets_const.dart';

class DetailMenuView extends StatelessWidget {
  const DetailMenuView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.bgColors,
      body: SafeArea(
        child: ListView(
          children: [
            /// APPBAR DETAIL MENU
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
                child: Stack(
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(
                        Icons.arrow_back_ios_new,
                        size: 18.sp,
                        color: Colours.green2,
                      ),
                    ),
                    Center(
                      child: Text(
                        "Detail Menu",
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w700,
                          fontSize: 20.sp,
                          color: Colours.darkGrey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 25.h),

            /// GAMBAR MENU
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 234.w,
                  height: 181.h,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AssetConts.drawDetailChickenKatsu),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 25.h),

            ///
            Container(
              height: 563.h,
              decoration: BoxDecoration(
                color: Colours.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.sp),
                  topRight: Radius.circular(30.sp),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 46.h),
                  Container(
                    margin: EdgeInsets.only(
                      left: 25.sp,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Chicken Katsu",
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w700,
                                fontSize: 20.sp,
                                color: Colours.green2,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Material(
                                  child: InkWell(
                                    splashColor: Colors.grey,
                                    onTap: () {},
                                    child: Container(
                                      height: 21.w,
                                      width: 21.w,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                            AssetConts.iconKurang,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 11),
                                Text(
                                  "1",
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18.sp,
                                  ),
                                ),
                                const SizedBox(width: 11),
                                Material(
                                  child: InkWell(
                                    splashColor: Colors.grey,
                                    onTap: () {},
                                    child: Container(
                                      height: 21.h,
                                      width: 21.h,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                            AssetConts.iconTambah,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 23.w)
                              ],
                            ),
                          ],
                        ),

                        SizedBox(height: 14.h),

                        /// DETAIL MENU
                        SizedBox(
                          width: 295.w,
                          child: Text(
                            "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                            softWrap: true,
                            maxLines: 10,
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w600,
                              fontSize: 16.sp,
                              color: Colours.darkGrey,
                            ),
                          ),
                        ),

                        SizedBox(height: 39.h),

                        /// KUMPULAN CARD
                        ButtonCard(
                          stringIcon: AssetConts.iconHarga,
                          widthIcon: 16.w,
                          heightIcon: 16.w,
                          nama: 'Harga',
                          child: Text(
                            "Rp 10.000",
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w700,
                              fontSize: 20.sp,
                              color: Colours.green2,
                            ),
                          ),
                        ),

                        /// LEVEL
                        ButtonCard(
                          stringIcon: AssetConts.iconLevel,
                          widthIcon: 20.w,
                          heightIcon: 20.w,
                          nama: 'Level',
                          child: CustomTextButton(
                              nama: '1',
                              ontap: () {
                                Get.bottomSheet(
                                  barrierColor: Colours.grey.withOpacity(0.5),
                                  Container(
                                    height: 200.h,
                                    width: ScreenUtil().screenWidth,
                                    decoration: BoxDecoration(
                                      color: Colours.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30.r),
                                        topRight: Radius.circular(30.r),
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 19.h),
                                        Center(
                                          child: Container(
                                            width: 104.w,
                                            height: 4.h,
                                            decoration: BoxDecoration(
                                              color: const Color(0xffC4C4C4)
                                                  .withOpacity(0.5),
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                          ),
                                        ),

                                        ///
                                        SizedBox(height: 13.h),
                                        Container(
                                          margin: EdgeInsets.only(left: 17.sp),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Pilih Level",
                                                style: GoogleFonts.montserrat(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 18.sp,
                                                  color: Colours.darkGrey,
                                                ),
                                              ),
                                              SizedBox(height: 17.sp),
                                              Row(
                                                children: [
                                                  Container(
                                                    width: 48.w,
                                                    height: 25.h,
                                                    decoration: BoxDecoration(
                                                      color: Colours.green2,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30.sp),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          "1 ",
                                                          style: GoogleFonts
                                                              .montserrat(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 12.sp,
                                                            color:
                                                                Colours.white,
                                                          ),
                                                        ),
                                                        Image.asset(
                                                          AssetConts.iconCeklis,
                                                          width: 12.w,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(width: 10.w),

                                                  /// 2
                                                  Container(
                                                    width: 26.w,
                                                    height: 26.w,
                                                    decoration: BoxDecoration(
                                                      color: Colours.white,
                                                      borderRadius:
                                                          BorderRadiusDirectional
                                                              .circular(30.r),
                                                      border: Border.all(
                                                          color:
                                                              Colours.green2),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        "2",
                                                        style: GoogleFonts
                                                            .montserrat(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 12.sp,
                                                          color:
                                                              Colours.darkGrey,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 10.w),

                                                  /// 3
                                                  Container(
                                                    width: 26.w,
                                                    height: 26.w,
                                                    decoration: BoxDecoration(
                                                      color: Colours.white,
                                                      borderRadius:
                                                          BorderRadiusDirectional
                                                              .circular(30.r),
                                                      border: Border.all(
                                                          color:
                                                              Colours.green2),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        "3",
                                                        style: GoogleFonts
                                                            .montserrat(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 12.sp,
                                                          color:
                                                              Colours.darkGrey,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 10.w),

                                                  /// 4
                                                  Container(
                                                    width: 26.w,
                                                    height: 26.w,
                                                    decoration: BoxDecoration(
                                                      color: Colours.white,
                                                      borderRadius:
                                                          BorderRadiusDirectional
                                                              .circular(30.r),
                                                      border: Border.all(
                                                          color:
                                                              Colours.green2),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        "4",
                                                        style: GoogleFonts
                                                            .montserrat(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 12.sp,
                                                          color:
                                                              Colours.darkGrey,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 10.w),

                                                  /// 5
                                                  Container(
                                                    width: 26.w,
                                                    height: 26.w,
                                                    decoration: BoxDecoration(
                                                      color: Colours.white,
                                                      borderRadius:
                                                          BorderRadiusDirectional
                                                              .circular(30.r),
                                                      border: Border.all(
                                                          color:
                                                              Colours.green2),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        "5",
                                                        style: GoogleFonts
                                                            .montserrat(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 12.sp,
                                                          color:
                                                              Colours.darkGrey,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),

                        /// TOPPING
                        ButtonCard(
                          stringIcon: AssetConts.iconTopping,
                          widthIcon: 18.w,
                          heightIcon: 18.w,
                          nama: 'Topping',
                          child: CustomTextButton(
                              nama: 'Mozarella',
                              ontap: () {
                                Get.bottomSheet(
                                  barrierColor: Colours.grey.withOpacity(0.5),
                                  Container(
                                    height: 200.h,
                                    width: ScreenUtil().screenWidth,
                                    decoration: BoxDecoration(
                                      color: Colours.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30.r),
                                        topRight: Radius.circular(30.r),
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 19.h),
                                        Center(
                                          child: Container(
                                            width: 104.w,
                                            height: 4.h,
                                            decoration: BoxDecoration(
                                              color: const Color(0xffC4C4C4)
                                                  .withOpacity(0.5),
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 13.h),
                                        Container(
                                          margin: EdgeInsets.only(left: 17.sp),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Pilih Toping",
                                                style: GoogleFonts.montserrat(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 18,
                                                  color: Colours.darkGrey,
                                                ),
                                              ),
                                              SizedBox(height: 17.sp),
                                              Row(
                                                children: [
                                                  /// MOZARELLA
                                                  Container(
                                                    width: 94.w,
                                                    height: 25.h,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                      color: Colours.green2,
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          'Mozarella ',
                                                          style: GoogleFonts
                                                              .montserrat(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 12,
                                                            color:
                                                                Colours.white,
                                                          ),
                                                        ),
                                                        Image.asset(AssetConts
                                                            .iconCeklis)
                                                      ],
                                                    ),
                                                  ),

                                                  /// SAUSSAGGE
                                                  SizedBox(width: 12.w),
                                                  Container(
                                                    width: 94.w,
                                                    height: 25.h,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                      color: Colours.white,
                                                      border: Border.all(
                                                          color:
                                                              Colours.green2),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          'Saussagge',
                                                          style: GoogleFonts
                                                              .montserrat(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 12,
                                                            color: Colours
                                                                .darkGrey,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),

                                                  /// DIMSUM
                                                  SizedBox(width: 12.w),
                                                  Container(
                                                    width: 94.w,
                                                    height: 25.h,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                      color: Colours.white,
                                                      border: Border.all(
                                                          color:
                                                              Colours.green2),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          'Dimsum',
                                                          style: GoogleFonts
                                                              .montserrat(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 12,
                                                            color: Colours
                                                                .darkGrey,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),

                        /// CATATAN
                        ButtonCard(
                          stringIcon: AssetConts.iconCatatan,
                          widthIcon: 20.w,
                          heightIcon: 22.w,
                          nama: 'Catatan',
                          child: CustomTextButton(
                            nama: 'Tambahkan Catatan...',
                            ontap: () {
                              Get.bottomSheet(
                                barrierColor: Colours.grey.withOpacity(0.5),
                                Container(
                                  height: 200.h,
                                  width: ScreenUtil().screenWidth,
                                  decoration: BoxDecoration(
                                    color: Colours.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30.r),
                                      topRight: Radius.circular(30.r),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 19.h),
                                      Center(
                                        child: Container(
                                          width: 104.w,
                                          height: 4.h,
                                          decoration: BoxDecoration(
                                            color: const Color(0xffC4C4C4)
                                                .withOpacity(0.5),
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                        ),
                                      ),

                                      ///
                                      SizedBox(height: 13.h),
                                      Container(
                                        margin: EdgeInsets.only(left: 17.sp),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Buat Catatan",
                                              style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 18,
                                                color: Colours.darkGrey,
                                              ),
                                            ),
                                            SizedBox(height: 17.sp),
                                            Row(
                                              children: [
                                                Container(
                                                  width: 349.w,
                                                  child: const TextField(
                                                    autocorrect: false,
                                                    textInputAction:
                                                        TextInputAction.done,
                                                    maxLength: 100,
                                                    // onEditingComplete: () {},
                                                  ),
                                                ),
                                                SizedBox(width: 9.w),
                                                InkWell(
                                                  onTap: () {
                                                    Get.back();
                                                  },
                                                  child: Container(
                                                    width: 24.w,
                                                    height: 24.w,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              24),
                                                      color: Colours.green2,
                                                      image:
                                                          const DecorationImage(
                                                        image: AssetImage(
                                                            AssetConts
                                                                .iconCeklis),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                        Container(
                          width: 381.w,
                          height: 1.h,
                          decoration: BoxDecoration(
                            color: Colours.darkGrey.withOpacity(0.25),
                          ),
                        ),
                        SizedBox(height: 40.h),

                        /// BUTTON
                        Container(
                          height: 44.h,
                          width: ScreenUtil().screenWidth,
                          margin: EdgeInsets.only(right: 23.sp),
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              elevation: 5.sp,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.r),
                              ),
                            ),
                            child: Text(
                              "Tambahakan Ke Keranjang",
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                color: Colours.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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

class ButtonCard extends StatelessWidget {
  ButtonCard({
    Key? key,
    required this.nama,
    required this.stringIcon,
    required this.heightIcon,
    required this.widthIcon,
    required this.child,
  }) : super(key: key);

  String nama;
  String stringIcon;
  double widthIcon;
  double heightIcon;
  Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 381.w,
          height: 1.h,
          decoration: BoxDecoration(
            color: Colours.darkGrey.withOpacity(0.25),
          ),
        ),
        SizedBox(height: 10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                SizedBox(
                  height: heightIcon,
                  width: widthIcon,
                  child: Image.asset(
                    stringIcon,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 10.w),
                Text(
                  nama,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                    color: Colours.darkGrey,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                child,
                const SizedBox(width: 23),
              ],
            ),
          ],
        ),
        SizedBox(height: 14.h),
      ],
    );
  }
}

Widget CustomTextButton(
    {required String nama, required void Function() ontap}) {
  return Material(
    child: InkWell(
      onTap: ontap,
      splashColor: Colours.grey.withOpacity(0.5),
      child: Row(
        children: [
          SizedBox(
            width: 182.w,
            child: Text(
              nama,
              textAlign: TextAlign.end,
              maxLines: 1,
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w400,
                fontSize: 18,
                color: Colours.darkGrey,
              ),
            ),
          ),
          const SizedBox(
            width: 13.38,
          ),
          const Icon(Icons.arrow_forward_ios)
        ],
      ),
    ),
  );
}
