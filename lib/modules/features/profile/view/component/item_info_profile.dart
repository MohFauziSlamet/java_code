import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:java_code/config/themes/colours.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class ItemInfoProfile extends StatelessWidget {
  ItemInfoProfile({
    Key? key,
    required this.nameInfo,
    required this.textInfo,
    this.onTap,
  }) : super(key: key);

  String nameInfo;
  String textInfo;
  void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 120.w,
          height: 21.h,
          child: Text(
            nameInfo,
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w600,
              fontSize: 16.sp,
              color: Colours.darkGrey,
            ),
          ),
        ),
        InkWell(
          onTap: onTap,
          child: Row(
            children: [
              SizedBox(
                width: 209.w,
                height: 21.h,
                child: Text(
                  textInfo,
                  textAlign: TextAlign.right,
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w400,
                    fontSize: 16.sp,
                    color: Colours.darkGrey,
                  ),
                ),
              ),
              SizedBox(
                width: 9.38.w,
              ),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colours.whiteGrey,
                size: 15,
              )
            ],
          ),
        )
      ],
    );
  }
}
