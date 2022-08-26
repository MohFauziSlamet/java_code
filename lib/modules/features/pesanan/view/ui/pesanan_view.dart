import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:java_code/config/themes/colours.dart';
import 'package:java_code/constant/core/assets_const.dart';
import 'package:java_code/modules/features/detail_menu/view/ui/detail_menu_view.dart';
import 'package:java_code/modules/features/home/view/components/item_menu.dart';
import 'package:java_code/modules/features/home/view/components/judul_menu.dart';

class PesananView extends StatelessWidget {
  const PesananView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.bgColors,
      body: SafeArea(
        child: Column(
          children: [
            /// APPBAR PESANAN
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            AssetConts.iconPesanan,
                            width: 32.w,
                            height: 32.w,
                            color: Colours.green2,
                          ),
                          SizedBox(width: 7.w),
                          Text(
                            "Pesanan",
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w700,
                              fontSize: 20.sp,
                              color: Colours.darkGrey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 28.h),

            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 25.sp),
                child: ListView(
                  children: [
                    /// JUDUL ITEM MENU
                    JudulMenu(
                        iconMenu: AssetConts.iconMakanan, judulMenu: "Makanan"),

                    /// ITEM MENU
                    const ItemMenu(),
                    const ItemMenu(),
                    const ItemMenu(),
                    const ItemMenu(),
                    const ItemMenu(),

                    /// JUDUL ITEM MENU
                    SizedBox(height: 20.h),
                    JudulMenu(
                        iconMenu: AssetConts.iconMinuman, judulMenu: "Minuman"),

                    /// ITEM MENU
                    const ItemMenu(),
                    const ItemMenu(),
                    const ItemMenu(),
                    const ItemMenu(),
                    const ItemMenu(),
                  ],
                ),
              ),
            ),
            SizedBox(height: 25.h),

            /// BOTTOM KONFIRM
            Container(
              width: ScreenUtil().screenWidth,
              height: 320.h,
              decoration: BoxDecoration(
                color: Colours.whiteItem,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25.r),
                  topLeft: Radius.circular(25.r),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: 25.h),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 23.sp),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Total Pesanan",
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600,
                                fontSize: 18.sp,
                                color: Colours.darkGrey,
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Text(
                              "( Menu) :",
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w400,
                                fontSize: 18.sp,
                                color: Colours.darkGrey,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "Rp. 10.000",
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w700,
                            fontSize: 14.sp,
                            color: Colours.green2,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 14.h),
                  Container(
                    width: 381.w,
                    height: 1.h,
                    decoration: BoxDecoration(
                      color: Colours.darkGrey.withOpacity(0.25),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 23.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              height: 20.w,
                              width: 20.w,
                              child: Image.asset(
                                AssetConts.iconKeranjang,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Text(
                              "Diskon 20%",
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600,
                                fontSize: 18.sp,
                                color: Colours.darkGrey,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 182.w,
                              child: Text(
                                "Rp. 10.000",
                                textAlign: TextAlign.end,
                                maxLines: 1,
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.sp,
                                  color: Colours.red,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 4.38,
                            ),
                            const Icon(
                              Icons.arrow_forward_ios,
                              color: Color(0xffAFAFAF),
                              size: 14,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Container(
                    width: 381.w,
                    height: 1.h,
                    decoration: BoxDecoration(
                      color: Colours.darkGrey.withOpacity(0.25.sp),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 23.sp),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              height: 20.w,
                              width: 20.w,
                              child: Image.asset(
                                AssetConts.iconKeranjang,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Text(
                              "Diskon 20%",
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
                            SizedBox(
                              width: 182.w,
                              child: Text(
                                "nama",
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
                      ],
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Container(
                    width: 381.w,
                    height: 1.h,
                    decoration: BoxDecoration(
                      color: Colours.darkGrey.withOpacity(0.25),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 23),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              height: 20,
                              width: 20,
                              child: Image.asset(
                                AssetConts.iconKeranjang,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Text(
                              "Diskon 20%",
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
                            SizedBox(
                              width: 182.w,
                              child: Text(
                                "nama",
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
                      ],
                    ),
                  ),
                  SizedBox(height: 25.h),
                  Material(
                    elevation: 4,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.r),
                      topRight: Radius.circular(30.r),
                    ),
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      width: ScreenUtil().screenWidth,
                      height: 89.h,
                      decoration: BoxDecoration(
                        color: Colours.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.r),
                          topRight: Radius.circular(30.r),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          /// ICON
                          Row(
                            children: [
                              Container(
                                margin:
                                    EdgeInsets.only(left: 22.sp, right: 9.sp),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 35.w,
                                      height: 30.h,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              AssetConts.iconKeranjang),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              /// TOTAL
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Total Pembayaran",
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                      color: Colours.darkGrey.withOpacity(0.75),
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  FittedBox(
                                    child: Text(
                                      "Rp. 10.000",
                                      style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20,
                                        color: Colours.green2,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          /// BUTTON PESAN SEKARANG
                          Container(
                            height: 42.h,
                            width: 169.w,
                            margin: const EdgeInsets.only(right: 10, left: 20),
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  primary: Colours.green2,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  )),
                              child: Text(
                                "Pesan Sekarang",
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16.sp,
                                  color: Colours.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
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
    );
  }
}
