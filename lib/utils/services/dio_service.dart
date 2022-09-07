import 'package:dio/dio.dart';
import 'package:java_code/constant/core/api_const.dart';
import 'package:java_code/constant/core/hive_const.dart';
import 'package:java_code/modules/models/user_data_res/data_user.dart';

class DioService {
  //* Create Singleton
  DioService._();

  //* Methods (Function)
  static Dio dioCall({int connectTimeout = 20000}) {
    // Variables
    // 'Token user login : ${DataUserManager.getAllNotes().toMap()[HiveConst.dataUserTokenHiveKey]!.token}'
    late Map<String, dynamic> header;
    String? token = DataUserManager?.getAllNotes()
            .toMap()[HiveConst.dataUserTokenHiveKey]
            ?.token ??
        '';
    // print('dio servis');
    // print(token);

    header = {
      "Content-Type": "application/json",
      "token": token,
    };

    var dio = Dio(
      BaseOptions(
        headers: header,
        // PASANG BASE URL
        baseUrl: ApiConst.baseURL,
        connectTimeout: connectTimeout,
      ),
    );

    return dio;
  }
}
