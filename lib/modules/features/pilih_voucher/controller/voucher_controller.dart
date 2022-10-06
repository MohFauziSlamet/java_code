import 'dart:developer';

import 'package:get/get.dart';
import 'package:java_code/modules/features/pilih_voucher/repositories/voucher_repository.dart';
import 'package:java_code/modules/models/get_voucher_by_id_user_res/get_voucher_by_id_user_res.dart';

class VoucherController extends GetxController {
  static VoucherController get to => Get.find();
  VoucherRepository repository = VoucherRepository();

  /// GET VOUCHER BY ID USER
  RxString loadingVoucher = 'loading'.obs;
  GetVoucherByIdUserRes resultVoucher = GetVoucherByIdUserRes();
  Future<void> getVoucherByIdUser() async {
    GetVoucherByIdUserRes res = await repository.getVoucherByIdUser();

    if (res.statusCode == 200) {
      loadingVoucher.value = 'sukses';
      log('ISI VALUE GET DISKON : ${res.toJson()}');
      resultVoucher = res;
    } else if (res.statusCode == 204) {
      loadingVoucher.value = 'empty';
      log('DATA EMPTY');
    } else {
      loadingVoucher.value = 'error';
      log('DATA ERROR');
    }
  }

  @override
  void onInit() {
    getVoucherByIdUser();
    super.onInit();
  }
}
