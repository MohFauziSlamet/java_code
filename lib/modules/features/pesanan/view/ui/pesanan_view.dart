import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:java_code/config/routes/app_routes.dart';
import 'package:java_code/config/themes/colours.dart';
import 'package:java_code/constant/core/assets_const.dart';
import 'package:java_code/constant/core/hive_const.dart';
import 'package:java_code/modules/features/no_connecntion/view/ui/no_connection_view.dart';
import 'package:java_code/modules/features/pesanan/controller/pesanan_controller.dart';
import 'package:java_code/modules/features/pesanan/view/componen/item_pesanan.dart';
import 'package:java_code/modules/features/pesanan_tracking/ui/pesanan_tracking_view.dart';
import 'package:java_code/modules/global_controllers/check_connection_controller.dart';
import 'package:java_code/utils/extensions/currency_format_to_idr.dart';
import 'package:java_code/utils/services/hive_services.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PesananView extends StatelessWidget {
  const PesananView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(PesananController());
    return Obx(
      () => ConnectionManagerController.to.connectionType.value != 0
          ? WillPopScope(
              onWillPop: () async => false,
              child: Scaffold(
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
                                  // Get.put(DetailMenuController());
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
                                      "order".tr,
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

                      /// MENU PESANAN
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 25.sp),
                          child: ListView(
                            children: [
                              GetBuilder<PesananController>(
                                builder: (_) {
                                  return Conditional.single(
                                    context: context,
                                    conditionBuilder: (context) => PesananController.to.menuHive!.isEmpty,
                                    widgetBuilder: (context) => const SizedBox(),
                                    fallbackBuilder: (context) => Column(
                                      children: [
                                        ListView.builder(
                                          physics: const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: PesananController.to.menuHive!.length,
                                          itemBuilder: (context, index) {
                                            return ItemMenuPesanan(result: PesananController.to.menuHive![index], index: index);
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 25.h),

                      /// BOTTOM KONFIRM
                      Stack(
                        children: [
                          Container(
                            width: ScreenUtil().screenWidth,
                            // ignore: unrelated_type_equality_checks
                            height: PesananController.to.percentDiskon == 0 ? 310.h : 265.h,
                            // height: 310.h,
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
                                            "total_order".tr,
                                            style: GoogleFonts.montserrat(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18.sp,
                                              color: Colours.darkGrey,
                                            ),
                                          ),
                                          SizedBox(width: 10.w),
                                          Text(
                                            "(${PesananController.to.menuHive?.length ?? 0} Menu) :",
                                            style: GoogleFonts.montserrat(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 18.sp,
                                              color: Colours.darkGrey,
                                            ),
                                          ),
                                        ],
                                      ),
                                      GetBuilder<PesananController>(
                                        builder: (_) {
                                          return Text(
                                            (PesananController.to.finalAmount() == 0) ? "0" : CurrencyFormat.convertToIdr(PesananController.to.finalAmount(), 0),
                                            style: GoogleFonts.montserrat(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14.sp,
                                              color: Colours.green2,
                                            ),
                                          );
                                        },
                                      ),
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
                                          Obx(
                                            () => Text(
                                              PesananController.to.percentDiskon.value == 0 ? "discount".tr : "discount ${PesananController.to.percentDiskon.value}".tr,
                                              overflow: TextOverflow.ellipsis,
                                              softWrap: true,
                                              style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 18.sp,
                                                color: Colours.darkGrey,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      InkWell(
                                        onTap: () {
                                          PesananController.to.getDiskonByIdUser();
                                          Get.dialog(
                                            Scaffold(
                                              backgroundColor: Colors.transparent,
                                              body: Obx(
                                                () => ConditionalSwitch.single(
                                                  context: context,
                                                  valueBuilder: (context) => PesananController.to.loadingDiskon.value,
                                                  caseBuilders: {
                                                    'loading': (context) => Center(
                                                          child: SizedBox(
                                                            width: 100.w,
                                                            height: 50.h,
                                                            child: LoadingAnimationWidget.threeRotatingDots(
                                                              color: Colours.green2,
                                                              size: 100,
                                                            ),
                                                          ),
                                                        ),
                                                    'empty': (context) => Center(
                                                          child: Container(
                                                            padding: EdgeInsets.symmetric(vertical: 15.sp),
                                                            width: 300.w,
                                                            height: 150.h,
                                                            decoration: BoxDecoration(
                                                              color: Colors.white,
                                                              borderRadius: BorderRadius.circular(30.r),
                                                            ),
                                                            child: Column(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: [
                                                                Text(
                                                                  'HALO',
                                                                  style: GoogleFonts.montserrat(
                                                                    fontSize: 18.sp,
                                                                    fontWeight: FontWeight.w700,
                                                                    color: Colours.green2,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  'Kamu tidak memiliki diskon',
                                                                  style: GoogleFonts.montserrat(
                                                                    fontSize: 16.sp,
                                                                    fontWeight: FontWeight.w300,
                                                                    color: Colours.textGrey,
                                                                  ),
                                                                ),
                                                                SizedBox(height: 30.h),
                                                                Container(
                                                                  width: 100.w,
                                                                  height: 30.h,
                                                                  decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius.circular(30.r),
                                                                  ),
                                                                  child: ElevatedButton(
                                                                    onPressed: () {
                                                                      Get.back();
                                                                    },
                                                                    style: ElevatedButton.styleFrom(
                                                                        primary: Colours.green2,
                                                                        shape: RoundedRectangleBorder(
                                                                          borderRadius: BorderRadius.circular(30.r),
                                                                        )),
                                                                    child: const Text('Oke'),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                    'error': (context) => Center(
                                                          child: Container(
                                                            width: 300.w,
                                                            height: 100.h,
                                                            decoration: BoxDecoration(
                                                              color: Colors.white,
                                                              borderRadius: BorderRadius.circular(30.r),
                                                            ),
                                                            child: SingleChildScrollView(
                                                              scrollDirection: Axis.vertical,
                                                              child: Column(
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                children: [
                                                                  Text(
                                                                    'HALO',
                                                                    style: GoogleFonts.montserrat(
                                                                      fontSize: 18.sp,
                                                                      fontWeight: FontWeight.w700,
                                                                      color: Colours.green2,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    'Terjadi kesalahan. Tidak dapat mengambil data diskon',
                                                                    textAlign: TextAlign.center,
                                                                    style: GoogleFonts.montserrat(
                                                                      fontSize: 16.sp,
                                                                      fontWeight: FontWeight.w300,
                                                                      color: Colours.textGrey,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                  },
                                                  fallbackBuilder: (context) => Center(
                                                    child: Container(
                                                      width: 300.w,
                                                      height: 500.h,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius: BorderRadius.circular(30.r),
                                                      ),
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                          SizedBox(height: 20.h),
                                                          Text(
                                                            'Info Diskon',
                                                            style: GoogleFonts.montserrat(
                                                              fontSize: 18.sp,
                                                              fontWeight: FontWeight.w700,
                                                              color: Colours.green2,
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: ListView.builder(
                                                              itemCount: PesananController.to.resultDiskon.data?.length ?? 0,
                                                              itemBuilder: (context, index) {
                                                                return InkWell(
                                                                  onTap: () {
                                                                    log('DISKON : ${PesananController.to.resultDiskon.data?[index].diskon} ');
                                                                    PesananController.to.percentDiskon.value = PesananController.to.resultDiskon.data![index].diskon!;
                                                                    Get.back();
                                                                  },
                                                                  child: Padding(
                                                                    padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 5.sp),
                                                                    child: Column(
                                                                      children: [
                                                                        Row(
                                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Text(
                                                                              PesananController.to.resultDiskon.data?[index].nama ?? '',
                                                                              textAlign: TextAlign.center,
                                                                              style: GoogleFonts.montserrat(
                                                                                fontSize: 23.sp,
                                                                                fontWeight: FontWeight.w500,
                                                                                color: Colours.darkGrey,
                                                                              ),
                                                                            ),
                                                                            Text(
                                                                              '${PesananController.to.resultDiskon.data?[index].diskon ?? 0} %',
                                                                              textAlign: TextAlign.center,
                                                                              style: GoogleFonts.montserrat(
                                                                                fontSize: 23.sp,
                                                                                fontWeight: FontWeight.w700,
                                                                                color: Colours.darkGrey,
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        Divider(
                                                                          color: Colours.darkBlack.withOpacity(0.5),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                          // BUTTON OKE
                                                          Container(
                                                            height: 42.h,
                                                            width: 169.w,
                                                            margin: const EdgeInsets.only(
                                                              bottom: 20,
                                                            ),
                                                            child: ElevatedButton(
                                                              onPressed: () {
                                                                PesananController.to.percentDiskon.value = 0;
                                                                Get.back();
                                                              },
                                                              style: ElevatedButton.styleFrom(
                                                                primary: Colours.green2,
                                                                shape: RoundedRectangleBorder(
                                                                  borderRadius: BorderRadius.circular(50),
                                                                ),
                                                              ),
                                                              child: Text(
                                                                "Oke",
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
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 182.w,
                                              child: GetBuilder<PesananController>(
                                                builder: (_) {
                                                  return Text(
                                                    PesananController.to.percentDiskon.value == 0 ? "No_discount_yet".tr : CurrencyFormat.convertToIdr(PesananController.to.diskonAmount(), 0),
                                                    textAlign: TextAlign.end,
                                                    maxLines: 1,
                                                    style: GoogleFonts.montserrat(
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 14.sp,
                                                      color: Colours.red,
                                                    ),
                                                  );
                                                },
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
                                Obx(
                                  () => Conditional.single(
                                    context: context,
                                    conditionBuilder: (context) => PesananController.to.percentDiskon.value != 0,
                                    widgetBuilder: (context) => const SizedBox(),
                                    fallbackBuilder: (context) => Column(
                                      children: [
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
                                                color: Colours.whiteItem,
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
                                                          "choose_voucher".tr,
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
                                        // JARAK
                                        SizedBox(height: 12.h),
                                        // GARIS BATAS
                                        Container(
                                          width: 381.w,
                                          height: 1.h,
                                          decoration: BoxDecoration(
                                            color: Colours.darkGrey.withOpacity(0.25),
                                          ),
                                        ),
                                        SizedBox(height: 12.h),
                                      ],
                                    ),
                                  ),
                                ),

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
                                            "payment".tr,
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
                                            child: GetBuilder<PesananController>(
                                              builder: (value) {
                                                return Text(
                                                  'paylater',
                                                  textAlign: TextAlign.end,
                                                  maxLines: 1,
                                                  style: GoogleFonts.montserrat(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14.sp,
                                                    color: Colours.darkGrey,
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 25.h),
                              ],
                            ),
                          ),
                          // BUTTON KONFIRM PESAN SEKARANG
                          Positioned(
                            bottom: 0,
                            child: Material(
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
                                          margin: EdgeInsets.only(left: 22.sp, right: 9.sp),
                                          child: Row(
                                            children: [
                                              Container(
                                                width: 35.w,
                                                height: 30.h,
                                                decoration: const BoxDecoration(
                                                  image: DecorationImage(
                                                    image: AssetImage(AssetConts.iconKeranjang),
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
                                              "total_payment".tr,
                                              style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12,
                                                color: Colours.darkGrey.withOpacity(0.75),
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            // Conditional.single(
                                            //   context: context,
                                            //   conditionBuilder: (context) => PesananController.to.grandTotalPrice() == null,
                                            //   widgetBuilder: (context) => Text(
                                            //     CurrencyFormat.convertToIdr(0, 0),
                                            //     style: GoogleFonts.montserrat(
                                            //       fontWeight: FontWeight.w700,
                                            //       fontSize: 20,
                                            //       color: Colours.green2,
                                            //     ),
                                            //   ),
                                            //   fallbackBuilder: (context) => FittedBox(
                                            //     child: GetBuilder(
                                            //       builder: (_) {
                                            //         return Text(
                                            //           CurrencyFormat.convertToIdr(PesananController.to.grandTotalPrice(), 0),
                                            //           style: GoogleFonts.montserrat(
                                            //             fontWeight: FontWeight.w700,
                                            //             fontSize: 20,
                                            //             color: Colours.green2,
                                            //           ),
                                            //         );
                                            //       },
                                            //     ),
                                            //   ),
                                            // ),
                                            FittedBox(
                                              child: GetBuilder<PesananController>(
                                                builder: (value) {
                                                  return Text(
                                                    (value.grandTotalPrice() == 0) ? '0' : CurrencyFormat.convertToIdr(value.grandTotalPrice(), 0),
                                                    style: GoogleFonts.montserrat(
                                                      fontWeight: FontWeight.w700,
                                                      fontSize: 20,
                                                      color: Colours.green2,
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    // BUTTON PESAN SEKARANG
                                    Container(
                                      height: 42.h,
                                      width: 169.w,
                                      margin: const EdgeInsets.only(right: 10, left: 20),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Get.defaultDialog(
                                            title: 'verif_order'.tr,
                                            titleStyle: GoogleFonts.montserrat(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 22.sp,
                                              color: Colours.darkGrey,
                                            ),
                                            titlePadding: EdgeInsets.only(top: 24.sp),
                                            content: const ShowDialogIdentify(),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          primary: Colours.green2,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(50),
                                          ),
                                        ),
                                        child: Text(
                                          "order_now".tr,
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
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          : const NoConnectionView(),
    );
  }
}

class ShowDialogIdentify extends StatelessWidget {
  const ShowDialogIdentify({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 338.w,
      child: Column(
        children: [
          Text(
            "finger_print".tr,
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w400,
              fontSize: 16.sp,
              color: const Color(0xff969696),
            ),
          ),
          SizedBox(height: 31.h),
          InkWell(
            onTap: () async {
              Get.back();
              await PesananController.to.authenticateWithBiometrics().then((value) {
                return showOrderSuccessDialog();
              });
            },
            child: SizedBox(
              height: 142.w,
              width: 142.w,
              child: Center(
                child: Image.asset(
                  AssetConts.iconFinger,
                ),
              ),
            ),
          ),
          // SPACE JARAK
          SizedBox(height: 27.h),
          // ATAU
          Row(
            children: [
              const Spacer(flex: 3),
              Container(height: 1, width: 68.w, color: Colors.grey[500]),
              const Spacer(flex: 1),
              Text(
                "or".tr,
                style: GoogleFonts.montserrat(
                  color: Colors.grey[500],
                  fontWeight: FontWeight.w400,
                ),
              ),
              const Spacer(flex: 1),
              Container(height: 1, width: 68.w, color: Colors.grey[500]),
              const Spacer(flex: 3),
            ],
          ),
          // SPACE JARAK

          InkWell(
            onTap: () {
              Get.back(); // MENUTUP DIALOG PERTAMA
              showDialog(
                context: Get.overlayContext!,
                useRootNavigator: false,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return GetBuilder<PesananController>(
                    builder: (value) {
                      return AlertDialog(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(32.0),
                          ),
                        ),
                        content: Container(
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
                          child: Column(children: [
                            Text(
                              "verif_order".tr,
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600,
                                fontSize: 22.sp,
                                color: const Color(0xff2E2E2E),
                              ),
                            ),
                            const SizedBox(height: 13),
                            Text(
                              "insert_pin".tr,
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w400,
                                fontSize: 16.sp,
                                color: const Color(0xff969696),
                              ),
                            ),
                            const SizedBox(height: 36),
                            PinCodeTextField(
                              controller: value.pinController,
                              appContext: context,
                              length: 6,
                              obscureText: true,
                              autoFocus: true,
                              obscuringCharacter: '*',
                              keyboardType: TextInputType.number,
                              focusNode: FocusNode(canRequestFocus: true),
                              errorAnimationController: value.errorController,
                              pinTheme: PinTheme(
                                shape: PinCodeFieldShape.box,
                                borderRadius: BorderRadius.circular(5),
                                fieldHeight: 35,
                                fieldWidth: 35,
                              ),
                              onCompleted: (v) async {
                                await value.checkPin().then(
                                  (_) {
                                    if (value.isSuccess.isTrue) {
                                      Get.back();
                                      showOrderSuccessDialog();
                                    }
                                  },
                                );
                              },
                              onChanged: (String data) {
                                // value.pinController.text = data;
                              },
                            ),
                          ]),
                        ),
                      );
                    },
                  );
                },
              );
            },
            child: Text(
              "verif_using_pin".tr,
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w700,
                fontSize: 16.sp,
                color: Colours.green2,
              ),
            ),
          )
        ],
      ),
    );
  }
}

void showOrderSuccessDialog() {
  AlertDialog orderSuccessDialog = AlertDialog(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(30),
      ),
    ),
    content: GetBuilder<PesananController>(
      builder: (value) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 16),
              child: Image.asset(AssetConts.drawPesananDisiapkan),
            ),
            Container(
              margin: const EdgeInsets.only(top: 16),
              child: Text(
                'order_prepared'.tr,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 22,
                  color: Color.fromRGBO(30, 30, 30, 1),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 8),
              child: Text(
                'you_can_track'.tr,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: Color.fromRGBO(46, 46, 46, 0.5),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 16, bottom: 8),
              child: ElevatedButton(
                onPressed: () async {
                  log('MENUJU TRACKING VIEW');
                  Get.offAll(PesananTrackingView(fromOrder: false), arguments: {"id_order": PesananController.to.postOrderResult.data?.idOrder ?? 0});

                  await HiveServices.deleteMenu(HiveConst.orderHiveKey);
                  Hive.box(HiveConst.orderHiveBox);
                },
                style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(24),
                    ),
                  ),
                  primary: Colours.green2,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  minimumSize: const Size.fromHeight(40),
                  side: const BorderSide(
                    color: Color.fromARGB(255, 0, 113, 127),
                    width: 1,
                  ),
                ),
                child: Text(
                  'ok'.tr,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                  ),
                ),
              ),
            )
          ],
        );
      },
    ),
  );

  showDialog(
    context: Get.overlayContext!,
    builder: (BuildContext context) {
      return orderSuccessDialog;
    },
  );
}
