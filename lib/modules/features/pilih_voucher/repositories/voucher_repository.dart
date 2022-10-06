import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:java_code/constant/core/api_const.dart';
import 'package:java_code/constant/core/hive_const.dart';
import 'package:java_code/modules/models/get_voucher_by_id_user_res/get_voucher_by_id_user_res.dart';
import 'package:java_code/modules/models/user_data_res/data_user.dart';
import 'package:java_code/shared/widgets/custom_snackbar.dart';
import 'package:java_code/utils/services/dio_service.dart';

class VoucherRepository {
  /// GET VOUCHER BY ID USER
  Future<GetVoucherByIdUserRes> getVoucherByIdUser() async {
    try {
      log('Debug Pesanan Repository ln-105');
      log('DIO CALL');
      int idUser = DataUserManager?.getAllNotes()
              .toMap()[HiveConst.dataUserTokenHiveKey]
              ?.user
              ?.idUser ??
          0;
      log('ID USER : $idUser');
      var result = await DioService.dioCall().get(
        '${ApiConst.getVoucheByIdUser}$idUser',
      );
      log('MENJALANKAN DIO CALL GET DISKON ');
      return GetVoucherByIdUserRes.fromJson(result.data);
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        CustomSnackbar().snackBar(
          title: 'Terjadi Kesalahan',
          message: 'Connection Timeout',
        );
        log('Debug Pesanan Repository ln-124');
        log('[POST - ${ApiConst.getVoucheByIdUser}] ERROR ${e.response?.statusCode} ==> ${e.response?.data}');

        return GetVoucherByIdUserRes.fromJson(e.response!.data);
      } else {
        if (e.response == null) {
          CustomSnackbar().snackBar(
            title: 'Terjadi Kesalahan',
            message: 'Unknown Error',
          );
          log('Debug Pesanan Repository ln-134');
          log('[GET - ${ApiConst.getVoucheByIdUser}] ERROR ${e.response?.statusCode} ==> ${e.response?.data}');

          return GetVoucherByIdUserRes();
        } else {
          log('Debug Pesanan Repository ln-139');
          log('[GET - ${ApiConst.getVoucheByIdUser}] ERROR ${e.response?.statusCode} ==> ${e.response?.data}');

          return GetVoucherByIdUserRes();
        }
      }
    }
  }
}
