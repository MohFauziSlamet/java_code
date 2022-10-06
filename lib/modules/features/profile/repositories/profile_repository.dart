import 'dart:developer';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:java_code/constant/core/api_const.dart';
import 'package:java_code/constant/core/hive_const.dart';
import 'package:java_code/modules/models/get_user_detail/get_user_detail.dart';
import 'package:java_code/modules/models/user_data_res/data_user.dart';
import 'package:java_code/shared/widgets/custom_snackbar.dart';

import 'package:java_code/utils/services/dio_service.dart';

class ProfileRepository {
  ///
  Future<GetUserDetail> updateProfile({required String key, required String value}) async {
    try {
      int idUser = DataUserManager.getAllNotes().toMap()[HiveConst.dataUserTokenHiveKey]?.user?.idUser ?? 0;
      var result = await DioService.dioCall().post(
        '${ApiConst.postUpdateProfile}$idUser',
        data: jsonEncode(<String, dynamic>{key: value}),
      );

      return GetUserDetail.fromJson(result.data);
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        CustomSnackbar().snackBar(
          title: 'Terjadi Kesalahan',
          message: 'Connection Timeout',
        );
        log('Debug Pesanan Tracking Repository ln-24');
        log('[POST - ${ApiConst.postUpdateProfile}] ERROR ${e.response?.statusCode} ==> ${e.response?.data}');

        return GetUserDetail.fromJson(e.response!.data);
      } else {
        if (e.response == null) {
          CustomSnackbar().snackBar(
            title: 'Terjadi Kesalahan',
            message: 'Unknown Error',
          );
          log('Debug Pesanan Tracking Repository ln-34');
          log('[POST - ${ApiConst.postUpdateProfile}] ERROR ${e.response?.statusCode} ==> ${e.response?.data}');

          return GetUserDetail();
        } else {
          log('Debug Pesanan Tracking Repository ln-39');
          log('[POST - ${ApiConst.postUpdateProfile}] ERROR ${e.response?.statusCode} ==> ${e.response?.data}');

          return GetUserDetail();
        }
      }
    }
  }

  ///
  Future<GetUserDetail> updateUserDetailByKey({required String key, required String value}) async {
    try {
      int idUser = DataUserManager.getAllNotes().toMap()[HiveConst.dataUserTokenHiveKey]?.user?.idUser ?? 0;
      var result = await DioService.dioCall().post(
        '${ApiConst.postUpdateUser}$idUser',
        data: jsonEncode(<String, dynamic>{key: value}),
      );

      return GetUserDetail.fromJson(result.data);
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        CustomSnackbar().snackBar(
          title: 'Terjadi Kesalahan',
          message: 'Connection Timeout',
        );
        log('Debug Pesanan Tracking Repository ln-24');
        log('[POST - ${ApiConst.postUpdateProfile}] ERROR ${e.response?.statusCode} ==> ${e.response?.data}');

        return GetUserDetail.fromJson(e.response!.data);
      } else {
        if (e.response == null) {
          CustomSnackbar().snackBar(
            title: 'Terjadi Kesalahan',
            message: 'Unknown Error',
          );
          log('Debug Pesanan Tracking Repository ln-34');
          log('[POST - ${ApiConst.postUpdateProfile}] ERROR ${e.response?.statusCode} ==> ${e.response?.data}');

          return GetUserDetail();
        } else {
          log('Debug Pesanan Tracking Repository ln-39');
          log('[POST - ${ApiConst.postUpdateProfile}] ERROR ${e.response?.statusCode} ==> ${e.response?.data}');

          return GetUserDetail();
        }
      }
    }
  }

  //  Future<GetUserDetail?> getUserDetail() async {
  //   Map<String, String> headers = {'token': super.box.values.first.token ?? ""};
  //   final response = await get(
  //       super.baseUrlConst.baseUrl +
  //           super.endPointConst.getUserDetail +
  //           super.box.values.first.idUser.toString(),
  //       headers: headers);
  //   // print(response.body);
  //   if (response.isOk) {
  //     if (response.body['status_code'] == 200) {
  //       GetUserDetail userDetailResponse =
  //           GetUserDetail.fromJson(response.body);
  //       return userDetailResponse;
  //     } else {
  //       return null;
  //     }
  //   } else {
  //     return null;
  //   }
  // }

  Future<GetUserDetail> getUserDetail() async {
    try {
      int idUser = DataUserManager.getAllNotes().toMap()[HiveConst.dataUserTokenHiveKey]?.user?.idUser ?? 0;
      var result = await DioService.dioCall().get(
        '${ApiConst.getUserDetail}$idUser',
      );

      return GetUserDetail.fromJson(result.data);
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        CustomSnackbar().snackBar(
          title: 'Terjadi Kesalahan',
          message: 'Connection Timeout',
        );
        log('Debug Pesanan Tracking Repository ln-24');
        log('[GET - ${ApiConst.getUserDetail}] ERROR ${e.response?.statusCode} ==> ${e.response?.data}');

        return GetUserDetail.fromJson(e.response!.data);
      } else {
        if (e.response == null) {
          CustomSnackbar().snackBar(
            title: 'Terjadi Kesalahan',
            message: 'Unknown Error',
          );
          log('Debug Pesanan Tracking Repository ln-34');
          log('[GET - ${ApiConst.getUserDetail}] ERROR ${e.response?.statusCode} ==> ${e.response?.data}');

          return GetUserDetail();
        } else {
          log('Debug Pesanan Tracking Repository ln-39');
          log('[GET - ${ApiConst.getUserDetail}] ERROR ${e.response?.statusCode} ==> ${e.response?.data}');

          return GetUserDetail();
        }
      }
    }
  }
}
