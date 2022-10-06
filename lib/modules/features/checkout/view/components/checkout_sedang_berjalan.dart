import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:java_code/config/routes/app_routes.dart';
import 'package:java_code/modules/features/checkout/controller/checkout_controller.dart';
import 'package:java_code/modules/models/get_order_by_user_id/data_order.dart';
import 'package:java_code/modules/models/get_order_by_user_id/get_order_by_user_id.dart';
import 'package:java_code/utils/extensions/currency_format_to_idr.dart';
import '/config/themes/colours.dart';
import '/constant/core/assets_const.dart';
import 'package:get/get.dart';

class CheckoutSedangBerjalan extends StatelessWidget {
  const CheckoutSedangBerjalan({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GetOrderByUserId res = CheckoutController.to.resultOrder;
    List<DataOrder> reversedRes = res.data!.reversed.toList();
    // log('isi res sedang berjalan : $res');
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: reversedRes.length,
              itemBuilder: (context, index) {
                return (reversedRes[index].status! < 3)
                    ? InkWell(
                        onTap: () {
                          Get.toNamed(AppRoutes.pesananTrackingView, arguments: {"id_order": reversedRes[index].idOrder});
                          log('ANDA MENUJU TRACKING VIEW');
                          log('ID ORDER : ${reversedRes[index].idOrder}');
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 25, right: 25, bottom: 16),
                          child: Material(
                            elevation: 3,
                            shadowColor: Colours.darkGrey.withOpacity(0.35),
                            borderRadius: BorderRadiusDirectional.circular(10),
                            child: Container(
                              width: 378.w,
                              height: 138.h,
                              decoration: BoxDecoration(
                                color: Colours.whiteItem,
                                borderRadius: BorderRadiusDirectional.circular(10),
                              ),
                              child: Row(
                                children: [
                                  // GAMBAR
                                  Container(
                                    margin: EdgeInsets.all(7.sp),
                                    width: 124.w,
                                    height: 124.w,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: FadeInImage(
                                        fit: BoxFit.contain,
                                        placeholder: const AssetImage(AssetConts.gifLoadingImage),
                                        image: NetworkImage(
                                          reversedRes[index].menu?[0].foto ?? "",
                                          // res.data?[index].menu?[0].foto ?? "",
                                        ),
                                        imageErrorBuilder: (context, error, stackTrace) => Image.asset(AssetConts.iconEmptyMenu, fit: BoxFit.cover),
                                      ),
                                    ),
                                  )
                                  // ROW DETAIL
                                  ,
                                  SizedBox(width: 3.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        // STATUS DAN DATE
                                        SizedBox(height: 10.h),
                                        Row(
                                          children: [
                                            // STATUS
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: 11.w,
                                                  height: 11.w,
                                                  child: Image.asset(
                                                    AssetConts.iconTime,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                SizedBox(width: 5.w),
                                                SizedBox(
                                                  width: 115.w,
                                                  height: 21.h,
                                                  child: ConditionalSwitch.single(
                                                    context: context,
                                                    valueBuilder: (context) => reversedRes[index].status.toString(),
                                                    // valueBuilder: (context) => res.data?[index].status.toString(),
                                                    caseBuilders: {
                                                      '1': (context) => Text(
                                                            "being_prepared".tr,
                                                            textAlign: TextAlign.left,
                                                            style: GoogleFonts.montserrat(
                                                              fontWeight: FontWeight.w500,
                                                              fontSize: 12.sp,
                                                              color: Colours.textYellow,
                                                            ),
                                                          ),
                                                      '2': (context) => Text(
                                                            "can_take".tr,
                                                            textAlign: TextAlign.left,
                                                            style: GoogleFonts.montserrat(
                                                              fontWeight: FontWeight.w500,
                                                              fontSize: 12.sp,
                                                              color: Colours.textYellow,
                                                            ),
                                                          ),
                                                    },
                                                    fallbackBuilder: (context) => Text(
                                                      "in_queue".tr,
                                                      textAlign: TextAlign.left,
                                                      style: GoogleFonts.montserrat(
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 12.sp,
                                                        color: Colours.textYellow,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            // TANGGAL
                                            SizedBox(width: 19.w),
                                            Text(
                                              reversedRes[index].tanggal!,
                                              // res.data![index].tanggal!,
                                              style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12.sp,
                                                color: Colours.textGrey,
                                              ),
                                            )
                                          ],
                                        ),
                                        // NAMA MAKANAN
                                        SizedBox(height: 14.h),
                                        SizedBox(
                                          height: 43.h,
                                          width: 160.h,
                                          child: Text(
                                            reversedRes[index].menu?[0].nama ?? "",
                                            // res.data?[index].menu?[0].nama ?? "",
                                            textAlign: TextAlign.left,
                                            softWrap: true,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: GoogleFonts.montserrat(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 18.sp,
                                              color: Colours.darkGrey,
                                            ),
                                          ),
                                        ),

                                        // HARGA DAN JUMLAH MENU
                                        SizedBox(height: 2.h),
                                        Row(
                                          children: [
                                            SizedBox(
                                              height: 21.h,
                                              width: 77.w,
                                              child: Text(
                                                CurrencyFormat.convertToIdr(reversedRes[index].totalBayar ?? 0, 0),
                                                // CurrencyFormat.convertToIdr(res.data?[index].totalBayar ?? 0, 0),
                                                style: GoogleFonts.montserrat(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14.sp,
                                                  color: Colours.green2,
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 5.w),
                                            SizedBox(
                                              height: 21.h,
                                              width: 72.w,
                                              child: Text(
                                                "(${reversedRes[index].menu?.length ?? 0} Menu)",
                                                // "(${res.data?[index].menu?.length ?? 0} Menu)",
                                                style: GoogleFonts.montserrat(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14.sp,
                                                  color: Colours.textGrey,
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
                            ),
                          ),
                        ),
                      )
                    : const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}
