import 'package:flutter/material.dart';
import 'package:java_code/config/pages/app_pages.dart';
import 'package:java_code/config/routes/app_routes.dart';
import 'package:java_code/constant/commons/app_const.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// Import the generated file
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
          initialRoute: AppRoutes.login,
          getPages: AppPages.getPage(),
        );
      },
    );
  }
}
