import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:java_code/config/themes/colours.dart';
import 'package:java_code/constant/core/assets_const.dart';
import 'package:lottie/lottie.dart';

class ErrorStateView extends StatelessWidget {
  const ErrorStateView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: ScreenUtil().screenWidth * 0.7,
        height: 400.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Terjadi Kesalahan Tidak Dapat Memuat Menu',
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w400,
                fontSize: 18.sp,
                color: Colours.green2,
              ),
            ),
            Container(
              padding: EdgeInsets.all(20.sp),
              width: ScreenUtil().screenHeight * 0.7,
              height: 300.h,
              child: Lottie.asset(AssetConts.lottieErrorState),
            ),
          ],
        ),
      ),
    );
  }
}
