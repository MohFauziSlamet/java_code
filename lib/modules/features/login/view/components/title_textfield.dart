import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/config/themes/colours.dart';

class TittleTextfield extends StatelessWidget {
  TittleTextfield({
    Key? key,
    required this.name,
  }) : super(key: key);

  String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 46.sp),
      child: Text(
        name,
        style: GoogleFonts.montserrat(
          color: Colours.darkBlack,
          fontWeight: FontWeight.w400,
          fontSize: 14.sp,
        ),
      ),
    );
  }
}
