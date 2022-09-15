import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:java_code/config/themes/colours.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingStateDetailPromoView extends StatelessWidget {
  const LoadingStateDetailPromoView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ScreenUtil().screenHeight,
      child: Center(
        child: LoadingAnimationWidget.prograssiveDots(
          color: Colours.green2,
          size: 100.sp,
        ),
      ),
    );
  }
}
