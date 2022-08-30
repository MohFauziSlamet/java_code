import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:java_code/modules/features/checkout/view/components/checkout_empty_state.dart';
import '/modules/features/checkout/view/components/checkout_riwayat.dart';
import '/config/themes/colours.dart';

import '/modules/features/checkout/view/components/checkout_sedang_berjalan.dart';

class CheckoutView extends StatelessWidget {
  const CheckoutView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RxInt current = 0.obs;
    RxInt keranjang = 1.obs;

    List<String> nameButton = [
      'Sedang Berjalan',
      'Riwayat',
    ];
    List<String> textEmpty = [
      'Sudah Pesan? \nLacak pesananmu di sini.',
      'Makanan yang kamu pesan akan muncul disini agar kamu bisa menemukan menu favoritmu lagi!',
    ];

    return Scaffold(
      backgroundColor: Colours.bgColors,
      body: SafeArea(
        child: Column(
          children: [
            // APPBAR
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
                child: Column(
                  children: [
                    SizedBox(height: 15.h),
                    Container(
                      height: 40.h,
                      margin: EdgeInsets.only(left: 46.sp),
                      width: ScreenUtil().screenWidth,
                      child: ListView.builder(
                        itemCount: 2,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Obx(
                            () => InkWell(
                              onTap: () {
                                current.value = index;
                              },
                              child: SizedBox(
                                width: 173.w,
                                child: Column(
                                  children: [
                                    Text(
                                      nameButton[index],
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20.sp,
                                        color: current.value == index
                                            ? Colours.green2
                                            : Colours.darkGrey,
                                      ),
                                    ),
                                    SizedBox(height: 8.h),
                                    Visibility(
                                      child: Container(
                                        height: 5.h,
                                        width: 65.w,
                                        decoration: BoxDecoration(
                                          color: current.value == index
                                              ? Colours.green2
                                              : Colors.transparent,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 25.h),
            // CONTENT
            Obx(
              () => keranjang.value != 0
                  ? current.value == 0
                      // SEDANG BERJALAN
                      ? const CheckoutSedangBerjalan()
                      // RIWAYAT
                      : const CheckoutRiwayat()
                  // EMPTY
                  : Obx(
                      () => CheckoutEmptyState(
                          current: current, textEmpty: textEmpty),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
