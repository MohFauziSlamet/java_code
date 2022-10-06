import 'dart:developer';
import 'package:get/get.dart';
import 'package:java_code/modules/features/pesanan_tracking/repositories/pesanan_tracking_repository.dart';
import 'package:java_code/modules/models/get_detail_order_res_by_id_struk/get_detail_order_res_by_id_struk.dart';

class PesananTrackingController extends GetxController {
  static PesananTrackingController get to => Get.find();
  PesananTrackingRepository pesananTrackingRepo = PesananTrackingRepository();
  GetDetailOrderResByIdStruk orderDetailResponse = GetDetailOrderResByIdStruk();
  RxString loading = 'loading'.obs;

  Future<void> getDetailOrderByIdStruk({required int idOrder}) async {
    log('ID ORDER : $idOrder');
    GetDetailOrderResByIdStruk res = await pesananTrackingRepo.getDetailOrderByIdStruk(idStruk: idOrder);

    if (res.statusCode == 200) {
      loading.value = 'sukses';
      log('ISI VALUE GET Detail Order : ${res.toJson()}');
      orderDetailResponse = res;
      log('ISI DATA : ${orderDetailResponse.data!.detail![0].nama}');
      update();
    } else if (res.statusCode == 204) {
      loading.value = 'empty';
      log('DATA EMPTY');
      update();
    } else {
      loading.value = 'error';
      log('DATA ERROR');
      update();
    }
  }

  @override
  void onInit() {
    log('MENJALANKAN ON INIT PESANAN TRACKING CONTROLLER');
    log("STRUK ID ORDER DARI ARGUMEN : ${Get.arguments['id_order']}");
    getDetailOrderByIdStruk(idOrder: Get.arguments['id_order']);
    update();
    super.onInit();
  }
}
