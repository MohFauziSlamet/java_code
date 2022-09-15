import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoadingStatePromoView extends StatelessWidget {
  const LoadingStatePromoView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 158.h,
      child: ProfileShimmer(
        isRectBox: true,
        margin: EdgeInsets.symmetric(horizontal: 10.sp),
      ),
    );
  }
}
