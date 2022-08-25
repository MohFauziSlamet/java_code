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
                        ButtonCard(),
                        ButtonCard(),
                        ButtonCard(),
                        ButtonCard(),
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
  const ButtonCard({
    Key? key,
  }) : super(key: key);

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
          children: [
            Row(
              children: [
                Text(
                  "Harga",
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w700,
                    fontSize: 20.sp,
                    color: Colours.green2,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "Rp 10.000",
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w700,
                    fontSize: 20.sp,
                    color: Colours.green2,
                  ),
                ),
                SizedBox(width: 23),
              ],
            ),
          ],
        ),
        SizedBox(height: 14.h),
      ],
    );
  }
}
