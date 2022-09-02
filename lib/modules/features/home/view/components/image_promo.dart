import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:java_code/config/routes/app_routes.dart';

// ignore: must_be_immutable
class ImagePromo extends StatelessWidget {
  ImagePromo({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);

  String imageUrl;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(AppRoutes.detailPromo);
      },
      child: Container(
        height: 161.sp,
        width: 323.sp,
        margin: const EdgeInsets.only(left: 25),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.sp),
          image: DecorationImage(
            image: AssetImage(imageUrl),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
    // return Image.asset(imageUrl);
  }
}
