import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:java_code/config/themes/colours.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget customTextButton(
    {required String nama, required void Function() ontap}) {
  return Material(
    color: Colours.white,
    child: InkWell(
      onTap: ontap,
      splashColor: Colours.grey.withOpacity(0.5),
      child: Row(
        children: [
          Container(
            color: Colours.white,
            width: 182.w,
            height: 21,
            child: Text(
              nama,
              textAlign: TextAlign.end,
              maxLines: 1,
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w400,
                fontSize: 18.sp,
                color: Colours.darkGrey,
              ),
            ),
          ),
          const SizedBox(
            width: 13.38,
          ),
          const Icon(Icons.arrow_forward_ios)
        ],
      ),
    ),
  );
}
