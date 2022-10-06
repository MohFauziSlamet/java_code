import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:java_code/constant/core/api_const.dart';
import 'package:java_code/constant/core/hive_const.dart';
import 'package:java_code/modules/models/get_diskon_by_user_id_res/get_diskon_by_user_id_res.dart';
import 'package:java_code/modules/models/hive/order_hive_model.dart';
import 'package:java_code/modules/models/post_order_res/post_order_res.dart';
import 'package:java_code/modules/models/user_data_res/data_user.dart';
import 'package:java_code/shared/widgets/custom_snackbar.dart';
import 'package:java_code/utils/services/dio_service.dart';

class PesananRepository {
  /// POST ORDER MENU
  Future<PostOrderRes> postOrderMenu({required OrderHive dataOrderMenu}) async {
    try {
      log('Debug Pesanan Repository ln-18');
      log('DIO CALL');
      log('TOTAL USER ID : ${dataOrderMenu.idUser}');
      log('TOTAL ID VOUCHER : ${dataOrderMenu.idVoucher}');
      log('TOTAL POTONGAN : ${dataOrderMenu.potongan}');
      log('TOTAL BAYAR : ${dataOrderMenu.totalBayar}');
      log('PANJANG ORDER : ${dataOrderMenu.menu?.length ?? 0}');

      List<dynamic> menus = [];
      for (var menu in dataOrderMenu.menu!) {
        menus.add({
          'id_menu': menu.id_menu,
          'harga': menu.harga,
          'level': menu.level,
          'topping': menu.topping,
          'jumlah': menu.jumlah
        });
      }
      var result = await DioService.dioCall().post(
        ApiConst.postOrderMenu,
        data: {
          "order": {
            "id_user": dataOrderMenu.idUser,
            "id_voucher": dataOrderMenu.idVoucher,
            "potongan": dataOrderMenu.potongan,
            "total_bayar": dataOrderMenu.totalBayar,
          },
          "menu": menus,
        },
      );
      log('RES : ${result.data}');
      return PostOrderRes.fromJson(result.data);
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        CustomSnackbar().snackBar(
          title: 'Terjadi Kesalahan',
          message: 'Connection Timeout',
        );
        log('Debug Pesanan Repository ln-28');
        log('[POST - ${ApiConst.postOrderMenu}] ERROR ${e.response?.statusCode} ==> ${e.response?.data}');

        return PostOrderRes.fromJson(e.response!.data);
      } else {
        if (e.response == null) {
          CustomSnackbar().snackBar(
            title: 'Terjadi Kesalahan',
            message: 'Unknown Error',
          );
          log('Debug Pesanan Repository ln-41');
          log('[POST - ${ApiConst.postOrderMenu}] ERROR ${e.response?.statusCode} ==> ${e.response?.data}');

          return PostOrderRes();
        } else {
          log('Debug Pesanan Repository ln-46');
          log('[POST - ${ApiConst.postOrderMenu}] ERROR ${e.response?.statusCode} ==> ${e.response?.data}');

          return PostOrderRes();
        }
      }
    }
  }

  /// GET DISKON BY ID USER
  Future<GetDiskonByUserIdRes> getDiskonByIdUser() async {
    try {
      log('Debug Pesanan Repository ln-59');
      log('DIO CALL');
      int idUser = DataUserManager?.getAllNotes()
              .toMap()[HiveConst.dataUserTokenHiveKey]
              ?.user
              ?.idUser ??
          0;
      log('ID USER : $idUser');
      var result = await DioService.dioCall().get(
        '${ApiConst.getDiskonByIdUser}72',
      );
      log('MENJALANKAN DIO CALL GET DISKON ');
      return GetDiskonByUserIdRes.fromJson(result.data);
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        CustomSnackbar().snackBar(
          title: 'Terjadi Kesalahan',
          message: 'Connection Timeout',
        );
        log('Debug Pesanan Repository ln-78');
        log('[POST - ${ApiConst.getDiskonByIdUser}] ERROR ${e.response?.statusCode} ==> ${e.response?.data}');

        return GetDiskonByUserIdRes.fromJson(e.response!.data);
      } else {
        if (e.response == null) {
          CustomSnackbar().snackBar(
            title: 'Terjadi Kesalahan',
            message: 'Unknown Error',
          );
          log('Debug Pesanan Repository ln-86');
          log('[GET - ${ApiConst.getDiskonByIdUser}] ERROR ${e.response?.statusCode} ==> ${e.response?.data}');

          return GetDiskonByUserIdRes();
        } else {
          log('Debug Pesanan Repository ln-91');
          log('[GET - ${ApiConst.getDiskonByIdUser}] ERROR ${e.response?.statusCode} ==> ${e.response?.data}');

          return GetDiskonByUserIdRes();
        }
      }
    }
  }
}
