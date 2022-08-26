import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:java_code/config/routes/app_routes.dart';
import 'package:java_code/modules/features/detail_menu/view/ui/detail_menu_view.dart';
import 'package:java_code/modules/features/detail_promo/view/ui/detail_promo_view.dart';
import 'package:java_code/modules/features/home/view/ui/home_view.dart';
import 'package:java_code/modules/features/loading_lokasi/view/ui/loading_lokasi_view.dart';
import 'package:java_code/modules/features/login/view/ui/login_view.dart';
import 'package:java_code/modules/features/pesanan/view/ui/pesanan_view.dart';

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
      GetPage(
        name: AppRoutes.detailPromo,
        page: () => DetailPromoView(),
      ),
      GetPage(
        name: AppRoutes.detailMenu,
        page: () => DetailMenuView(),
      ),
      GetPage(
        name: AppRoutes.pesanan,
        page: () => PesananView(),
      ),
    ];
  }
}
