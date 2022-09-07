// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:java_code/modules/features/detail_menu/repository/detail_menu_repository.dart';
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
  DetailMenuRes? detailMenuResult;

  /// DETAIL MENU CONTROLLER
  Future<void> detailMenuRes({required int idMenu}) async {
    var data = await detailMenuRepository.detailMenu(idMenu: idMenu);

    detailMenuResult = data;
    print('Debug DetailMenuController');
    print('DETAIL MENU  : ${detailMenuResult?.data?.menu?.toJson()}');
    print('DETAIL TOPING  : ${detailMenuResult?.data?.topping}');
    print('DETAIL LEVEL  : ${detailMenuResult?.data?.level}');

    update();
  }

  @override
  void onInit() {
    detailMenuRes(idMenu: Get.arguments['id_menu']);
    super.onInit();
  }
}
