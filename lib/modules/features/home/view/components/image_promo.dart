import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:java_code/config/routes/app_routes.dart';
import 'package:java_code/config/themes/colours.dart';
import 'package:java_code/constant/core/assets_const.dart';
import 'package:java_code/modules/models/all_promo_res/data_promo.dart';
import 'package:java_code/utils/extensions/currency_format_to_idr.dart';

// ignore: must_be_immutable
class ImagePromo extends StatelessWidget {
  ImagePromo({Key? key, required this.resultPromo}) : super(key: key);

  DataPromo resultPromo;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(
          AppRoutes.detailPromo,
          arguments: resultPromo.idPromo, // DIGUNAKAN PADA CONTROLLER
        );
      },
      child: Stack(
        children: [
          // background
          Container(
            height: 158.h,
            width: 282.w,
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
            height: 158.h,
            width: 282.w,
            margin: EdgeInsets.only(left: 25.sp),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.sp),
              color: Colours.green2.withOpacity(0.9),
            ),
          ),
          // TEXT INFORMATION
          Container(
            height: 158.h,
            width: 282.w,
            margin: EdgeInsets.only(left: 25.sp),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.sp),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // TEXT VOUCHER
                Text(
                  'Voucher',
                  style: GoogleFonts.montserrat(
                    color: Colours.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 20.sp,
                  ),
                ),
                SizedBox(height: 3.h),
                // NOMINAL VOUCHER
                Stack(
                  alignment: AlignmentDirectional.center,
                  children: <Widget>[
                    Text(
                      CurrencyFormat.convertToIdr(resultPromo.nominal, 0),
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
                      CurrencyFormat.convertToIdr(resultPromo.nominal, 0),
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
                    resultPromo.nama!,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      color: Colours.white.withOpacity(0.75),
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
    // return Image.asset(imageUrl);
  }
}
