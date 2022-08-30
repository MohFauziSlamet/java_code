import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/config/themes/colours.dart';
import '/constant/core/assets_const.dart';

class CheckoutSedangBerjalan extends StatelessWidget {
  const CheckoutSedangBerjalan({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 6,
              itemBuilder: (context, index) {
                return Container(
                  margin:
                      const EdgeInsets.only(left: 25, right: 25, bottom: 16),
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
                              child: Image.asset(AssetConts.drawChickenKatsu,
                                  fit: BoxFit.cover),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                            textAlign: TextAlign.left,
                                            style: GoogleFonts.montserrat(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12.sp,
                                              color: Colours.textYellow,
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
