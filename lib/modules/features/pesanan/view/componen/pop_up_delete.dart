import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:java_code/config/themes/colours.dart';
import 'package:java_code/shared/widgets/icon_notification.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class DialogNotifDeleteCountOrderIfOne extends StatelessWidget {
  DialogNotifDeleteCountOrderIfOne({Key? key, this.onPressedOke}) : super(key: key);

  void Function()? onPressedOke;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 338.w,
      height: 418.h,
      decoration: BoxDecoration(
        color: Colours.white,
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          iconNotifcation(),
          SizedBox(height: 30.h),
          Text(
            'delete_item'.tr,
            style: GoogleFonts.montserrat(
              fontSize: 20.sp,
              color: Colours.darkGrey,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 15.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.sp),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  text: 'you_can_delete'.tr,
                  style: GoogleFonts.montserrat(
                    fontSize: 16.sp,
                    color: Colours.darkGrey.withOpacity(0.5),
                    fontWeight: FontWeight.w300,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: ' order'.tr,
                      style: GoogleFonts.montserrat(
                        fontSize: 16.sp,
                        color: Colours.grey,
                        fontWeight: FontWeight.w700,
                      ),
                    )
                  ]),
            ),
          ),
          SizedBox(height: 15.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 40.h,
                  width: 100.w,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.r),
                        side: const BorderSide(
                          color: Colours.green2,
                          width: 1,
                        ),
                      ),
                    ),
                    onPressed: onPressedOke,
                    child: const Text('Oke'),
                  ),
                ),
                SizedBox(
                  height: 40.h,
                  width: 100.w,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colours.green2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.r),
                        side: const BorderSide(
                          color: Colours.white,
                          width: 1,
                        ),
                      ),
                    ),
                    onPressed: () {
                      Get.back();
                    },
                    child: Text('back'.tr),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
