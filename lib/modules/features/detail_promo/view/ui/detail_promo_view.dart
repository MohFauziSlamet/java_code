import 'package:flutter/material.dart';

import 'package:flutter_conditional_rendering/conditional_switch.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:java_code/config/themes/colours.dart';
import 'package:java_code/constant/core/assets_const.dart';
import 'package:java_code/modules/features/detail_promo/controller/detail_promo_controller.dart';
import 'package:java_code/modules/features/detail_promo/view/componnent/state_view_detail/error_state_detail.dart';
import 'package:java_code/modules/features/detail_promo/view/componnent/state_view_detail/loading_state_detail.dart';
import 'package:java_code/modules/features/no_connecntion/view/ui/no_connection_view.dart';
import 'package:java_code/modules/global_controllers/check_connection_controller.dart';
import 'package:java_code/utils/extensions/currency_format_to_idr.dart';

class DetailPromoView extends StatelessWidget {
  const DetailPromoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(DetailPromoController());
    return Scaffold(
      backgroundColor: Colours.bgColors,
      // CHECK CONNECTION
      body: Obx(
        () => ConnectionManagerController.to.connectionType.value != 0
            ? Obx(
                () => ConditionalSwitch.single(
                  context: context,
                  valueBuilder: (context) =>
                      DetailPromoController.to.loading.value,
                  caseBuilders: {
                    'loading': (context) => const LoadingStateDetailPromoView(),
                    'error': (context) => const ErrorStateDetailPromoView(),
                  },
                  fallbackBuilder: (context) => SafeArea(
                    child: ListView(
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
                                            image: AssetImage(
                                                AssetConts.iconPromo),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 12.w),
                                      Text(
                                        "Promo",
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
                        SizedBox(height: 25.h),

                        /// LOGO PROMO
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Stack(
                              children: [
                                // background
                                Container(
                                  height: 181.h,
                                  width: 378.w,
                                  margin: EdgeInsets.only(left: 25.sp),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(30.sp),
                                    child: Image.asset(
                                      AssetConts.drawBgDiskon,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 181.h,
                                  width: 378.w,
                                  margin: EdgeInsets.only(left: 25.sp),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30.sp),
                                    color: Colours.green2.withOpacity(0.9),
                                  ),
                                ),
                                // SWITCH DISKON / VOUCHER
                                ConditionalSwitch.single(
                                  context: context,
                                  valueBuilder: (context) =>
                                      DetailPromoController
                                          .to.detailPromoResult.data!.type,
                                  caseBuilders: {
                                    'diskon':
                                        (context) => // TEXT INFORMATION DISKON
                                            Container(
                                              height: 181.h,
                                              width: 378.w,
                                              margin:
                                                  EdgeInsets.only(left: 25.sp),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        30.sp),
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  // TEXT DISKON
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      SizedBox(
                                                        width: 80.w,
                                                        height: 21.h,
                                                        child: Text(
                                                          DetailPromoController
                                                              .to
                                                              .detailPromoResult
                                                              .data!
                                                              .type!,
                                                          style: GoogleFonts
                                                              .montserrat(
                                                            color:
                                                                Colours.white,
                                                            fontWeight:
                                                                FontWeight.w800,
                                                            fontSize: 20.sp,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(width: 5.w),
                                                      // NOMINAL VOUCHER
                                                      Stack(
                                                        children: <Widget>[
                                                          Text(
                                                            '${DetailPromoController.to.detailPromoResult.data!.nominal} %',
                                                            style: GoogleFonts
                                                                .montserrat(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w800,
                                                              fontSize: 35.sp,
                                                              foreground:
                                                                  Paint()
                                                                    ..style =
                                                                        PaintingStyle
                                                                            .stroke
                                                                    ..strokeWidth =
                                                                        0.7
                                                                    ..color =
                                                                        Colours
                                                                            .white,
                                                            ),
                                                          ),
                                                          // Solid text as fill.
                                                          Text(
                                                            '${DetailPromoController.to.detailPromoResult.data!.nominal} %',
                                                            style: GoogleFonts
                                                                .montserrat(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w800,
                                                              fontSize: 35.sp,
                                                              color: Colors
                                                                  .transparent,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  // KETERANGAN
                                                  SizedBox(
                                                    width: 220.w,
                                                    height: 40.h,
                                                    child: Text(
                                                      DetailPromoController
                                                          .to
                                                          .detailPromoResult
                                                          .data!
                                                          .nama!,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: GoogleFonts
                                                          .montserrat(
                                                        color: Colours.white
                                                            .withOpacity(0.75),
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                  },
                                  fallbackBuilder:
                                      (context) => // TEXT INFORMATION VOUCHER
                                          Container(
                                    height: 181.h,
                                    width: 378.w,
                                    margin: EdgeInsets.only(left: 25.sp),
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(30.sp),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        // TEXT VOUCHER
                                        Text(
                                          DetailPromoController
                                              .to.detailPromoResult.data!.type!,
                                          style: GoogleFonts.montserrat(
                                            color: Colours.white,
                                            fontWeight: FontWeight.w800,
                                            fontSize: 20.sp,
                                          ),
                                        ),
                                        SizedBox(height: 3.h),
                                        // NOMINAL VOUCHER
                                        Stack(
                                          alignment:
                                              AlignmentDirectional.center,
                                          children: <Widget>[
                                            Text(
                                              CurrencyFormat.convertToIdr(
                                                  DetailPromoController
                                                      .to
                                                      .detailPromoResult
                                                      .data!
                                                      .nominal,
                                                  2),
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.w800,
                                                fontSize: 25.sp,
                                                foreground: Paint()
                                                  ..style = PaintingStyle.stroke
                                                  ..strokeWidth = 0.7
                                                  ..color = Colours.white,
                                              ),
                                            ),
                                            // Solid text as fill.
                                            Text(
                                              CurrencyFormat.convertToIdr(
                                                  DetailPromoController
                                                      .to
                                                      .detailPromoResult
                                                      .data!
                                                      .nominal,
                                                  2),
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.w800,
                                                fontSize: 25.sp,
                                                color: Colors.transparent,
                                              ),
                                            ),
                                          ],
                                        ),
                                        // KETERANGAN
                                        SizedBox(
                                          width: 220.w,
                                          height: 40.h,
                                          child: Text(
                                            DetailPromoController.to
                                                .detailPromoResult.data!.nama!,
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.montserrat(
                                              color: Colours.white
                                                  .withOpacity(0.75),
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 25.h),

                        /// DETAIL
                        Container(
                          height: 600.h,
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
                                margin: const EdgeInsets.only(left: 22),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      DetailPromoController
                                          .to.detailPromoResult.data!.type!,
                                      style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16.sp,
                                        color: Colours.darkGrey,
                                      ),
                                    ),
                                    SizedBox(height: 10.h),

                                    Text(
                                      DetailPromoController
                                          .to.detailPromoResult.data!.nama!,
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20,
                                        color: Colours.green2,
                                      ),
                                    ),
                                    SizedBox(height: 20.h),

                                    /// DIVIDER
                                    Container(
                                      width: 381.w,
                                      height: 0.5.h,
                                      decoration: BoxDecoration(
                                        color:
                                            Colours.darkGrey.withOpacity(0.25),
                                      ),
                                    ),
                                    SizedBox(height: 11.h),

                                    /// SYARAT DAN KETENTUAN
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 26.w,
                                          height: 26.w,
                                          decoration: const BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(AssetConts
                                                  .iconSyaratKetentuan),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 14.25.w),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Syarat dan Ketentuan",
                                              style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16.sp,
                                                color: Colours.darkGrey,
                                              ),
                                            ),
                                            SizedBox(height: 13.h),
                                            SizedBox(
                                              width: 346.w,
                                              child: Html(
                                                data: DetailPromoController
                                                    .to
                                                    .detailPromoResult
                                                    .data!
                                                    .syaratKetentuan,
                                                style: {
                                                  'html': Style(
                                                      fontFamily: GoogleFonts
                                                              .montserrat()
                                                          .toString(),
                                                      color: Colours.green2,
                                                      fontSize: FontSize.large,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      alignment:
                                                          Alignment.centerLeft),
                                                },
                                              ),
                                            ),
                                            // SizedBox(
                                            //   width: 346.w,
                                            //   child: Text(
                                            //     "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea vommodo consequat.",
                                            //     softWrap: true,
                                            //     maxLines: 10,
                                            //     style: GoogleFonts.montserrat(
                                            //       fontWeight: FontWeight.w600,
                                            //       fontSize: 16.sp,
                                            //       color: Colours.darkGrey,
                                            //     ),
                                            //   ),
                                            // ),
                                          ],
                                        ),
                                      ],
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
                ),
              )
            : const NoConnectionView(),
      ),
    );
  }
}
