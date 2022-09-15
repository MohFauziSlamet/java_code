// ignore_for_file: avoid_print
import 'package:get/get.dart';
import 'package:java_code/constant/core/hive_const.dart';

import 'package:java_code/modules/models/user_data_res/data_user.dart';

class SplashScreenController extends GetxController {
  static SplashScreenController get to => Get.find();

  // membuat variabel apakah di sudah pernah login (auth)
  // tujuannya: jika sudah pernah auth , akan ke home_screen
  // jika belum , akan ke login_screen
  RxBool isAuth = false.obs;

  /// ---------------------------FIRST_INITIALIZED------------------------------
  /// membuat function untuk mengubah nilai isAuth dan isSkipIntroduction => true
  Future<void> firstInitialized() async {
    /// kita jalankan function autoLogin
    await autoLogin().then(
      (value) {
        if (value) {
          isAuth.value = true;
        }
      },
    );
  }

  Future<bool> autoLogin() async {
    // Hive.openBox(HiveConst.dataUserTokenHiveBox).then((value) {
    //   Hive.box<DataUser>(HiveConst.dataUserTokenHiveBox);
    // });
    var token = DataUserManager?.getAllNotes()
            .toMap()[HiveConst.dataUserTokenHiveKey]
            ?.token ??
        '';
    print('DEBUG SPLASH CONTROLLER');
    print(token);
    if (token != '') {
      return true;
    }
    return false;
    // try {
    //   var token = DataUserManager?.getAllNotes()
    //           .toMap()[HiveConst.dataUserTokenHiveKey]
    //           ?.token ??
    //       '';
    //   print('DEBUG SPLASH CONTROLLER');
    //   print(token);
    //   if (token != '') {
    //     return true;
    //   }
    //   return false;
    // } catch (e) {
    //   print("terjadi kesalahan auto login : $e");

    //   return false;
    // }
  }

  @override
  void onInit() async {
    await autoLogin();
    await firstInitialized();

    super.onInit();
  }
}
