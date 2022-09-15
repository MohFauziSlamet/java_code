import 'dart:developer';

import 'package:get/get.dart';

import 'package:java_code/modules/features/detail_promo/repositories/detail_promo_repository.dart';
import 'package:java_code/modules/models/detail_promo_res/detail_promo_res.dart';

class DetailPromoController extends GetxController {
  DetailPromoRepository detailPromoRepository = DetailPromoRepository();

  RxString loading = 'loading'.obs;

  static DetailPromoController get to => Get.find();

  /// DATA DETAIL MENU
  DetailPromoRes detailPromoResult = DetailPromoRes();

  /// DETAIL MENU CONTROLLER
  Future<void> detailPromoRes({required int idPromo}) async {
    var data = await detailPromoRepository.getDetailPromo(idPromo: idPromo);
    if (data.data != null) {
      loading.value = 'sukses';
      detailPromoResult = data;
      log('Debug DetailPromoController');
      log('DETAIL PROMO  : ${detailPromoResult.data?.toJson()}');

      update();
    } else {
      loading.value = 'empty';
    }
  }

  @override
  void onInit() {
    log('onInit : Debug DetailPromoController');
    log('ARGUMEN DARI DISKON/VOUCHER ${Get.arguments}');
    detailPromoRes(idPromo: Get.arguments);
    super.onInit();
  }
}
