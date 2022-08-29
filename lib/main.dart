import 'package:flutter/material.dart';
import 'package:java_code/config/pages/app_pages.dart';
import 'package:java_code/config/routes/app_routes.dart';
import 'package:java_code/constant/commons/app_const.dart';
import 'package:java_code/modules/features/login/view/ui/login_view.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: AppConst.designSize,
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: AppConst.appName,
          initialRoute: AppRoutes.checkoutView,
          getPages: AppPages.getPage(),
        );
      },
    );
  }
}
