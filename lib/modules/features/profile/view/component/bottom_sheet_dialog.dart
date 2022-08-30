import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:java_code/config/themes/colours.dart';
import 'package:java_code/constant/core/assets_const.dart';

class BottomSheetDialog extends StatelessWidget {
  BottomSheetDialog({
    Key? key,
    required this.namaBottomSheet,
    required this.onTap,
    this.keyboardType,
    this.widget,
  }) : super(key: key);

  String namaBottomSheet;
  TextInputType? keyboardType;
  Widget? widget;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().screenWidth,
      height: 200.h,
      decoration: BoxDecoration(
        color: Colours.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.r),
          topRight: Radius.circular(30.r),
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: 18.h),
          // GARIS STRIP
          Container(
            height: 4.h,
            width: 104.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Color(0xffc4c4c4).withOpacity(0.5),
            ),
          ),
          SizedBox(height: 13.h),
          // GANTI BAHASA DAN LOGO BENDERA
          Expanded(
            child: Container(
              width: ScreenUtil().screenWidth,
              margin: EdgeInsets.symmetric(
                horizontal: 17.sp,
              ),
              child: SizedBox(
                height: 165,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // GANTI NAMA
                    SizedBox(
                      height: 20.h,
                      width: 150.w,
                      child: Text(
                        namaBottomSheet,
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: Colours.darkGrey,
                        ),
                      ),
                    ),
                    SizedBox(height: 13.h),
                    // INPUT NAMA
                    Row(
                      children: [
                        SizedBox(
                          width: widget != null ? 320.w : 349.w,
                          child: TextField(
                            autocorrect: false,
                            textInputAction: TextInputAction.done,
                            keyboardType: keyboardType,
                            maxLength: 100,
                            decoration: const InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colours.green2),
                              ),
                            ),
                            // onEditingComplete: () {},
                          ),
                        ),
                        SizedBox(width: 9.w),
                        SizedBox(
                          child: widget,
                        ),
                        SizedBox(width: 9.w),
                        InkWell(
                          onTap: onTap,
                          child: Container(
                            width: 24.w,
                            height: 24.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              color: Colours.green2,
                              image: const DecorationImage(
                                image: AssetImage(AssetConts.iconCeklis),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
