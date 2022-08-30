import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '/config/themes/colours.dart';
import '/constant/core/assets_const.dart';

class CheckoutEmptyState extends StatelessWidget {
  const CheckoutEmptyState({
    Key? key,
    required this.current,
    required this.textEmpty,
  }) : super(key: key);

  final RxInt current;
  final List<String> textEmpty;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 43.sp, vertical: 24.sp),
        width: ScreenUtil().screenWidth,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AssetConts.backgroundLoadingLokasi),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 206.w,
              width: 206.w,
              child: Image.asset(
                AssetConts.iconEmpty,
              ),
            ),
            SizedBox(height: 25.75.h),
            SizedBox(
              width: 326.w,
              height: 170.h,
              child: (current.value != 1)
                  ? Text(
                      textEmpty[current.value],
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w400,
                        fontSize: 22.sp,
                        color: Colours.darkBlack,
                      ),
                    )
                  : Column(
                      children: [
                        Text(
                          "Mulai Buat Pesanan",
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w400,
                            fontSize: 22.sp,
                            color: Colours.darkBlack,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          textEmpty[current.value],
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w400,
                            fontSize: 22.sp,
                            color: Colours.darkBlack,
                          ),
                        )
                      ],
                    ),
            )
          ],
        ),
      ),
    );
  }
}
