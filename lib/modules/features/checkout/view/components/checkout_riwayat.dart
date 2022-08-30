import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '/config/themes/colours.dart';
import '/constant/core/assets_const.dart';

class CheckoutRiwayat extends StatelessWidget {
  const CheckoutRiwayat({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                              child: Image.asset(AssetConts.iconDropdown),
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
                          border: Border.all(color: Colours.green2),
                        ),
                        child: Container(
                          margin: EdgeInsets.only(left: 17.sp, right: 13.sp),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  child: Image.asset(AssetConts.iconKalender),
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
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 3,
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
                                        borderRadius: BorderRadius.circular(10),
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
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    width: 12.w,
                                                    height: 12.w,
                                                    child: Center(
                                                      child: Image.asset(
                                                        AssetConts.iconCeklis,
                                                        fit: BoxFit.cover,
                                                        color:
                                                            Colours.textGreen,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 5.w),
                                                  SizedBox(
                                                    width: 115.w,
                                                    height: 21.h,
                                                    child: Text(
                                                      "Selesai",
                                                      style: GoogleFonts
                                                          .montserrat(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 12.sp,
                                                        color:
                                                            Colours.textGreen,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              // TANGGAL
                                              SizedBox(width: 19.w),
                                              Text(
                                                "20 Des 2021",
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
                                                  "(3 Menu)",
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
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            21),
                                                    border: Border.all(
                                                        color: Colours.green)),
                                                child: Center(
                                                  child: Text(
                                                    "Beri Penilaian",
                                                    style:
                                                        GoogleFonts.montserrat(
                                                      fontWeight:
                                                          FontWeight.w700,
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
                                                  borderRadius:
                                                      BorderRadius.circular(21),
                                                  border: Border.all(
                                                    color: Colours.green,
                                                  ),
                                                ),
                                                child: ElevatedButton(
                                                  onPressed: () {},
                                                  style:
                                                      ElevatedButton.styleFrom(
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
                                                            FontWeight.w700,
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
                        },
                      ),
                      // DIBATALKAN
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(
                                left: 25, right: 25, bottom: 16),
                            child: Material(
                              elevation: 3,
                              shadowColor: Colours.darkGrey.withOpacity(0.35),
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
                                    // GAMBAR BATAL
                                    Container(
                                      margin: EdgeInsets.all(7.sp),
                                      width: 124.w,
                                      height: 124.w,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.asset(
                                            AssetConts.drawChickenKatsu,
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                    // ROW DETAIL BATAL
                                    SizedBox(width: 3.w),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // STATUS DAN DATE BATAL
                                          SizedBox(height: 10.h),
                                          Row(
                                            children: [
                                              // STATUS BATAL
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
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
                                                      "Dibatakan",
                                                      style: GoogleFonts
                                                          .montserrat(
                                                        fontWeight:
                                                            FontWeight.w500,
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
                                                "20 Des 2021",
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
                                                  "(3 Menu)",
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
                                              borderRadius:
                                                  BorderRadius.circular(21),
                                              border: Border.all(
                                                color: Colours.green,
                                              ),
                                            ),
                                            child: ElevatedButton(
                                              onPressed: () {},
                                              style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(21),
                                                ),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "Pesan Lagi",
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
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // BOTTOM TOTAL
          Container(
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
                    'Total Pesanan',
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: Colours.darkGrey),
                  ),
                  Text(
                    'Rp. 18.000',
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: Colours.green2),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
