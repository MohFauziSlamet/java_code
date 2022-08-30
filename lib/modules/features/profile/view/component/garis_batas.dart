import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/config/themes/colours.dart';

class GarisBatas extends StatelessWidget {
  const GarisBatas({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 12.h),
        width: 350.w,
        height: 1.h,
        decoration: BoxDecoration(color: Colours.darkGrey.withOpacity(0.25)),
      ),
    );
  }
}
