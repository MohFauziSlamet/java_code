import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:java_code/config/themes/colours.dart';
import 'package:java_code/constant/core/assets_const.dart';

class LoadingLokasi extends StatelessWidget {
  const LoadingLokasi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            /// BACKGROUND
            Center(
              child: Container(
                width: 359.w,
                height: 799.h,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AssetConts.backgroundLoadingLokasi),
                  ),
                ),
              ),
            ),
            Center(
              child: Column(
                children: [
                  SizedBox(height: 208.h),

                  /// MENCARI LOKASI
                  Text(
                    "Mencari Lokasimu",
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w400,
                        fontSize: 22.sp,
                        color: Colours.darkBlack.withOpacity(0.5)),
                  ),

                  /// ICON MENCARI LOKASI
                  Container(
                    width: 190.w,
                    height: 190.w,
                    margin: EdgeInsets.symmetric(vertical: 49.sp),
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(AssetConts.drawLoadingLokasi),
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Image.asset(AssetConts.iconMap),
                    ),
                  ),

                  /// ALAMAT LOKASI
                  SizedBox(
                    width: 245.w,
                    height: 170.h,
                    child: Text(
                      "Perumahan Griyashanta Permata N-524, Mojolangu, Kec. Lowokwaru, Kota Malang",
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w600,
                        fontSize: 22.sp,
                        color: Colours.darkBlack,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}