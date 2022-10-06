import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:java_code/config/themes/colours.dart';
import 'package:java_code/constant/core/assets_const.dart';
import 'package:java_code/modules/features/home/view/components/state_view_status_menu/empty_state_view.dart';
import 'package:java_code/modules/features/home/view/components/state_view_status_menu/error_state_view.dart';
import 'package:java_code/modules/features/home/view/ui/dashboard_view.dart';
import 'package:java_code/modules/features/no_connecntion/view/ui/no_connection_view.dart';
import 'package:java_code/modules/features/pesanan_tracking/controller/pesanan_tracking_controller.dart';
import 'package:java_code/modules/features/pesanan_tracking/ui/componen/item_tracking_pesanan.dart';
import 'package:java_code/modules/global_controllers/check_connection_controller.dart';
import 'package:java_code/utils/extensions/currency_format_to_idr.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

// ignore: must_be_immutable
class PesananTrackingView extends StatelessWidget {
  PesananTrackingView({Key? key, required this.fromOrder}) : super(key: key);
  bool fromOrder;

  @override
  Widget build(BuildContext context) {
    Get.put(PesananTrackingController());
    return ConnectionManagerController.to.connectionType.value != 0
        ? GetBuilder<PesananTrackingController>(
            init: PesananTrackingController(),
            dispose: (state) => PesananTrackingController(),
            builder: (value) {
              return ConditionalSwitch.single(
                context: context,
                valueBuilder: (context) => value.loading.value,
                caseBuilders: {
                  'loading': (context) => Center(
                        child: Scaffold(
                          backgroundColor: Colours.bgColors,
                          body: Center(child: LoadingAnimationWidget.prograssiveDots(color: Colours.green2, size: 100)),
                        ),
                      ),
                  'empty': (context) => const Scaffold(backgroundColor: Colours.bgColors, body: EmptyStateView()),
                  'error': (context) => const Scaffold(backgroundColor: Colours.bgColors, body: ErrorStateView()),
                },
                fallbackBuilder: (context) => WillPopScope(
                  onWillPop: () async {
                    if (fromOrder) {
                      Get.back();
                    } else {
                      Get.offAll(const DashboardView());
                    }
                    return true;
                  },
                  child: SafeArea(
                    child: Scaffold(
                      backgroundColor: Colours.bgColors,
                      body: Column(
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
                                      if (fromOrder) {
                                        Get.back();
                                      } else {
                                        Get.offAll(const DashboardView());
                                      }
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
                                  ListView.builder(
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: value.orderDetailResponse.data?.detail?.length ?? 0,
                                    itemBuilder: (context, index) {
                                      // log('PESANAN TRACKING VIEW => ISI DATA : ${value.orderDetailResponse}');
                                      return ItemTrackingPesanan(orderDetailResponse: value.orderDetailResponse, index: index);
                                      // result: PesananTrackingController.to.orderDetailResponse,
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 25.h),

                          /// DETAIL PESANAN
                          Stack(
                            children: [
                              Container(
                                width: ScreenUtil().screenWidth,
                                // ignore: unrelated_type_equality_checks
                                height: 400.h,
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
                                    // TOTAL PESANAN DAN HARGA
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
                                                "(${value.orderDetailResponse.data?.detail?.length ?? 0} Menu) :",
                                                style: GoogleFonts.montserrat(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 18.sp,
                                                  color: Colours.darkGrey,
                                                ),
                                              ),
                                            ],
                                          ),
                                          GetBuilder<PesananTrackingController>(
                                            builder: (_) {
                                              return Text(
                                                CurrencyFormat.convertToIdr(value.orderDetailResponse.data?.order?.totalBayar ?? 0, 0),
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
                                    // GARIS PEMBATAS
                                    Container(
                                      width: 381.w,
                                      height: 1.h,
                                      decoration: BoxDecoration(
                                        color: Colours.darkGrey.withOpacity(0.25),
                                      ),
                                    ),
                                    SizedBox(height: 12.h),
                                    // DISKON 20%
                                    Conditional.single(
                                      context: context,
                                      conditionBuilder: (context) => value.orderDetailResponse.data?.order?.diskon == 0,
                                      widgetBuilder: (context) => const SizedBox(),
                                      fallbackBuilder: (context) => Column(
                                        children: [
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
                                                      "discount".tr,
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
                                                        CurrencyFormat.convertToIdr(value.orderDetailResponse.data?.order?.potongan, 0),
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
                                          //GARIS PEMBATAS
                                          Container(
                                            width: 381.w,
                                            height: 1.h,
                                            decoration: BoxDecoration(
                                              color: Colours.darkGrey.withOpacity(0.25.sp),
                                            ),
                                          ),
                                          SizedBox(height: 12.h),
                                        ],
                                      ),
                                    ),
                                    // VOUCHER
                                    Conditional.single(
                                      context: context,
                                      conditionBuilder: (context) => value.orderDetailResponse.data?.order?.diskon != 0,
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
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 182.w,
                                                      child: Conditional.single(
                                                        context: context,
                                                        conditionBuilder: (context) => value.orderDetailResponse.data?.order?.idVoucher != 0,
                                                        widgetBuilder: (context) => Column(
                                                          mainAxisAlignment: MainAxisAlignment.end,
                                                          crossAxisAlignment: CrossAxisAlignment.end,
                                                          children: [
                                                            Text(
                                                              CurrencyFormat.convertToIdr(value.orderDetailResponse.data?.order?.potongan, 0),
                                                              textAlign: TextAlign.end,
                                                              maxLines: 1,
                                                              style: GoogleFonts.montserrat(
                                                                fontWeight: FontWeight.w400,
                                                                fontSize: 14.sp,
                                                                color: Colours.red,
                                                              ),
                                                            ),
                                                            Text(
                                                              value.orderDetailResponse.data?.order?.namaVoucher,
                                                              textAlign: TextAlign.end,
                                                              maxLines: 1,
                                                              style: GoogleFonts.montserrat(
                                                                fontWeight: FontWeight.w500,
                                                                fontSize: 10.sp,
                                                                color: Colours.darkGrey.withOpacity(0.75),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        fallbackBuilder: (context) => Text(
                                                          "no_voucher".tr,
                                                          textAlign: TextAlign.end,
                                                          maxLines: 1,
                                                          style: GoogleFonts.montserrat(
                                                            fontWeight: FontWeight.w400,
                                                            fontSize: 14.sp,
                                                            color: Colours.darkGrey,
                                                          ),
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
                                    // METHODE PEMBAYARAN
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
                                                child: Text(
                                                  'paylater',
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
                                    SizedBox(height: 12.h),
                                    //GARIS PEMBATAS
                                    Container(
                                      width: 381.w,
                                      height: 1.h,
                                      decoration: BoxDecoration(
                                        color: Colours.darkGrey.withOpacity(0.25.sp),
                                      ),
                                    ),
                                    // TOTAL BAYAR
                                    SizedBox(height: 12.h),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 23.sp),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            "total_payment".tr,
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: true,
                                            style: GoogleFonts.montserrat(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18.sp,
                                              color: Colours.darkGrey,
                                            ),
                                          ),
                                          GetBuilder<PesananTrackingController>(builder: (_) {
                                            return SizedBox(
                                              width: 182.w,
                                              child: Text(
                                                CurrencyFormat.convertToIdr(value.orderDetailResponse.data?.order?.totalBayar ?? 0, 0),
                                                textAlign: TextAlign.end,
                                                maxLines: 1,
                                                style: GoogleFonts.montserrat(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 18.sp,
                                                  color: Colours.green2,
                                                ),
                                              ),
                                            );
                                          }),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 12.h),
                                    //GARIS PEMBATAS
                                    Container(
                                      width: 381.w,
                                      height: 1.h,
                                      decoration: BoxDecoration(
                                        color: Colours.darkGrey.withOpacity(0.25.sp),
                                      ),
                                    ),
                                    SizedBox(height: 24.h),

                                    /// TIMELINE PESANAN
                                    Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            // Get.to(ChooseVoucherView());
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 12),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "order_is_prepared".tr,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                                const SizedBox(height: 14),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      flex: 1,
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          value.orderDetailResponse.data!.order!.status! >= 1 && value.orderDetailResponse.data!.order!.status! < 4
                                                              ? const Icon(
                                                                  Icons.check_circle_rounded,
                                                                  color: Colours.green2,
                                                                  size: 24,
                                                                )
                                                              : Icon(
                                                                  Icons.circle,
                                                                  color: Colours.darkBlack.withOpacity(0.2),
                                                                  size: 24,
                                                                ),
                                                          const SizedBox(height: 4),
                                                          Text(
                                                            "order_is_accepted".tr,
                                                            textAlign: TextAlign.center,
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Divider(
                                                        thickness: 3,
                                                        color: value.orderDetailResponse.data!.order!.status! >= 2 && PesananTrackingController.to.orderDetailResponse.data!.order!.status! < 4 ? Colours.green2 : null,
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          value.orderDetailResponse.data!.order!.status! >= 2 && value.orderDetailResponse.data!.order!.status! < 4
                                                              ? const Icon(
                                                                  Icons.check_circle_rounded,
                                                                  color: Colours.green2,
                                                                  size: 24,
                                                                )
                                                              : Icon(
                                                                  Icons.circle,
                                                                  color: Colours.darkBlack.withOpacity(0.2),
                                                                  size: 24,
                                                                ),
                                                          const SizedBox(height: 4),
                                                          Text(
                                                            "you_can_take_it".tr,
                                                            textAlign: TextAlign.center,
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Divider(thickness: 3, color: value.orderDetailResponse.data?.order?.status == 3 ? Colours.green2 : null),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          value.orderDetailResponse.data?.order?.status == 3
                                                              ? const Icon(
                                                                  Icons.check_circle_rounded,
                                                                  color: Colours.green2,
                                                                  size: 24,
                                                                )
                                                              : Icon(
                                                                  Icons.circle,
                                                                  color: Colours.darkBlack.withOpacity(0.2),
                                                                  size: 24,
                                                                ),
                                                          const SizedBox(height: 4),
                                                          Text(
                                                            "order_is_done".tr,
                                                            textAlign: TextAlign.center,
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          )
        : const NoConnectionView();
  }
}
