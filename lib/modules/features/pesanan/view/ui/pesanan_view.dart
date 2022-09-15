import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:java_code/config/routes/app_routes.dart';
import 'package:java_code/config/themes/colours.dart';
import 'package:java_code/constant/core/assets_const.dart';
import 'package:java_code/modules/features/detail_menu/controller/detail_menu_controller.dart';
import 'package:java_code/modules/features/home/controllers/home_controller.dart';
import 'package:java_code/modules/features/home/view/components/item_menu.dart';
import 'package:java_code/modules/features/home/view/components/judul_menu.dart';
import 'package:java_code/modules/features/no_connecntion/view/ui/no_connection_view.dart';
import 'package:java_code/modules/global_controllers/check_connection_controller.dart';

class PesananView extends StatelessWidget {
  const PesananView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ConnectionManagerController.to.connectionType.value != 0
          ? Scaffold(
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
                                Get.toNamed(AppRoutes.dashboardView);
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
                            Obx(
                              () => Conditional.single(
                                  context: context,
                                  conditionBuilder: (context) => HomeController
                                      .to.menuBucket
                                      .where((e) => e.kategori == 'makanan')
                                      .toList()
                                      .isEmpty,
                                  widgetBuilder: (context) => const SizedBox(),
                                  fallbackBuilder: (context) {
                                    log('${HomeController.to.menuBucket.where((e) => e.kategori == 'makanan').toList()[0].nama}');
                                    log('${HomeController.to.menuBucket.where((e) => e.kategori == 'makanan').toList()[0].count}');
                                    log('${HomeController.to.menuBucket.where((e) => e.kategori == 'makanan').toList()[0].idMenu}');
                                    return Column(
                                      children: [
                                        JudulMenu(
                                            iconMenu: AssetConts.iconMakanan,
                                            judulMenu: 'Makanan'),
                                        ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: HomeController
                                              .to.menuBucket
                                              .where((e) =>
                                                  e.kategori == 'makanan')
                                              .toList()
                                              .length,
                                          itemBuilder: (context, index) {
                                            log(' PANJANG MAKANAN : ${HomeController.to.menuBucket.where((e) => e.kategori == 'makanan').toList().length}');
                                            log(' PANJANG MAKANAN : ${HomeController.to.menuBucket.where((e) => e.kategori == 'makanan').toList().length}');
                                            log(' PANJANG MAKANAN : ${HomeController.to.menuBucket.where((e) => e.kategori == 'makanan').toList().length}');
                                            return ItemMenu(
                                                result: HomeController
                                                    .to.menuBucket
                                                    .where((e) =>
                                                        e.kategori == 'makanan')
                                                    .toList()[index],
                                                index: index);
                                          },
                                        ),
                                      ],
                                    );
                                  }),
                            ),
                            Obx(
                              () => Conditional.single(
                                context: context,
                                conditionBuilder: (context) => HomeController
                                    .to.menuBucket
                                    .where((e) => e.kategori == 'snack')
                                    .toList()
                                    .isEmpty,
                                widgetBuilder: (context) => const SizedBox(),
                                fallbackBuilder: (context) => Column(
                                  children: [
                                    JudulMenu(
                                        iconMenu: AssetConts.iconMakanan,
                                        judulMenu: 'Snack'),
                                    ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: HomeController.to.menuBucket
                                          .where((e) => e.kategori == 'snack')
                                          .toList()
                                          .length,
                                      itemBuilder: (context, index) {
                                        log(' PANJANG SNACK : ${HomeController.to.menuBucket.where((e) => e.kategori == 'snack').toList().length}');
                                        return ItemMenu(
                                            result: HomeController.to.menuBucket
                                                .where((e) =>
                                                    e.kategori == 'snack')
                                                .toList()[index],
                                            index: index);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Obx(
                              () => Conditional.single(
                                context: context,
                                conditionBuilder: (context) => HomeController
                                    .to.menuBucket
                                    .where((e) => e.kategori == 'minuman')
                                    .toList()
                                    .isEmpty,
                                widgetBuilder: (context) => const SizedBox(),
                                fallbackBuilder: (context) => Column(
                                  children: [
                                    JudulMenu(
                                        iconMenu: AssetConts.iconMakanan,
                                        judulMenu: 'Minuman'),
                                    ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: HomeController.to.menuBucket
                                          .where((e) => e.kategori == 'minuman')
                                          .toList()
                                          .length,
                                      itemBuilder: (context, index) {
                                        log(' PANJANG Minuman : ${HomeController.to.menuBucket.where((e) => e.kategori == 'minuman').toList().length}');
                                        return ItemMenu(
                                            result: HomeController.to.menuBucket
                                                .where((e) =>
                                                    e.kategori == 'minuman')
                                                .toList()[index],
                                            index: index);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
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

                          /// TOTAL PESANAN DAN HARGA
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

                          /// GARIS PEMBATAS
                          Container(
                            width: 381.w,
                            height: 1.h,
                            decoration: BoxDecoration(
                              color: Colours.darkGrey.withOpacity(0.25),
                            ),
                          ),
                          SizedBox(height: 12.h),

                          /// DISKON 20%
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 23.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      height: 21.h,
                                      width: 20.w,
                                      child: Image.asset(
                                        AssetConts.iconDiskon,
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

                          /// GARIS PEMBATAS
                          Container(
                            width: 381.w,
                            height: 1.h,
                            decoration: BoxDecoration(
                              color: Colours.darkGrey.withOpacity(0.25.sp),
                            ),
                          ),
                          SizedBox(height: 12.h),

                          /// VOUCHER
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 23.sp),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      height: 17.33.w,
                                      width: 22.29.w,
                                      child: Image.asset(
                                        AssetConts.iconVoucher,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(width: 10.w),
                                    Text(
                                      "Voucher",
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
                                Material(
                                  child: InkWell(
                                    splashColor: Colors.grey,
                                    onTap: () {
                                      Get.toNamed(AppRoutes.pilihVoucherView);
                                    },
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 182.w,
                                          child: Text(
                                            "Pilih voucher",
                                            textAlign: TextAlign.end,
                                            maxLines: 1,
                                            style: GoogleFonts.montserrat(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14.sp,
                                              color: Colours.darkGrey,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 13.38,
                                        ),
                                        const Icon(
                                          Icons.arrow_forward_ios,
                                          color: Color(0xffAFAFAF),
                                          size: 14,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 12.h),

                          /// GARIS BATAS
                          Container(
                            width: 381.w,
                            height: 1.h,
                            decoration: BoxDecoration(
                              color: Colours.darkGrey.withOpacity(0.25),
                            ),
                          ),
                          SizedBox(height: 12.h),

                          /// PEMBAYARAN
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 23.sp),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      height: 24.w,
                                      width: 24.w,
                                      child: Image.asset(
                                        AssetConts.iconPembayaran,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    SizedBox(width: 10.w),
                                    Text(
                                      "Pembayaran",
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
                                        "Paylater",
                                        textAlign: TextAlign.end,
                                        maxLines: 1,
                                        style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14.sp,
                                          color: Colours.darkGrey,
                                        ),
                                      ),
                                    ),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  /// ICON
                                  Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: 22.sp, right: 9.sp),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Total Pembayaran",
                                            style: GoogleFonts.montserrat(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12,
                                              color: Colours.darkGrey
                                                  .withOpacity(0.75),
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
                                    margin: const EdgeInsets.only(
                                        right: 10, left: 20),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Get.defaultDialog(
                                          title: 'Verifikasi Pesanan',
                                          titleStyle: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 22.sp,
                                            color: Colours.darkGrey,
                                          ),
                                          titlePadding:
                                              EdgeInsets.only(top: 24.sp),
                                          content: SizedBox(
                                            width: 338.w,
                                            child: Column(
                                              children: [
                                                Text(
                                                  "Finger Print",
                                                  style: GoogleFonts.montserrat(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 16.sp,
                                                    color:
                                                        const Color(0xff969696),
                                                  ),
                                                ),
                                                SizedBox(height: 31.h),
                                                SizedBox(
                                                  height: 142.w,
                                                  width: 142.w,
                                                  child: Center(
                                                    child: Image.asset(
                                                      AssetConts.iconFinger,
                                                    ),
                                                  ),
                                                ),
                                                // SPACE JARAK
                                                SizedBox(height: 27.h),
                                                // ATAU
                                                Row(
                                                  children: [
                                                    const Spacer(flex: 3),
                                                    Container(
                                                        height: 1,
                                                        width: 68.w,
                                                        color:
                                                            Colors.grey[500]),
                                                    const Spacer(flex: 1),
                                                    Text(
                                                      "atau",
                                                      style: GoogleFonts
                                                          .montserrat(
                                                        color: Colors.grey[500],
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                    const Spacer(flex: 1),
                                                    Container(
                                                        height: 1,
                                                        width: 68.w,
                                                        color:
                                                            Colors.grey[500]),
                                                    const Spacer(flex: 3),
                                                  ],
                                                ),
                                                // SPACE JARAK

                                                InkWell(
                                                  onTap: () {
                                                    Get.back(); // MENUTUP DIALOG PERTAMA
                                                    Get.defaultDialog(
                                                      title:
                                                          'Verifikasi Pesanan',
                                                      titleStyle: GoogleFonts
                                                          .montserrat(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 22.sp,
                                                        color: Colours.darkGrey,
                                                      ),
                                                      titlePadding:
                                                          EdgeInsets.only(
                                                              top: 24.sp),
                                                      content: SizedBox(
                                                        width: 338.w,
                                                        child: Column(
                                                          children: [
                                                            Text(
                                                              "Masukan Kode PIN",
                                                              style: GoogleFonts
                                                                  .montserrat(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize: 16.sp,
                                                                color: const Color(
                                                                    0xff969696),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                height: 24.h),
                                                            // INPUT PIN
                                                            Form(
                                                              child: Row(
                                                                children: [
                                                                  SizedBox(
                                                                    height:
                                                                        35.h,
                                                                    width: 34.w,
                                                                    child:
                                                                        TextField(
                                                                      decoration:
                                                                          InputDecoration(
                                                                        enabledBorder:
                                                                            OutlineInputBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(10),
                                                                          borderSide:
                                                                              const BorderSide(color: Colours.grey),
                                                                        ),
                                                                        focusedBorder:
                                                                            OutlineInputBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(10),
                                                                          borderSide:
                                                                              const BorderSide(color: Colours.green2),
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
                                                    );
                                                  },
                                                  child: Text(
                                                    "Verifikasi Menggunakan PIN",
                                                    style:
                                                        GoogleFonts.montserrat(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 16.sp,
                                                      color: Colours.green2,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: Colours.green2,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                      ),
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
            )
          : const NoConnectionView(),
    );
  }
}
