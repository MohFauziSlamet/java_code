import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:java_code/config/themes/colours.dart';
import 'package:java_code/constant/core/assets_const.dart';

Widget iconNotifcation() {
  return Stack(
    children: [
      Center(
        child: SizedBox(
          height: 149.w,
          width: 149.w,
          child: Image.asset(
            AssetConts.drawBgNotification,
            fit: BoxFit.cover,
          ),
        ),
      ),
      Positioned(
        top: 5,
        left: 100,
        child: Image.asset(AssetConts.iconNotification),
      ),
      Positioned(
        top: 5,
        left: 80,
        child: Container(
          height: 32.w,
          width: 32.w,
          decoration: BoxDecoration(
            color: Colours.red,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Center(
            child: Text(
              'X',
              style: GoogleFonts.montserrat(
                  color: Colours.white, fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
    ],
  );
}
