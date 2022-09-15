// ignore_for_file: avoid_print

import 'dart:developer';

import 'package:get/get.dart';
import 'package:java_code/config/routes/app_routes.dart';
import 'package:java_code/modules/features/checkout/view/ui/checkout_view.dart';
import 'package:java_code/modules/features/detail_menu/repository/detail_menu_repository.dart';
import 'package:java_code/modules/features/home/controllers/home_controller.dart';
import 'package:java_code/modules/models/all_menu_res/data_menu.dart';
import 'package:java_code/modules/models/detail_menu_res/detail_menu_res.dart';

class DetailMenuController extends GetxController {
  static DetailMenuController get to => Get.find();

  /// UNTUK DINAMAMIS CHOISE PADA LEVEL MENU
  RxInt listIndexLevel = 0.obs;
  RxString keteranganLevel = '1'.obs;

  /// UNTUK DINAMAMIS CHOISE PADA TOPING MENU
  RxInt listIndexToping = 0.obs;
  RxString keteranganToping = 'Anda Belum Memilih'.obs;

  DetailMenuRepository detailMenuRepository = DetailMenuRepository();

  /// DATA DETAIL MENU
  DetailMenuRes detailMenuResult = DetailMenuRes();

  /// DETAIL MENU CONTROLLER
  Future<void> detailMenuRes({required int idMenu}) async {
    var data = await detailMenuRepository.detailMenu(idMenu: idMenu);

    detailMenuResult = data;
    log('Debug DetailMenuController');
    log('DETAIL MENU  : ${detailMenuResult.data?.menu?.toJson()}');
    log('DETAIL TOPING  : ${detailMenuResult.data?.topping}');
    log('DETAIL LEVEL  : ${detailMenuResult.data?.level}');

    update();
  }

  @override
  void onInit() {
    log('ON INIT DETAIL MENU CONTROLLER');
    log("DETAIL MENU  : ${Get.arguments['id_menu']}");
    detailMenuRes(idMenu: Get.arguments['id_menu']);
    super.onInit();
  }
}
