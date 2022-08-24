import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:java_code/config/routes/app_routes.dart';
import 'package:java_code/modules/features/home/view/ui/home_view.dart';
import 'package:java_code/modules/features/loading_lokasi/view/ui/loading_lokasi_view.dart';
import 'package:java_code/modules/features/login/view/ui/login_view.dart';

class AppPages {
  AppPages._();

  static List<GetPage> getPage() {
    return [
      GetPage(
        name: AppRoutes.login,
        page: () => const LoginView(),
      ),
      GetPage(
        name: AppRoutes.loadingLokasi,
        page: () => const LoadingLokasi(),
      ),
      GetPage(
        name: AppRoutes.home,
        page: () => HomeView(),
      ),
    ];
  }
}
