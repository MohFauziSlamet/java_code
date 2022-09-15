import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:java_code/constant/core/api_const.dart';
import 'package:java_code/modules/models/detail_promo_res/detail_promo_res.dart';
import 'package:java_code/shared/widgets/custom_snackbar.dart';
import 'package:java_code/utils/services/dio_service.dart';

class DetailPromoRepository {
  /// GET DETAIL PROMO
  Future<DetailPromoRes> getDetailPromo({required int idPromo}) async {
    try {
      log('Debug HomeRepository ln-14');
      log('DIO CALL');
      var result = await DioService.dioCall().get(
        '${ApiConst.getDetailPromo}$idPromo',
      );
      return DetailPromoRes.fromJson(result.data);
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        CustomSnackbar().snackBar(
          title: 'Terjadi Kesalahan',
          message: 'Connection Timeout',
        );
        log('Debug HomeRepository ln-28');
        log('[GET - ${ApiConst.getDetailPromo}] ERROR ${e.response?.statusCode} ==> ${e.response?.data}');

        return DetailPromoRes.fromJson(e.response!.data);
      } else {
        if (e.response == null) {
          CustomSnackbar().snackBar(
            title: 'Terjadi Kesalahan',
            message: 'Unknown Error',
          );
          log('Debug HomeRepository ln-39');
          log('[GET - ${ApiConst.getDetailPromo}] ERROR ${e.response?.statusCode} ==> ${e.response?.data}');

          return DetailPromoRes();
        } else {
          log('Debug HomeRepository ln-45');
          log('[GET - ${ApiConst.getDetailPromo}] ERROR ${e.response?.statusCode} ==> ${e.response?.data}');

          return DetailPromoRes();
        }
      }
    }
  }
}
