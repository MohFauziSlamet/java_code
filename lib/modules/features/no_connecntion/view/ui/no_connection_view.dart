import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:java_code/config/themes/colours.dart';
import 'package:java_code/constant/core/assets_const.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoConnectionView extends StatelessWidget {
  const NoConnectionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.bgColors,
      body: Stack(
        children: [
          // BACKGROUND
          Image.asset(AssetConts.backgroundLoadingLokasi),

          // CONTENT LOGO JAVACODE / ICON NO CONNECTION / BUTTON KEMABALI
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // LOGO JAVA CODE
                Image.asset(AssetConts.drawJavaCode),
                SizedBox(
                  height: 90.h,
                  width: ScreenUtil().screenWidth * 0.6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.signal_wifi_off,
                        color: Colours.grey,
                        size: 45.sp,
                      ),
                      Text(
                        'Koneksi Anda Terputus',
                        style: GoogleFonts.montserrat(color: Colours.grey),
                      ),
                    ],
                  ),
                ),

                // BUTTON KEMBALI
                Container(
                  width: 120.w,
                  height: 30.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colours.green2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.r),
                        side: const BorderSide(
                          color: Colours.white,
                          width: 1,
                        ),
                      ),
                    ),
                    onPressed: () {},
                    child: Text(
                      'Kembali',
                      style: GoogleFonts.montserrat(color: Colours.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
