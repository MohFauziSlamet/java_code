import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional_switch.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:java_code/config/themes/colours.dart';
import 'package:java_code/constant/core/assets_const.dart';
import 'package:java_code/modules/features/no_connecntion/view/ui/no_connection_view.dart';
import 'package:java_code/modules/features/pilih_voucher/controller/voucher_controller.dart';
import 'package:java_code/modules/global_controllers/check_connection_controller.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';

class PilihVoucherView extends StatelessWidget {
  const PilihVoucherView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(VoucherController());
    return Scaffold(
      backgroundColor: Colours.bgColors,
      // check connection
      body: Obx(
        () => ConnectionManagerController.to.connectionType.value != 0
            ? SafeArea(
                child: Column(
                  children: [
                    /// APPBAR PROMO
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
                                  Container(
                                    width: 20.w,
                                    height: 14.h,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image:
                                            AssetImage(AssetConts.iconVoucher),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 12.w),
                                  Text(
                                    "Pilih Voucher",
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
                    SizedBox(height: 29.h),
                    Expanded(
                      child: ListView(
                        children: [
                          Obx(
                            () => ConditionalSwitch.single(
                              context: context,
                              valueBuilder: (context) =>
                                  VoucherController.to.loadingVoucher.value,
                              caseBuilders: {
                                'loading': (context) => Center(
                                      child: SizedBox(
                                        height: 20.h,
                                        width: 120.w,
                                        child: Center(
                                          child: LoadingAnimationWidget
                                              .prograssiveDots(
                                                  color: Colours.green2,
                                                  size: 100),
                                        ),
                                      ),
                                    ),
                                'empty': (context) => Center(
                                      child: SizedBox(
                                        height: 500.h,
                                        width: 500.w,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              'Maaf kamu belum memiliki voucher',
                                              style: GoogleFonts.montserrat(
                                                fontSize: 20.sp,
                                                fontWeight: FontWeight.w600,
                                                color: Colours.green2,
                                              ),
                                            ),
                                            Lottie.asset(
                                                AssetConts.lottieEmptyVoucher),
                                          ],
                                        ),
                                      ),
                                    ),
                                'error': (context) => Center(
                                      child: SizedBox(
                                        height: 500.h,
                                        width: 500.w,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              'Terjadi kesalahan pada saat mengambil voucher',
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.montserrat(
                                                fontSize: 20.sp,
                                                fontWeight: FontWeight.w600,
                                                color: Colours.green2,
                                              ),
                                            ),
                                            Lottie.asset(
                                                AssetConts.lottieErrorState),
                                          ],
                                        ),
                                      ),
                                    ),
                              },
                              fallbackBuilder: (context) {
                                return ListView.builder(
                                  itemCount: VoucherController
                                          .to.resultVoucher.data?.length ??
                                      0,
                                  itemBuilder: (context, index) {
                                    return

                                        /// VOUCHER
                                        Container(
                                      width: 377.w,
                                      height: 216.h,
                                      margin: EdgeInsets.only(
                                          left: 26.sp,
                                          right: 26.sp,
                                          bottom: 17.35.sp),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Card(
                                        elevation: 3,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Column(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                    left: 15.sp, right: 13.sp),
                                                decoration: BoxDecoration(
                                                  color: Colours.whiteItem,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(15.r),
                                                    topRight:
                                                        Radius.circular(15.r),
                                                  ),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    // NAMA
                                                    Text(
                                                      VoucherController
                                                              .to
                                                              .resultVoucher
                                                              .data?[index]
                                                              .nama ??
                                                          "",
                                                      style: GoogleFonts
                                                          .montserrat(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 16.sp,
                                                        color: Colours.darkGrey,
                                                      ),
                                                    ),
                                                    // BOX CEKLIS
                                                    Container(
                                                      height: 17.w,
                                                      width: 17.w,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4.r),
                                                        border: Border.all(
                                                            color: Colours
                                                                .darkGrey),
                                                      ),
                                                      child: Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 5.sp,
                                                                horizontal:
                                                                    3.sp),
                                                        child: FadeInImage(
                                                          fit: BoxFit.cover,
                                                          placeholder:
                                                              const AssetImage(
                                                                  AssetConts
                                                                      .gifLoadingImage),
                                                          image: NetworkImage(
                                                            VoucherController
                                                                    .to
                                                                    .resultVoucher
                                                                    .data?[
                                                                        index]
                                                                    .infoVoucher ??
                                                                "",
                                                          ),
                                                          imageErrorBuilder: (context,
                                                                  error,
                                                                  stackTrace) =>
                                                              Image.asset(
                                                                  AssetConts
                                                                      .iconEmptyMenu,
                                                                  fit: BoxFit
                                                                      .cover),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 377.w,
                                              height: 174.28.h,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                color: Colours.whiteItem,
                                                image: const DecorationImage(
                                                  image: AssetImage(
                                                      AssetConts.drawVoucher),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    /// DETAIL
                    Container(
                      height: 106.h,
                      decoration: BoxDecoration(
                        color: Colours.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.sp),
                          topRight: Radius.circular(30.sp),
                        ),
                      ),
                      child: Column(
                        children: [
                          //TEXT PENGUMUMAM
                          Container(
                            margin: EdgeInsets.only(top: 9.sp, left: 38.sp),
                            child: Row(
                              children: [
                                // ICON CEKLIS
                                Container(
                                  height: 12.w,
                                  width: 12.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.sp),
                                    border: Border.all(
                                      color: Colours.green2,
                                    ),
                                  ),
                                  child: Center(
                                    child: Image.asset(
                                      AssetConts.iconCeklis,
                                      color: Colours.green2,
                                    ),
                                  ),
                                ),
                                // JARAK SPACE
                                SizedBox(
                                  width: 8.w,
                                ),
                                // TEXT WARNING PERHATIAN
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Penggunaan voucher tidak dapat digabung dengan",
                                      style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 13.sp,
                                        color: Colours.darkGrey,
                                      ),
                                    ),
                                    Text(
                                      "discount employee reward program",
                                      style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 13.sp,
                                        color: Colours.green2,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // SPACE JARAK
                          SizedBox(height: 10.h),
                          // BUTTON
                          Center(
                            child: SizedBox(
                              width: 377.w,
                              height: 42.h,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                child: Text(
                                  "Oke",
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16.sp,
                                    color: Colours.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : const NoConnectionView(),
      ),
    );
  }
}
