import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:java_code/config/themes/colours.dart';

class EmptyStatePromoView extends StatelessWidget {
  const EmptyStatePromoView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: ScreenUtil().screenWidth * 0.7,
        height: 158.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Terjadi Kesalahan Promo Kosong',
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w400,
                fontSize: 18.sp,
                color: Colours.green2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
