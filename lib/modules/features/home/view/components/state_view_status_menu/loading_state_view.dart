import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoadingStateView extends StatelessWidget {
  const LoadingStateView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ScreenUtil().screenHeight,
      child: ListView.builder(
        itemCount: 8,
        itemBuilder: (context, index) {
          return ProfileShimmer(
              isRectBox: true, margin: EdgeInsets.symmetric(horizontal: 10.sp));
        },
      ),
    );
  }
}
