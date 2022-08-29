import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:java_code/config/themes/colours.dart';
import 'package:get/get.dart';
import 'package:java_code/constant/core/assets_const.dart';

class CheckoutView extends StatelessWidget {
  const CheckoutView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RxInt current = 0.obs;
    RxInt keranjang = 0.obs;

    List<String> nameButton = [
      'Sedang Berjalan',
      'Riwayat',
    ];
    List<String> textEmpty = [
      'Sudah Pesan? \nLacak pesananmu di sini.',
      'Makanan yang kamu pesan akan muncul disini agar kamu bisa menemukan menu favoritmu lagi!',
    ];
    List<Widget> widgetEmpty = [
      SedangBerjalanEmpty(),
      SedangBerjalanEmpty(),
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
                      margin: EdgeInsets.only(left: 46),
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
                              child: Container(
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
                      ? Expanded(
                          child: ListView.builder(
                            itemCount: 6,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.only(
                                    left: 25, right: 25, bottom: 16),
                                child: Material(
                                  elevation: 3,
                                  shadowColor:
                                      Colours.darkGrey.withOpacity(0.35),
                                  borderRadius:
                                      BorderRadiusDirectional.circular(10),
                                  child: Container(
                                    width: 378.w,
                                    height: 138.h,
                                    decoration: BoxDecoration(
                                      color: Colours.whiteItem,
                                      borderRadius:
                                          BorderRadiusDirectional.circular(10),
                                    ),
                                    child: Row(
                                      children: [
                                        // GAMBAR
                                        Container(
                                          margin: EdgeInsets.all(7.sp),
                                          width: 124.w,
                                          height: 124.w,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.asset(
                                                AssetConts.drawChickenKatsu,
                                                fit: BoxFit.cover),
                                          ),
                                        )
                                        // ROW DETAIL
                                        ,
                                        SizedBox(width: 3.w),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              // STATUS DAN DATE
                                              SizedBox(height: 10.h),
                                              Row(
                                                children: [
                                                  // STATUS
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
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
                                                        child: Text(
                                                          "Sedang disiapkan",
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: GoogleFonts
                                                              .montserrat(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 12.sp,
                                                            color: Colours
                                                                .textYellow,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  // TANGGAL
                                                  SizedBox(width: 19.w),
                                                  Text(
                                                    "20 Des 2021",
                                                    style:
                                                        GoogleFonts.montserrat(
                                                      fontWeight:
                                                          FontWeight.w500,
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
                                                child: Text(
                                                  "Fried Rice,\nChicken Katsu",
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
                                                      "Rp 19.000",
                                                      style: GoogleFonts
                                                          .montserrat(
                                                        fontWeight:
                                                            FontWeight.w500,
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
                                                      "(3 Menu)",
                                                      style: GoogleFonts
                                                          .montserrat(
                                                        fontWeight:
                                                            FontWeight.w500,
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
                              );
                            },
                          ),
                        )
                      // RIWAYAT
                      : Expanded(
                          child: Column(
                            children: [
                              // BUTTON STATUS DAN DATE
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 25.sp),
                                height: 37.h,
                                width: ScreenUtil().screenWidth,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // BUTTON STATUS
                                    Container(
                                      height: 37.h,
                                      width: 178.w,
                                      decoration: BoxDecoration(
                                        color: Colours.whiteItem,
                                        borderRadius: BorderRadius.circular(30),
                                        border:
                                            Border.all(color: Colours.green2),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Semua Status",
                                            style: GoogleFonts.montserrat(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16.sp,
                                              color: Colours.darkGrey,
                                            ),
                                          ),
                                          SizedBox(width: 4.w),
                                          SizedBox(
                                            child: Image.asset(
                                                AssetConts.iconDropdown),
                                          )
                                        ],
                                      ),
                                    ),
                                    // BUTTON DATE
                                    Container(
                                      height: 37.h,
                                      width: 178.w,
                                      decoration: BoxDecoration(
                                        color: Colours.whiteItem,
                                        borderRadius: BorderRadius.circular(30),
                                        border:
                                            Border.all(color: Colours.green2),
                                      ),
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            left: 17.sp, right: 13.sp),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              height: 17.h,
                                              width: 118.w,
                                              child: Text(
                                                "25/12/21 - 30/12/21",
                                                style: GoogleFonts.montserrat(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14.sp,
                                                  color: Colours.textGrey,
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {},
                                              child: Container(
                                                height: 20.h,
                                                width: 18.w,
                                                child: Image.asset(
                                                    AssetConts.iconKalender),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(height: 24.h), // JARAK
                              Expanded(
                                child: ListView(
                                  children: [
                                    // SELESAI
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: 3,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          margin: EdgeInsets.only(
                                              left: 25, right: 25, bottom: 16),
                                          child: Material(
                                            elevation: 3,
                                            shadowColor: Colours.darkGrey
                                                .withOpacity(0.35),
                                            borderRadius:
                                                BorderRadiusDirectional
                                                    .circular(10),
                                            child: Container(
                                              width: 378.w,
                                              height: 138.h,
                                              decoration: BoxDecoration(
                                                color: Colours.whiteItem,
                                                borderRadius:
                                                    BorderRadiusDirectional
                                                        .circular(10),
                                              ),
                                              child: Row(
                                                children: [
                                                  // GAMBAR
                                                  Container(
                                                    margin:
                                                        EdgeInsets.all(7.sp),
                                                    width: 124.w,
                                                    height: 124.w,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      child: Image.asset(
                                                          AssetConts
                                                              .drawChickenKatsu,
                                                          fit: BoxFit.cover),
                                                    ),
                                                  )
                                                  // ROW DETAIL
                                                  ,
                                                  SizedBox(width: 3.w),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        // STATUS DAN DATE
                                                        SizedBox(height: 10.h),
                                                        Row(
                                                          children: [
                                                            // STATUS
                                                            Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                SizedBox(
                                                                  width: 12.w,
                                                                  height: 12.w,
                                                                  child: Center(
                                                                    child: Image
                                                                        .asset(
                                                                      AssetConts
                                                                          .iconCeklis,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                      color: Colours
                                                                          .textGreen,
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                    width: 5.w),
                                                                SizedBox(
                                                                  width: 115.w,
                                                                  height: 21.h,
                                                                  child: Text(
                                                                    "Selesai",
                                                                    style: GoogleFonts
                                                                        .montserrat(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontSize:
                                                                          12.sp,
                                                                      color: Colours
                                                                          .textGreen,
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                            // TANGGAL
                                                            SizedBox(
                                                                width: 19.w),
                                                            Text(
                                                              "20 Des 2021",
                                                              style: GoogleFonts
                                                                  .montserrat(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 12.sp,
                                                                color: Colours
                                                                    .textGrey,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        // NAMA MAKANAN

                                                        SizedBox(
                                                          height: 43.h,
                                                          child: Text(
                                                            "Fried Rice,\nChicken Katsu",
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: GoogleFonts
                                                                .montserrat(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 18.sp,
                                                              color: Colours
                                                                  .darkGrey,
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
                                                                "Rp 19.000",
                                                                style: GoogleFonts
                                                                    .montserrat(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize:
                                                                      14.sp,
                                                                  color: Colours
                                                                      .green2,
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                width: 5.w),
                                                            SizedBox(
                                                              height: 21.h,
                                                              width: 72.w,
                                                              child: Text(
                                                                "(3 Menu)",
                                                                style: GoogleFonts
                                                                    .montserrat(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize:
                                                                      14.sp,
                                                                  color: Colours
                                                                      .textGrey,
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
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              21),
                                                                  border: Border.all(
                                                                      color: Colours
                                                                          .green)),
                                                              child: Center(
                                                                child: Text(
                                                                  "Beri Penilaian",
                                                                  style: GoogleFonts
                                                                      .montserrat(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                    fontSize:
                                                                        10.sp,
                                                                    color: Colours
                                                                        .green2,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                width: 13.w),
                                                            //PESAN LAGI
                                                            Container(
                                                              height: 21.h,
                                                              width: 92.w,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            21),
                                                                border:
                                                                    Border.all(
                                                                  color: Colours
                                                                      .green,
                                                                ),
                                                              ),
                                                              child:
                                                                  ElevatedButton(
                                                                onPressed:
                                                                    () {},
                                                                style: ElevatedButton
                                                                    .styleFrom(
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            21),
                                                                  ),
                                                                ),
                                                                child: Center(
                                                                  child: Text(
                                                                    "Pesan Lagi",
                                                                    style: GoogleFonts
                                                                        .montserrat(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                      fontSize:
                                                                          10.sp,
                                                                      color: Colours
                                                                          .white,
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
                                      },
                                    ),
                                    // DIBATALKAN
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: 3,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          margin: EdgeInsets.only(
                                              left: 25, right: 25, bottom: 16),
                                          child: Material(
                                            elevation: 3,
                                            shadowColor: Colours.darkGrey
                                                .withOpacity(0.35),
                                            borderRadius:
                                                BorderRadiusDirectional
                                                    .circular(10),
                                            child: Container(
                                              width: 378.w,
                                              height: 138.h,
                                              decoration: BoxDecoration(
                                                color: Colours.whiteItem,
                                                borderRadius:
                                                    BorderRadiusDirectional
                                                        .circular(10),
                                              ),
                                              child: Row(
                                                children: [
                                                  // GAMBAR BATAL
                                                  Container(
                                                    margin:
                                                        EdgeInsets.all(7.sp),
                                                    width: 124.w,
                                                    height: 124.w,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      child: Image.asset(
                                                          AssetConts
                                                              .drawChickenKatsu,
                                                          fit: BoxFit.cover),
                                                    ),
                                                  ),
                                                  // ROW DETAIL BATAL
                                                  SizedBox(width: 3.w),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        // STATUS DAN DATE BATAL
                                                        SizedBox(height: 10.h),
                                                        Row(
                                                          children: [
                                                            // STATUS BATAL
                                                            Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                SizedBox(
                                                                  width: 14.w,
                                                                  height: 14.w,
                                                                  child: Center(
                                                                    child: Image
                                                                        .asset(
                                                                      AssetConts
                                                                          .iconBatal,
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                    width: 5.w),
                                                                SizedBox(
                                                                  width: 115.w,
                                                                  height: 21.h,
                                                                  child: Text(
                                                                    "Dibatakan",
                                                                    style: GoogleFonts
                                                                        .montserrat(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontSize:
                                                                          12.sp,
                                                                      color: Colours
                                                                          .red,
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                            // TANGGAL
                                                            SizedBox(
                                                                width: 19.w),
                                                            Text(
                                                              "20 Des 2021",
                                                              style: GoogleFonts
                                                                  .montserrat(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 12.sp,
                                                                color: Colours
                                                                    .textGrey,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        // NAMA MAKANAN
                                                        SizedBox(
                                                          height: 43.h,
                                                          child: Text(
                                                            "Fried Rice,\nChicken Katsu",
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: GoogleFonts
                                                                .montserrat(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 18.sp,
                                                              color: Colours
                                                                  .darkGrey,
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
                                                                "Rp 19.000",
                                                                style: GoogleFonts
                                                                    .montserrat(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize:
                                                                      14.sp,
                                                                  color: Colours
                                                                      .green2,
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                width: 5.w),
                                                            SizedBox(
                                                              height: 21.h,
                                                              width: 72.w,
                                                              child: Text(
                                                                "(3 Menu)",
                                                                style: GoogleFonts
                                                                    .montserrat(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize:
                                                                      14.sp,
                                                                  color: Colours
                                                                      .textGrey,
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
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        21),
                                                            border: Border.all(
                                                              color:
                                                                  Colours.green,
                                                            ),
                                                          ),
                                                          child: ElevatedButton(
                                                            onPressed: () {},
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            21),
                                                              ),
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                "Pesan Lagi",
                                                                style: GoogleFonts
                                                                    .montserrat(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  fontSize:
                                                                      10.sp,
                                                                  color: Colours
                                                                      .white,
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
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                  // EMPTY
                  : Obx(
                      () => Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 43.sp, vertical: 24.sp),
                          width: ScreenUtil().screenWidth,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  AssetConts.backgroundLoadingLokasi),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 206.w,
                                width: 206.w,
                                child: Image.asset(
                                  AssetConts.iconEmpty,
                                ),
                              ),
                              SizedBox(height: 25.75.h),
                              SizedBox(
                                width: 326.w,
                                height: 170.h,
                                child: (current.value != 1)
                                    ? Text(
                                        textEmpty[current.value],
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 22.sp,
                                          color: Colours.darkBlack,
                                        ),
                                      )
                                    : Column(
                                        children: [
                                          Text(
                                            "Mulai Buat Pesanan",
                                            style: GoogleFonts.montserrat(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 22.sp,
                                              color: Colours.darkBlack,
                                            ),
                                          ),
                                          SizedBox(height: 10.h),
                                          Text(
                                            textEmpty[current.value],
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.montserrat(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 22.sp,
                                              color: Colours.darkBlack,
                                            ),
                                          )
                                        ],
                                      ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget SedangBerjalanEmpty() {
  return Container(
    width: ScreenUtil().screenWidth,
    margin: EdgeInsets.symmetric(horizontal: 43.sp, vertical: 24.sp),
    decoration: const BoxDecoration(
      color: Colors.amber,
      image: DecorationImage(
        image: AssetImage(AssetConts.backgroundLoadingLokasi),
      ),
    ),
  );
}
