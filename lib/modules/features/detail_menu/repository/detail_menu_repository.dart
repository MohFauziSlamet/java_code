// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:get/get.dart';

import 'package:java_code/constant/core/api_const.dart';
import 'package:java_code/modules/models/detail_menu_res/detail_menu_res.dart';
import 'package:java_code/shared/widgets/custom_snackbar.dart';
import 'package:java_code/utils/services/dio_service.dart';

class DetailMenuRepository extends GetxController {
  /// DETAIL MENU
  Future<DetailMenuRes> detailMenu({required int idMenu}) async {
    try {
      var result = await DioService.dioCall().get(
        '${ApiConst.detailMenuURL}$idMenu',
      );

      var resultMenu = DetailMenuRes.fromJson(result.data);
      // print('DEBUG HOME REPOSITORY');
      // print('data : ${result.data}');
      // print('data : ${resultMenu.data?[0]}');
      return resultMenu;
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        CustomSnackbar().snackBar(
          title: 'Terjadi Kesalahan',
          message: "Connection Timeout",
        );

        print(
            '[POST - ${ApiConst.detailMenuURL}$idMenu] ERROR ${e.response!.statusCode} ==> ${e.response!.data}');

        return DetailMenuRes.fromJson(e.response!.data);
      } else {
        if (e.response == null) {
          CustomSnackbar().snackBar(
            title: 'Terjadi Kesalahan',
            message: "Unknown Error",
          );

          print(
              '[POST - ${ApiConst.detailMenuURL}$idMenu] ERROR ${e.response!.statusCode} ==> ${e.response!.data}');

          return DetailMenuRes.fromJson(e.response!.data);
        } else {
          print(
              '[POST - ${ApiConst.detailMenuURL}$idMenu] ERROR ${e.response!.statusCode} ==> ${e.response!.data}');

          return DetailMenuRes.fromJson(e.response!.data);
        }
      }
    }
  }
}
