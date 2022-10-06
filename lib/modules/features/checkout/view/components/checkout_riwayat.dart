// ignore_for_file: prefer_is_empty

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:java_code/modules/features/checkout/controller/checkout_controller.dart';
import 'package:java_code/modules/features/checkout/view/components/checkout_empty_state.dart';
import 'package:java_code/utils/extensions/currency_format_to_idr.dart';
import '/config/themes/colours.dart';
import '/constant/core/assets_const.dart';
import 'package:get/get.dart';

class CheckoutRiwayat extends StatelessWidget {
  const CheckoutRiwayat({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CheckoutController>(
      init: CheckoutController(),
      builder: (value) {
        return Expanded(
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    // BUTTON STATUS DAN DATE
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 25.sp),
                      height: 37.h,
                      width: ScreenUtil().screenWidth,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // BUTTON STATUS
                          Container(
                            height: 37.h,
                            width: 178.w,
                            decoration: BoxDecoration(
                              color: Colours.whiteItem,
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: Colours.green2),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    isDense: true,
                                    icon: const Icon(Icons.arrow_drop_down),
                                    value: value.selectedDropdownItem.value,
                                    items: value.dropdownItems.map((item) {
                                      return DropdownMenuItem(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      // value.selectedDropdownItem =
                                      //     newValue!;
                                      log('data : $newValue');
                                      value.filterData(newValue!);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // BUTTON DATE
                          InkWell(
                            onTap: () {
                              value.showMyDatePicker();
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colours.green2,
                                ),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(30),
                                ),
                                color: const Color.fromRGBO(246, 246, 246, 1),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    '${value.startDateString} - ${value.endDateString} ',
                                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12.sp, color: Colours.grey),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 8),
                                    child: const Icon(
                                      Icons.calendar_month,
                                      color: Colours.green2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24.h),
                    Obx(
                      () => ConditionalSwitch.single(
                        context: context,
                        valueBuilder: (context) => value.selectedDropdownItem,
                        caseBuilders: {
                          // SELESAI
                          'done'.tr: (context) => (value.listSelesai?.length != 0)
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: value.listSelesai!.length,
                                  itemBuilder: (context, index) {
                                    return ListView.builder(
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemCount: value.listSelesai![index].menu!.length,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            margin: EdgeInsets.only(
                                              left: 25.sp,
                                              right: 25.sp,
                                              bottom: 16.sp,
                                            ),
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
                                                            value.listSelesai?[index].menu?[index].foto ?? '',
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
                                                                    width: 12.w,
                                                                    height: 12.w,
                                                                    child: Center(
                                                                      child: Image.asset(
                                                                        AssetConts.iconCeklis,
                                                                        fit: BoxFit.cover,
                                                                        color: Colours.textGreen,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(width: 5.w),
                                                                  SizedBox(
                                                                    width: 115.w,
                                                                    height: 21.h,
                                                                    child: Text(
                                                                      "done".tr,
                                                                      style: GoogleFonts.montserrat(
                                                                        fontWeight: FontWeight.w500,
                                                                        fontSize: 12.sp,
                                                                        color: Colours.textGreen,
                                                                      ),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                              // TANGGAL
                                                              SizedBox(width: 19.w),
                                                              Text(
                                                                value.listSelesai?[index].tanggal ?? '',
                                                                style: GoogleFonts.montserrat(
                                                                  fontWeight: FontWeight.w500,
                                                                  fontSize: 12.sp,
                                                                  color: Colours.textGrey,
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          // NAMA MAKANAN
                                                          SizedBox(
                                                            height: 43.h,
                                                            child: Text(
                                                              value.listSelesai?[index].menu?[index].nama ?? '',
                                                              textAlign: TextAlign.left,
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
                                                                  CurrencyFormat.convertToIdr(int.parse(value.listSelesai?[index].menu?[index].harga ?? "0"), 0),
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
                                                                  "(${value.listSelesai?[index].menu?[index].jumlah ?? 0} Menu)",
                                                                  style: GoogleFonts.montserrat(
                                                                    fontWeight: FontWeight.w500,
                                                                    fontSize: 14.sp,
                                                                    color: Colours.textGrey,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          // BUTTON PENILAIAN DAN PESAN LAGI
                                                          SizedBox(height: 9.h),
                                                          Row(
                                                            children: [
                                                              // BERI PENILAIAN
                                                              Container(
                                                                height: 21.h,
                                                                width: 92.w,
                                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(21), border: Border.all(color: Colours.green)),
                                                                child: Center(
                                                                  child: Text(
                                                                    "give_rating".tr,
                                                                    style: GoogleFonts.montserrat(
                                                                      fontWeight: FontWeight.w700,
                                                                      fontSize: 10.sp,
                                                                      color: Colours.green2,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(width: 13.w),
                                                              //PESAN LAGI
                                                              Container(
                                                                height: 21.h,
                                                                width: 92.w,
                                                                decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(21),
                                                                  border: Border.all(
                                                                    color: Colours.green,
                                                                  ),
                                                                ),
                                                                child: ElevatedButton(
                                                                  onPressed: () {
                                                                    value.pesanLagiFunction(order: value.listSelesai![index]);
                                                                  },
                                                                  style: ElevatedButton.styleFrom(
                                                                    shape: RoundedRectangleBorder(
                                                                      borderRadius: BorderRadius.circular(21),
                                                                    ),
                                                                  ),
                                                                  child: Center(
                                                                    child: Text(
                                                                      "order_again".tr,
                                                                      style: GoogleFonts.montserrat(
                                                                        fontWeight: FontWeight.w700,
                                                                        fontSize: 10.sp,
                                                                        color: Colours.white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        });
                                  },
                                )
                              : CheckoutEmptyState(current: CheckoutController.to.current, textEmpty: CheckoutController.to.textEmpty),

                          'canceled'.tr: (context) => (value.listDibatalkan?.length != 0)
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: value.listDibatalkan!.length,
                                  itemBuilder: (context, index) {
                                    return ListView.builder(
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemCount: value.listDibatalkan![index].menu!.length,
                                        itemBuilder: (context, index) {
                                          return Container(
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
                                                    // GAMBAR BATAL
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
                                                            value.listDibatalkan?[index].menu?[index].foto ?? '',
                                                          ),
                                                          imageErrorBuilder: (context, error, stackTrace) => Image.asset(AssetConts.iconEmptyMenu, fit: BoxFit.cover),
                                                        ),
                                                      ),
                                                    ),
                                                    // ROW DETAIL BATAL
                                                    SizedBox(width: 3.w),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          // STATUS DAN DATE BATAL
                                                          SizedBox(height: 10.h),
                                                          Row(
                                                            children: [
                                                              // STATUS BATAL
                                                              Row(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  SizedBox(
                                                                    width: 14.w,
                                                                    height: 14.w,
                                                                    child: Center(
                                                                      child: Image.asset(
                                                                        AssetConts.iconBatal,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(width: 5.w),
                                                                  SizedBox(
                                                                    width: 115.w,
                                                                    height: 21.h,
                                                                    child: Text(
                                                                      "canceled".tr,
                                                                      style: GoogleFonts.montserrat(
                                                                        fontWeight: FontWeight.w500,
                                                                        fontSize: 12.sp,
                                                                        color: Colours.red,
                                                                      ),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                              // TANGGAL
                                                              SizedBox(width: 19.w),
                                                              Text(
                                                                value.listDibatalkan?[index].tanggal ?? '',
                                                                style: GoogleFonts.montserrat(
                                                                  fontWeight: FontWeight.w500,
                                                                  fontSize: 12.sp,
                                                                  color: Colours.textGrey,
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          // NAMA MAKANAN
                                                          SizedBox(
                                                            height: 43.h,
                                                            child: Text(
                                                              value.listDibatalkan?[index].menu?[index].nama ?? '',
                                                              textAlign: TextAlign.left,
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
                                                                  CurrencyFormat.convertToIdr(int.parse(value.listDibatalkan?[index].menu?[index].harga ?? "0"), 0),
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
                                                                  "(${value.listDibatalkan?[index].menu?[index].jumlah ?? 0} Menu)",
                                                                  style: GoogleFonts.montserrat(
                                                                    fontWeight: FontWeight.w500,
                                                                    fontSize: 14.sp,
                                                                    color: Colours.textGrey,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          // BUTTON PESAN LAGI BATAL
                                                          SizedBox(height: 4.h),
                                                          Container(
                                                            height: 21.h,
                                                            width: 92.w,
                                                            decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(21),
                                                              border: Border.all(
                                                                color: Colours.green,
                                                              ),
                                                            ),
                                                            child: ElevatedButton(
                                                              onPressed: () {
                                                                value.pesanLagiFunction(order: value.listDibatalkan![index]);
                                                              },
                                                              style: ElevatedButton.styleFrom(
                                                                shape: RoundedRectangleBorder(
                                                                  borderRadius: BorderRadius.circular(21),
                                                                ),
                                                              ),
                                                              child: Center(
                                                                child: Text(
                                                                  "order_again".tr,
                                                                  style: GoogleFonts.montserrat(
                                                                    fontWeight: FontWeight.w700,
                                                                    fontSize: 10.sp,
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
                                              ),
                                            ),
                                          );
                                        });
                                  },
                                )
                              : CheckoutEmptyState(current: CheckoutController.to.current, textEmpty: CheckoutController.to.textEmpty),
                        },
                        // semua status
                        fallbackBuilder: (context) => Conditional.single(
                          context: context,
                          conditionBuilder: (context) => value.orderHistory.data?.listData?.length == 0,
                          widgetBuilder: (context) => CheckoutEmptyState(current: CheckoutController.to.current, textEmpty: CheckoutController.to.textEmpty),
                          fallbackBuilder: (context) => Expanded(
                            child: ListView(
                              children: [
                                (value.orderHistory.data?.listData?.length != 0)
                                    ? ListView(
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        children: [
                                          // SELESAI
                                          // CHEK DATA NULL APA TIDAK UNTUK POIN SELESAI
                                          (value.listSelesai?.length != 0)
                                              ? ListView.builder(
                                                  shrinkWrap: true,
                                                  physics: const NeverScrollableScrollPhysics(),
                                                  itemCount: value.listSelesai!.length,
                                                  itemBuilder: (context, index) {
                                                    return ListView.builder(
                                                        shrinkWrap: true,
                                                        physics: const NeverScrollableScrollPhysics(),
                                                        itemCount: value.listSelesai![index].menu!.length,
                                                        itemBuilder: (context, index) {
                                                          return Container(
                                                            margin: EdgeInsets.only(
                                                              left: 25.sp,
                                                              right: 25.sp,
                                                              bottom: 16.sp,
                                                            ),
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
                                                                            value.listSelesai?[index].menu?[index].foto ?? '',
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
                                                                                    width: 12.w,
                                                                                    height: 12.w,
                                                                                    child: Center(
                                                                                      child: Image.asset(
                                                                                        AssetConts.iconCeklis,
                                                                                        fit: BoxFit.cover,
                                                                                        color: Colours.textGreen,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  SizedBox(width: 5.w),
                                                                                  SizedBox(
                                                                                    width: 115.w,
                                                                                    height: 21.h,
                                                                                    child: Text(
                                                                                      "done".tr,
                                                                                      style: GoogleFonts.montserrat(
                                                                                        fontWeight: FontWeight.w500,
                                                                                        fontSize: 12.sp,
                                                                                        color: Colours.textGreen,
                                                                                      ),
                                                                                    ),
                                                                                  )
                                                                                ],
                                                                              ),
                                                                              // TANGGAL
                                                                              SizedBox(width: 19.w),
                                                                              Text(
                                                                                value.listSelesai?[index].tanggal ?? '',
                                                                                style: GoogleFonts.montserrat(
                                                                                  fontWeight: FontWeight.w500,
                                                                                  fontSize: 12.sp,
                                                                                  color: Colours.textGrey,
                                                                                ),
                                                                              )
                                                                            ],
                                                                          ),
                                                                          // NAMA MAKANAN

                                                                          SizedBox(
                                                                            height: 43.h,
                                                                            child: Text(
                                                                              value.listSelesai?[index].menu?[index].nama ?? '',
                                                                              textAlign: TextAlign.left,
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
                                                                                  CurrencyFormat.convertToIdr(int.parse(value.listSelesai?[index].menu?[index].harga ?? "0"), 0),
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
                                                                                  "(${value.listSelesai?[index].menu?[index].jumlah ?? 0} Menu)",
                                                                                  style: GoogleFonts.montserrat(
                                                                                    fontWeight: FontWeight.w500,
                                                                                    fontSize: 14.sp,
                                                                                    color: Colours.textGrey,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          // BUTTON PENILAIAN DAN PESAN LAGI
                                                                          SizedBox(height: 9.h),
                                                                          Row(
                                                                            children: [
                                                                              // BERI PENILAIAN
                                                                              Container(
                                                                                height: 21.h,
                                                                                width: 92.w,
                                                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(21), border: Border.all(color: Colours.green)),
                                                                                child: Center(
                                                                                  child: Text(
                                                                                    "give_rating".tr,
                                                                                    style: GoogleFonts.montserrat(
                                                                                      fontWeight: FontWeight.w700,
                                                                                      fontSize: 10.sp,
                                                                                      color: Colours.green2,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              SizedBox(width: 13.w),
                                                                              //PESAN LAGI
                                                                              Container(
                                                                                height: 21.h,
                                                                                width: 92.w,
                                                                                decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius.circular(21),
                                                                                  border: Border.all(
                                                                                    color: Colours.green,
                                                                                  ),
                                                                                ),
                                                                                child: ElevatedButton(
                                                                                  onPressed: () {
                                                                                    value.pesanLagiFunction(order: value.listSelesai![index]);
                                                                                  },
                                                                                  style: ElevatedButton.styleFrom(
                                                                                    shape: RoundedRectangleBorder(
                                                                                      borderRadius: BorderRadius.circular(21),
                                                                                    ),
                                                                                  ),
                                                                                  child: Center(
                                                                                    child: Text(
                                                                                      "order_again".tr,
                                                                                      style: GoogleFonts.montserrat(
                                                                                        fontWeight: FontWeight.w700,
                                                                                        fontSize: 10.sp,
                                                                                        color: Colours.white,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        });
                                                  },
                                                )
                                              : const SizedBox(),

                                          // DIBATALKAN
                                          // CHEK DATA NULL APA TIDAK UNTUK POIN DIBATALKAN
                                          (value.listDibatalkan?.length != 0)
                                              ? ListView.builder(
                                                  shrinkWrap: true,
                                                  physics: const NeverScrollableScrollPhysics(),
                                                  itemCount: value.listDibatalkan!.length,
                                                  itemBuilder: (context, index) {
                                                    return ListView.builder(
                                                        shrinkWrap: true,
                                                        physics: const NeverScrollableScrollPhysics(),
                                                        itemCount: value.listDibatalkan![index].menu!.length,
                                                        itemBuilder: (context, index) {
                                                          return Container(
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
                                                                    // GAMBAR BATAL
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
                                                                            value.listDibatalkan?[index].menu?[index].foto ?? '',
                                                                          ),
                                                                          imageErrorBuilder: (context, error, stackTrace) => Image.asset(AssetConts.iconEmptyMenu, fit: BoxFit.cover),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    // ROW DETAIL BATAL
                                                                    SizedBox(width: 3.w),
                                                                    Expanded(
                                                                      child: Column(
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                        children: [
                                                                          // STATUS DAN DATE BATAL
                                                                          SizedBox(height: 10.h),
                                                                          Row(
                                                                            children: [
                                                                              // STATUS BATAL
                                                                              Row(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  SizedBox(
                                                                                    width: 14.w,
                                                                                    height: 14.w,
                                                                                    child: Center(
                                                                                      child: Image.asset(
                                                                                        AssetConts.iconBatal,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  SizedBox(width: 5.w),
                                                                                  SizedBox(
                                                                                    width: 115.w,
                                                                                    height: 21.h,
                                                                                    child: Text(
                                                                                      "canceled".tr,
                                                                                      style: GoogleFonts.montserrat(
                                                                                        fontWeight: FontWeight.w500,
                                                                                        fontSize: 12.sp,
                                                                                        color: Colours.red,
                                                                                      ),
                                                                                    ),
                                                                                  )
                                                                                ],
                                                                              ),
                                                                              // TANGGAL
                                                                              SizedBox(width: 19.w),
                                                                              Text(
                                                                                value.listDibatalkan?[index].tanggal ?? '',
                                                                                style: GoogleFonts.montserrat(
                                                                                  fontWeight: FontWeight.w500,
                                                                                  fontSize: 12.sp,
                                                                                  color: Colours.textGrey,
                                                                                ),
                                                                              )
                                                                            ],
                                                                          ),
                                                                          // NAMA MAKANAN
                                                                          SizedBox(
                                                                            height: 43.h,
                                                                            child: Text(
                                                                              value.listDibatalkan?[index].menu?[index].nama ?? '',
                                                                              textAlign: TextAlign.left,
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
                                                                                  CurrencyFormat.convertToIdr(int.parse(value.listDibatalkan?[index].menu?[index].harga ?? "0"), 0),
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
                                                                                  "(${value.listDibatalkan?[index].menu?[index].jumlah ?? 0} Menu)",
                                                                                  style: GoogleFonts.montserrat(
                                                                                    fontWeight: FontWeight.w500,
                                                                                    fontSize: 14.sp,
                                                                                    color: Colours.textGrey,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          // BUTTON PESAN LAGI BATAL
                                                                          SizedBox(height: 4.h),
                                                                          Container(
                                                                            height: 21.h,
                                                                            width: 92.w,
                                                                            decoration: BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(21),
                                                                              border: Border.all(
                                                                                color: Colours.green,
                                                                              ),
                                                                            ),
                                                                            child: ElevatedButton(
                                                                              onPressed: () {
                                                                                value.pesanLagiFunction(order: value.listDibatalkan![index]);
                                                                              },
                                                                              style: ElevatedButton.styleFrom(
                                                                                shape: RoundedRectangleBorder(
                                                                                  borderRadius: BorderRadius.circular(21),
                                                                                ),
                                                                              ),
                                                                              child: Center(
                                                                                child: Text(
                                                                                  "order_again".tr,
                                                                                  style: GoogleFonts.montserrat(
                                                                                    fontWeight: FontWeight.w700,
                                                                                    fontSize: 10.sp,
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
                                                              ),
                                                            ),
                                                          );
                                                        });
                                                  },
                                                )
                                              : const SizedBox()
                                        ],
                                      )
                                    : CheckoutEmptyState(current: CheckoutController.to.current, textEmpty: CheckoutController.to.textEmpty),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // BOTTOM TOTAL
              GetBuilder<CheckoutController>(
                builder: (value) {
                  return Container(
                    height: 50.h,
                    width: ScreenUtil().screenWidth,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.r),
                        topRight: Radius.circular(30.r),
                      ),
                      color: Colours.whiteItem,
                    ),
                    child: Container(
                      height: 21.h,
                      width: ScreenUtil().screenWidth,
                      margin: EdgeInsets.only(left: 22.sp, right: 25.sp, top: 15.sp),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'total_order'.tr,
                            style: GoogleFonts.montserrat(fontWeight: FontWeight.w700, fontSize: 18, color: Colours.darkGrey),
                          ),
                          Text(
                            CurrencyFormat.convertToIdr(int.parse("${value.orderHistory.data?.totalPrice ?? 0}"), 0),
                            style: GoogleFonts.montserrat(fontWeight: FontWeight.w700, fontSize: 18, color: Colours.green2),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
