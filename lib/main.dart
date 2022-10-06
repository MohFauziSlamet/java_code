import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:java_code/config/localizations/locale_string.dart';
import 'package:java_code/config/pages/app_pages.dart';
import 'package:java_code/config/routes/app_routes.dart';
import 'package:java_code/constant/commons/app_const.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:java_code/constant/core/hive_const.dart';
import 'package:java_code/modules/features/splash_screen/controller/splash_controller.dart';
import 'package:java_code/modules/features/splash_screen/view/ui/splash_view.dart';
import 'package:java_code/modules/global_controllers/check_connection_controller.dart';
import 'package:java_code/modules/models/hive/menu_hive_model.dart';
import 'package:java_code/modules/models/hive/order_hive_model.dart';
import 'package:java_code/modules/models/hive/topping_hive_model.dart';
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
  Hive.registerAdapter(MenuHiveAdapter());
  Hive.registerAdapter(OrderHiveAdapter());
  Hive.registerAdapter(ToppingHiveAdapter());

  /// OPEN BOX
  await Hive.openBox<Akses>(HiveConst.aksesHiveBox);
  await Hive.openBox<DataUser>(HiveConst.dataUserTokenHiveBox);
  await Hive.openBox<User>(HiveConst.userHiveBox);
  await Hive.openBox<OrderHive>(HiveConst.orderHiveBox);
  await Hive.openBox<MenuHive>(HiveConst.menuHiveBox);
  await Hive.openBox<ToppingHive>(HiveConst.topingHiveBox);
  await Hive.openBox(HiveConst.languageHiveBox);
  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  var languageBox = Hive.box(HiveConst.languageHiveBox);
  String? selectedLanguage;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.put(SplashScreenController(), permanent: true);
    Get.put(ConnectionManagerController(), permanent: true);
    selectedLanguage = languageBox.get("country_id");

    return ScreenUtilInit(
      designSize: AppConst.designSize,
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return FutureBuilder(
            future: Future.delayed(const Duration(seconds: 3)),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Obx(
                  () => GetMaterialApp(
                    debugShowCheckedModeBanner: false,
                    locale: selectedLanguage != null ? Locale(selectedLanguage!) : Get.deviceLocale,
                    translations: LocaleString(),
                    fallbackLocale: const Locale('en', 'US'),
                    title: AppConst.appName,
                    initialRoute: SplashScreenController.to.isAuth.isTrue ? AppRoutes.dashboardView : AppRoutes.login,
                    getPages: AppPages.getPage(),
                  ),
                );
              }
              return FutureBuilder(
                future: SplashScreenController.to.firstInitialized(),
                builder: (context, snapshot) {
                  return const SplashScreen();
                },
              );
            });
      },
    );
  }
}
// 1.250.000
// bni 6060605253 an kemahasiswaan asis