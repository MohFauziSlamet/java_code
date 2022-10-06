import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:java_code/constant/core/api_const.dart';
import 'package:java_code/constant/core/hive_const.dart';
import 'package:java_code/modules/models/get_order_by_user_id/get_order_by_user_id.dart';
import 'package:java_code/modules/models/history_order_by_user_id/history_order_by_user_id.dart';
import 'package:java_code/modules/models/history_order_by_user_id/list_data_order.dart';
import 'package:java_code/modules/models/post_order_res/post_order_res.dart';
import 'package:java_code/modules/models/user_data_res/data_user.dart';
import 'package:java_code/shared/widgets/custom_snackbar.dart';
import 'package:java_code/utils/services/dio_service.dart';

class CheckoutRepository {
  /// GET DETAIL ORDER BY ID STRUK
  Future<GetOrderByUserId> getOrderByIdUser() async {
    try {
      int idUser = DataUserManager?.getAllNotes().toMap()[HiveConst.dataUserTokenHiveKey]?.user?.idUser ?? 0;
      log('ID USER => CHECKOUT REPO : $idUser');
      var result = await DioService.dioCall().get(
        '${ApiConst.getOrderByIdUser}$idUser',
      );

      return GetOrderByUserId.fromJson(result.data);
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        CustomSnackbar().snackBar(
          title: 'Terjadi Kesalahan',
          message: 'Connection Timeout',
        );
        log('Debug Checkout Repository ln-29');
        log('[GET - ${ApiConst.getOrderByIdUser}] ERROR ${e.response?.statusCode} ==> ${e.response?.data}');

        return GetOrderByUserId.fromJson(e.response!.data);
      } else {
        if (e.response == null) {
          CustomSnackbar().snackBar(
            title: 'Terjadi Kesalahan',
            message: 'Unknown Error',
          );
          log('Debug Checkout Repository ln-39');
          log('[GET - ${ApiConst.getOrderByIdUser}] ERROR ${e.response?.statusCode} ==> ${e.response?.data}');

          return GetOrderByUserId();
        } else {
          log('Debug Checkout Repository ln-39');
          log('[GET - ${ApiConst.getOrderByIdUser}] ERROR ${e.response?.statusCode} ==> ${e.response?.data}');

          return GetOrderByUserId();
        }
      }
    }
  }

  Future<HistoryOrderByUserId> getHistoryOrder() async {
    try {
      // int idUser = DataUserManager?.getAllNotes().toMap()[HiveConst.dataUserTokenHiveKey]?.user?.idUser ?? 0;
      log('ID USER => CHECKOUT REPO : 98');

      var result = await DioService.dioCall().post(
        '${ApiConst.postOrderByIdUser}98',
      );
      log("HISTORY ORDER : ${result.data}");
      return HistoryOrderByUserId.fromJson(result.data);
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        CustomSnackbar().snackBar(
          title: 'Terjadi Kesalahan',
          message: 'Connection Timeout',
        );
        log('Debug Checkout Repository ln-29');
        log('[POST - ${ApiConst.postOrderByIdUser}] ERROR ${e.response?.statusCode} ==> ${e.response?.data}');

        return HistoryOrderByUserId.fromJson(e.response!.data);
      } else {
        if (e.response == null) {
          CustomSnackbar().snackBar(
            title: 'Terjadi Kesalahan',
            message: 'Unknown Error',
          );
          log('Debug Checkout Repository ln-39');
          log('[POST - ${ApiConst.postOrderByIdUser}] ERROR ${e.response?.statusCode} ==> ${e.response?.data}');

          return HistoryOrderByUserId();
        } else {
          log('Debug Checkout Repository ln-39');
          log('[POST - ${ApiConst.postOrderByIdUser}] ERROR ${e.response?.statusCode} ==> ${e.response?.data}');

          return HistoryOrderByUserId();
        }
      }
    }
  }

  /// RE ORDER
  Future<PostOrderRes> reOrderReques({required ListDataOrder dataOrderMenu}) async {
    try {
      log('Debug Pesanan Repository ln-18');
      log('DIO CALL');
      int idUser = DataUserManager?.getAllNotes().toMap()[HiveConst.dataUserTokenHiveKey]?.user?.idUser ?? 0;
      log('ID USER CHECKOUT: $idUser');

      List<dynamic> menus = [];
      for (var menu in dataOrderMenu.menu!) {
        menus.add({'id_menu': menu.idMenu, 'harga': menu.harga, 'level': 0, 'topping': menu.topping, 'jumlah': menu.jumlah});
      }
      var result = await DioService.dioCall().post(
        ApiConst.postOrderMenu,
        data: {
          "order": {
            "id_user": idUser,
            "id_voucher": 0,
            "potongan": 0,
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
}
