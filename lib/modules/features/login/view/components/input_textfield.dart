import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/constant/core/assets_const.dart';

class InputTextField extends StatelessWidget {
  InputTextField({
    Key? key,
    required this.hintText,
    required this.isPassword,
  }) : super(key: key);

  String hintText;
  bool isPassword = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 46.sp),
      child: TextField(
        decoration: InputDecoration(
          hintText: hintText,
          border: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xff009AAD),
            ),
          ),
          suffixIcon: isPassword
              ? SizedBox(
                  height: 17.h, child: Image.asset(AssetConts.iconEyeHidden))
              : const SizedBox(),
        ),
      ),
    );
  }
}
