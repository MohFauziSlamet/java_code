// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:java_code/config/routes/app_routes.dart';
import 'package:java_code/config/themes/colours.dart';

class ProfileController extends GetxController {
  static ProfileController get to => Get.find();
  RxBool isLoading = false.obs;

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
