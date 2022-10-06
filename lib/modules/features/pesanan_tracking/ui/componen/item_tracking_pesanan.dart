// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:java_code/config/themes/colours.dart';
import 'package:java_code/constant/core/assets_const.dart';
import 'package:java_code/modules/features/pesanan_tracking/controller/pesanan_tracking_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:java_code/modules/models/get_detail_order_res_by_id_struk/get_detail_order_res_by_id_struk.dart';
import 'package:java_code/utils/extensions/currency_format_to_idr.dart';

class ItemTrackingPesanan extends StatelessWidget {
  ItemTrackingPesanan({
    Key? key,
    // required this.result,
    required this.index,
    required this.orderDetailResponse,
  }) : super(key: key);

  // GetDetailOrderResByIdStruk result;
  int index;
  GetDetailOrderResByIdStruk orderDetailResponse;

  @override
  Widget build(BuildContext context) {
    // log('ITEM PESANAN TRACKING VIEW => ISI DATA : ${result.data?.detail?[index].nama}');
    return GetBuilder<PesananTrackingController>(
      builder: (controller) => Container(
        margin: EdgeInsets.only(bottom: 17.sp),
        child: Material(
          elevation: 4.sp,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 90.h,
            width: 378.w,
            decoration: BoxDecoration(
              color: Colours.whiteItem,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                /// GAMBAR MENU
                Container(
                  margin: const EdgeInsets.all(7),
                  height: 75.w,
                  width: 75.w,
                  decoration: BoxDecoration(
                    color: const Color(0xffDFDFDF),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: SizedBox(
                      width: 75.w,
                      height: 75.w,
                      child: FadeInImage(
                        fit: BoxFit.cover,
                        placeholder: const AssetImage(AssetConts.gifLoadingImage),
                        image: NetworkImage(
                          orderDetailResponse.data?.detail?[index].foto ?? '',
                        ),
                        imageErrorBuilder: (context, error, stackTrace) => Image.asset(AssetConts.iconEmptyMenu, fit: BoxFit.cover),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 5.sp),

                /// NAMA/HARGA/CATATAN
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /// NAMA MENU
                      SizedBox(height: 7.sp),
                      FittedBox(
                        child: Text(
                          orderDetailResponse.data!.detail![index].nama!,
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w500,
                            fontSize: 23.sp,
                            color: Colours.darkGrey,
                          ),
                        ),
                      ),

                      /// HARGA MENU
                      FittedBox(
                        child: Text(
                          CurrencyFormat.convertToIdr(orderDetailResponse.data!.detail![index].total ?? 0, 2),
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w700,
                            fontSize: 18.sp,
                            color: Colours.green2,
                          ),
                        ),
                      ),
                      const SizedBox(height: 3),

                      /// ICON TAMBAH  NOTE
                      Row(
                        children: [
                          Container(
                            height: 11.h,
                            width: 13.w,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                  AssetConts.iconTambahNote,
                                ),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          const SizedBox(width: 7),
                          SizedBox(
                            width: Get.width * 0.3,
                            child: Text(
                              "add_note".tr,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w500,
                                fontSize: 12.sp,
                                color: Colours.textGrey,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 14.sp),
                    ],
                  ),
                ),

                /// TOMBOL TAMBAH, KURANG, COUNT
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // BUTTON KURANG
                    Material(
                      child: SizedBox(
                        height: 21.w,
                        width: 21.w,
                        child: Conditional.single(
                          context: context,
                          conditionBuilder: (context) => orderDetailResponse.data!.detail![index].jumlah! > 0,
                          widgetBuilder: (context) => Image.asset(
                            AssetConts.iconKurang,
                          ),
                          fallbackBuilder: (context) => Container(
                            color: Colours.whiteItem,
                          ),
                        ),
                      ),
                    ),

                    // JUMLAH COUNT
                    const SizedBox(width: 11),
                    Text(
                      orderDetailResponse.data!.detail![index].jumlah!.toString(),
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w500,
                        fontSize: 18.sp,
                      ),
                    ),

                    SizedBox(width: 11.w),
                    // BUTTON TAMBAH
                    Material(
                      child: SizedBox(
                        height: 21.w,
                        width: 21.w,
                        child: Image.asset(
                          AssetConts.iconTambah,
                        ),
                      ),
                    ),

                    const SizedBox(width: 9)
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
