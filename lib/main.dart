import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:java_code/config/pages/app_pages.dart';
import 'package:java_code/config/routes/app_routes.dart';
import 'package:java_code/constant/commons/app_const.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:java_code/constant/core/hive_const.dart';
import 'package:java_code/modules/models/user_data_res/akses.dart';
import 'package:java_code/modules/models/user_data_res/data_user.dart';
import 'package:java_code/modules/models/user_data_res/user.dart';
// Import the generated file
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Hive.initFlutter();

  ///Disable Rotation
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  /// Registering Hive Adapter
  Hive.registerAdapter(AksesAdapter());
  Hive.registerAdapter(DataUserAdapter());
  Hive.registerAdapter(UserAdapter());

  /// OPEN BOX
  Hive.openBox<Akses>(HiveConst.aksesHiveBox);
  Hive.openBox<DataUser>(HiveConst.dataUserTokenHiveBox);
  Hive.openBox<User>(HiveConst.userHiveBox);
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
