import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:java_code/config/themes/colours.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class ButtonCard extends StatelessWidget {
  ButtonCard({
    Key? key,
    required this.nama,
    required this.stringIcon,
    required this.heightIcon,
    required this.widthIcon,
    required this.child,
  }) : super(key: key);

  String nama;
  String stringIcon;
  double widthIcon;
  double heightIcon;
  Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 381.w,
          height: 1.h,
          decoration: BoxDecoration(
            color: Colours.darkGrey.withOpacity(0.25),
          ),
        ),
        SizedBox(height: 10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                SizedBox(
                  height: heightIcon,
                  width: widthIcon,
                  child: Image.asset(
                    stringIcon,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 10.w),
                Text(
                  nama,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                    color: Colours.darkGrey,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                child,
                const SizedBox(width: 23),
              ],
            ),
          ],
        ),
        SizedBox(height: 14.h),
      ],
    );
  }
}
