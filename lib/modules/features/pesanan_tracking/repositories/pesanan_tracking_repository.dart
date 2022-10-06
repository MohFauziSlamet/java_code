import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:java_code/constant/core/api_const.dart';
import 'package:java_code/modules/models/get_detail_order_res_by_id_struk/get_detail_order_res_by_id_struk.dart';
import 'package:java_code/shared/widgets/custom_snackbar.dart';
import 'package:java_code/utils/services/dio_service.dart';

class PesananTrackingRepository {
  /// GET DETAIL ORDER BY ID STRUK
  Future<GetDetailOrderResByIdStruk> getDetailOrderByIdStruk(
      {required int idStruk}) async {
    try {
      var result = await DioService.dioCall().get(
        '${ApiConst.getDetailOrderByIdStruk}$idStruk',
      );

      return GetDetailOrderResByIdStruk.fromJson(result.data);
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        CustomSnackbar().snackBar(
          title: 'Terjadi Kesalahan',
          message: 'Connection Timeout',
        );
        log('Debug Pesanan Tracking Repository ln-24');
        log('[GET - ${ApiConst.getDetailOrderByIdStruk}] ERROR ${e.response?.statusCode} ==> ${e.response?.data}');

        return GetDetailOrderResByIdStruk.fromJson(e.response!.data);
      } else {
        if (e.response == null) {
          CustomSnackbar().snackBar(
            title: 'Terjadi Kesalahan',
            message: 'Unknown Error',
          );
          log('Debug Pesanan Tracking Repository ln-34');
          log('[GET - ${ApiConst.getDetailOrderByIdStruk}] ERROR ${e.response?.statusCode} ==> ${e.response?.data}');

          return GetDetailOrderResByIdStruk();
        } else {
          log('Debug Pesanan Tracking Repository ln-39');
          log('[GET - ${ApiConst.getDetailOrderByIdStruk}] ERROR ${e.response?.statusCode} ==> ${e.response?.data}');

          return GetDetailOrderResByIdStruk();
        }
      }
    }
  }
}
