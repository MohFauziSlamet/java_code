// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:java_code/config/routes/app_routes.dart';
import 'package:java_code/config/themes/colours.dart';
import 'package:java_code/constant/core/hive_const.dart';
import 'package:java_code/modules/models/user_data_res/akses.dart';
import 'package:java_code/modules/models/user_data_res/data_user.dart';
import 'package:java_code/modules/models/user_data_res/user.dart';
import 'package:java_code/utils/services/hive_services.dart';

class ProfileController extends GetxController {
  static ProfileController get to => Get.find();
  RxBool isLoading = false.obs;

  Future<void> keluar() async {
    await HiveServices.deleteAkses(
        HiveConst.aksesHiveKey, HiveConst.aksesHiveBox);
    await HiveServices.deleteToken(
        HiveConst.dataUserTokenHiveKey, HiveConst.dataUserTokenHiveBox);
    await HiveServices.deleteUserData(
        HiveConst.userHiveKey, HiveConst.userHiveBox);

    print('DEBUG PROFILE CONTROLLER');
    print(AksesManager.getAllNotes().toMap());
    print(DataUserManager.getAllNotes().toMap());
    print(UserManager.getAllNotes().toMap()[HiveConst.userHiveKey]?.email);

    Get.offAllNamed(AppRoutes.login);
  }

  /// ================== LOGOUT ==================
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<void> logout() async {
    try {
      await auth.signOut();
      Get.offAllNamed(AppRoutes.login);
      Get.snackbar(
        "Berhasil",
        "Anda Berhasil Logout",
        backgroundColor: Colours.green2,
        overlayBlur: 1,
        duration: const Duration(seconds: 1),
      );
    } catch (e) {
      print(e.toString());
      Get.snackbar(
        "Terjadi Kesalahan",
        "Tidak Berhasil Logout. Hubungi Admin",
        backgroundColor: Colours.green2,
        overlayBlur: 1,
        duration: const Duration(seconds: 1),
      );
    }
  }
}
