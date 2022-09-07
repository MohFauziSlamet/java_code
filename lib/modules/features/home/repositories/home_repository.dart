// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:java_code/constant/core/api_const.dart';
import 'package:java_code/modules/models/all_menu_res/all_menu_res.dart';
import 'package:java_code/modules/models/kategori_menu_res/kategori_menu_res.dart';
import 'package:java_code/shared/widgets/custom_snackbar.dart';
import 'package:java_code/utils/services/dio_service.dart';

class HomeRepository {
  /// GET ALL MENU
  Future<AllMenuRes> getAllMenu() async {
    try {
      print('Debug HomeRepository ln-14');
      print('DIO CALL');
      var result = await DioService.dioCall().get(
        ApiConst.getAllMenuURL,
      );

      var resultMenu = AllMenuRes.fromJson(result.data);
      print('DEBUG HOME REPOSITORY');
      print('data : ${result.data}');
      print('data : ${resultMenu.data?[0]}');
      return resultMenu;
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        CustomSnackbar().snackBar(
          title: 'Terjadi Kesalahan',
          message: 'Connection Timeout',
        );
        print('Debug HomeRepository ln-29');
        print(
            '[POST - ${ApiConst.getAllMenuURL}] ERROR ${e.response?.statusCode} ==> ${e.response?.data}');

        return AllMenuRes.fromJson(e.response!.data);
      } else {
        if (e.response == null) {
          CustomSnackbar().snackBar(
            title: 'Terjadi Kesalahan',
            message: 'Unknown Error',
          );
          print('Debug HomeRepository ln-40');
          print(
              '[POST - ${ApiConst.getAllMenuURL}] ERROR ${e.response?.statusCode} ==> ${e.response?.data}');

          return AllMenuRes();
        } else {
          print('Debug HomeRepository ln-46');
          print(
              '[POST - ${ApiConst.getAllMenuURL}] ERROR ${e.response?.statusCode} ==> ${e.response?.data}');

          return AllMenuRes();
        }
      }
    }
  }

  /// GET KATEGORI MAKANAN
  Future<KategoriMenuRes> getMenuKategoriMakanan() async {
    try {
      var result = await DioService.dioCall().get(
        ApiConst.getMenuMakananURL,
      );

      var resultMenu = KategoriMenuRes.fromJson(result.data);
      // print('DEBUG HOME REPOSITORY');
      // print('data : ${result.data}');
      // print('data : ${resultMenu.data?[0]}');
      return resultMenu;
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        CustomSnackbar().snackBar(
          title: 'Terjadi Kesalahan',
          message: 'Connection Timeout',
        );

        print(
            '[POST - ${ApiConst.getMenuMakananURL}] ERROR ${e.response!.statusCode} ==> ${e.response!.data}');

        return KategoriMenuRes.fromJson(e.response!.data);
      } else {
        if (e.response == null) {
          CustomSnackbar().snackBar(
            title: 'Terjadi Kesalahan',
            message: 'Unknown Error',
          );

          print(
              '[POST - ${ApiConst.getMenuMakananURL}] ERROR ${e.response!.statusCode} ==> ${e.response!.data}');

          return KategoriMenuRes.fromJson(e.response!.data);
        } else {
          print(
            '[POST - ${ApiConst.getMenuMakananURL}] ERROR ${e.response!.statusCode} ==> ${e.response!.data}',
          );

          return KategoriMenuRes.fromJson(e.response!.data);
        }
      }
    }
  }
}
