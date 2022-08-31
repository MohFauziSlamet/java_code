// ignore_for_file: avoid_print

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:java_code/constant/core/api_const.dart';
import '/config/routes/app_routes.dart';
import '/config/themes/colours.dart';

class LoginController extends GetxController {
  static LoginController get to => Get.find();

  RxBool isHidden = false.obs;
  RxBool isLoading = false.obs;
  RxBool rememberMe = false.obs;
  late TextEditingController emailLoginC;
  late TextEditingController passLoginC;
  late TextEditingController emailRegisterC;
  late TextEditingController passRegisterC;
  late TextEditingController nameRegisterC;
  late TextEditingController phoneRegisterC;
  late TextEditingController dateRegisterC;
  FirebaseAuth auth = FirebaseAuth.instance;

  /// INISIASI CLOUD FIRESTORE
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final box = GetStorage();

  @override
  void onInit() {
    emailLoginC = TextEditingController();
    passLoginC = TextEditingController();
    emailRegisterC = TextEditingController();
    passRegisterC = TextEditingController();
    nameRegisterC = TextEditingController();
    phoneRegisterC = TextEditingController();
    dateRegisterC = TextEditingController();
    super.onInit();
  }

  // @override
  // void onClose() {
  //   emailLoginC.dispose();
  //   passLoginC.dispose();
  //   emailRegisterC.dispose();
  //   passRegisterC.dispose();
  //   nameRegisterC.dispose();
  //   phoneRegisterC.dispose();
  //   dateRegisterC.dispose();
  //   super.onClose();
  // }

  /// LOGIN FIREBASE
  void login() async {
    /// CEK EMAIL DAN PASSWORD TIDAK BOLEH KOSONG
    if (emailLoginC.text.isNotEmpty && passLoginC.text.isNotEmpty) {
      if (GetUtils.isEmail(emailLoginC.text)) {
        try {
          isLoading.value = true;
          final UserCredential credential =
              await auth.signInWithEmailAndPassword(
            email: emailLoginC.text,
            password: passLoginC.text,
          );

          print(credential);

          /// CEK , APAKAH EMAIL SUDAH DIVERIFIKASI
          if (credential.user!.emailVerified == true) {
            Get.offAllNamed(AppRoutes.login);
            Get.snackbar(
              "Berhasil",
              "Anda Berhasil Login",
              backgroundColor: Colours.green2,
              overlayBlur: 1,
              duration: const Duration(seconds: 1),
            );
            Get.offAllNamed(AppRoutes.dashboardView);
          } else {
            Get.defaultDialog(
              title: "Belum Terverifikasi",
              middleText: "Apakah Kamu Ingin Mengirim Ulang Email Verifkasi ?",
              actions: [
                /// TIDAK
                OutlinedButton(
                  onPressed: () {
                    Get.back(); // MENUTUP DIALOG
                  },
                  child: const Text("TIDAK"),
                ),

                /// YA
                ElevatedButton(
                  onPressed: () async {
                    try {
                      await credential.user!.sendEmailVerification();
                      Get.back(); // MENUTUP DIALOG
                      Get.snackbar(
                        "BERHASIL",
                        "Cek Email Kamu dan Lakukan Verfikasi",
                        backgroundColor: Colours.green2,
                        overlayBlur: 1,
                        duration: const Duration(seconds: 1),
                      );
                    } catch (e) {
                      print(e.toString());
                      Get.back(); // MENUTUP DIALOG
                      Get.snackbar(
                        "ERROR",
                        "Kirim Verifikasi Gagal. Coba Lagi 5 Menit Lagi",
                        backgroundColor: Colours.green2,
                        overlayBlur: 1,
                        duration: const Duration(seconds: 1),
                      );
                    }
                  },
                  child: const Text("KIRIM KEMBALI"),
                ),
              ],
            );
          }
        } on FirebaseAuthException catch (e) {
          print(e.code);
          if (e.code == 'user-not-found') {
            // print('No user found for that email.');
            Get.snackbar(
              "Terjadi Kesalahan",
              "Email Yang Anda Masukan Tidak Tersedia",
              backgroundColor: Colours.green2,
              overlayBlur: 1,
              duration: const Duration(seconds: 1),
            );
          } else if (e.code == 'wrong-password') {
            // print('Wrong password provided for that user.');
            Get.snackbar(
              "Terjadi Kesalahan",
              "Password Yang Anda Masukan Salah",
              backgroundColor: Colours.green2,
              overlayBlur: 1,
              duration: const Duration(seconds: 1),
            );
          }
        } catch (e) {
          print(e.toString());
          Get.snackbar(
            "Terjadi Kesalahan",
            "Tidak dapat login. Hubungi Admin!",
            backgroundColor: Colours.green2,
            overlayBlur: 1,
            duration: const Duration(seconds: 2),
          );
        } finally {
          isLoading.value = false;
        }
      } else {
        Get.snackbar(
          "Terjadi Kesalahan",
          "Email Yang Anda Masukan, Bukan Email",
          backgroundColor: Colours.green2,
          overlayBlur: 1,
          duration: const Duration(seconds: 1),
        );
      }
    } else {
      Get.snackbar(
        "Terjadi Kesalahan",
        "Semua Form Harus Diisi",
        backgroundColor: Colours.green2,
        overlayBlur: 1,
        duration: const Duration(seconds: 1),
      );
    }
  }

  /// REGISTER FIREBASE
  void register() async {
    /// CEK EMAIL DAN PASSWORD TIDAK BOLEH KOSONG
    if (emailRegisterC.text.isNotEmpty &&
        passRegisterC.text.isNotEmpty &&
        nameRegisterC.text.isNotEmpty &&
        dateRegisterC.text.isNotEmpty &&
        phoneRegisterC.text.isNotEmpty) {
      /// MENANYAKAN APAKAH BENAR INI FORMAT EMAIL
      if (GetUtils.isEmail(emailRegisterC.text)) {
        if (GetUtils.isPhoneNumber(phoneRegisterC.text)) {
          try {
            isLoading.value = true;
            final credential = await auth.createUserWithEmailAndPassword(
              email: emailRegisterC.text,
              password: passRegisterC.text,
            );

            try {
              /// KIRIM EMAIL VERIFIKASI
              await credential.user!.sendEmailVerification();
            } catch (e) {
              if (kDebugMode) {
                print(e.toString());
              }
              Get.snackbar(
                "ERROR",
                "Tidak Dapat Kirimi Email Verifikasi. Hubungi Admin",
                backgroundColor: Colours.green2,
                overlayBlur: 1,
                duration: const Duration(seconds: 1),
              );
            }

            if (kDebugMode) {
              print(credential);
            }

            /// MEMASUKAN DATA KE CLOUD FIRESTORE
            String uid = credential.user!.uid; // MEMAKAI UID UNTUK MENYIMPAN
            firestore.collection("users").doc(uid).set({
              "name": nameRegisterC.text,
              "phone": phoneRegisterC.text,
              "email": emailRegisterC.text,
              "date": dateRegisterC.text,
              "uid": uid,
              "createdAt": DateTime.now().toIso8601String(),
            });

            /// MENAMPILKAN DIALOG UNTUK VERIFIKASI
            Get.defaultDialog(
              title: "VERIFIKASI",
              middleText:
                  "Berhasil Registrasi. Buka Email dan Lakukan Verifikasi Email",
              barrierDismissible: false,
              textConfirm: "SAYA MENGERTI",
              onConfirm: () {
                Get.back();
                Get.offAllNamed(AppRoutes.login);
                Get.snackbar(
                  "Berhasil",
                  "Cek Email Kamu Dan Lakukan Verifikasi",
                  backgroundColor: Colours.green2,
                  overlayBlur: 1,
                  duration: const Duration(seconds: 1),
                );
              },
            );

            ///
          } on FirebaseAuthException catch (e) {
            if (kDebugMode) {
              print(e.code);
            }
            if (e.code == 'weak-password') {
              // print('The password provided is too weak.');
              Get.snackbar(
                "Terjadi Kesalahan",
                "Password terlalu lemah",
                backgroundColor: Colours.green2,
                overlayBlur: 1,
                duration: const Duration(seconds: 2),
              );
            } else if (e.code == 'email-already-in-use') {
              // print('The account already exists for that email.');
              Get.snackbar(
                "Terjadi Kesalahan",
                "Email Telah Tersedia",
                backgroundColor: Colours.green2,
                overlayBlur: 1,
                duration: const Duration(seconds: 1),
              );
            }
          } catch (e) {
            if (kDebugMode) {
              print(e.toString());
            }

            /// KETIKA ERROR SECARA GENERAL
            Get.snackbar(
              "Terjadi Kesalahan",
              "Tidak dapat Registrasi. Hubungi Admin!",
              backgroundColor: Colours.green2,
              overlayBlur: 1,
              duration: const Duration(seconds: 1),
            );
          } finally {
            isLoading.value = false;
          }
        } else {
          /// KETIKA NOMOR YANG DIMASUKAN BUKAN NOMOR HANDPHONE
          Get.snackbar(
            "Terjadi Kesalahan",
            "Nomor Yang Anda Masukan, Bukan Nomor Handphone",
            backgroundColor: Colours.green2,
            overlayBlur: 1,
            duration: const Duration(seconds: 1),
          );
        }
      } else {
        /// KETIKA EMAIL YANG DIMASUKAN BUKAN EMAIL
        Get.snackbar(
          "Terjadi Kesalahan",
          "Email Yang Anda Masukan, Bukan Email",
          backgroundColor: Colours.green2,
          overlayBlur: 1,
          duration: const Duration(seconds: 1),
        );
      }
    } else {
      /// KETIKA ADA FORM YANG TIDAK DIISI
      Get.snackbar(
        "Terjadi Kesalahan",
        "Semua Form Harus Diisi",
        backgroundColor: Colours.green2,
        overlayBlur: 1,
        duration: const Duration(seconds: 1),
      );
    }
  }

  /// POST LOGIN ENDPOINT
  void postLogin() async {
    /// CEK EMAIL DAN PASSWORD TIDAK BOLEH KOSONG
    if (emailLoginC.text.isNotEmpty && passLoginC.text.isNotEmpty) {
      if (GetUtils.isEmail(emailLoginC.text)) {
        try {
          isLoading.value = true;

          var result = await Dio()
              .post('${ApiConst.baseURL}${ApiConst.postLoginURL}', data: {
            "email": emailLoginC.text,
            "password": passLoginC.text,
          });

          print(result.toString());
          Get.offAllNamed(AppRoutes.dashboardView);
          Get.snackbar(
            "Berhasil",
            "Kamu berhasil login",
            backgroundColor: Colours.green2,
            overlayBlur: 1,
            duration: const Duration(seconds: 1),
          );
        } catch (e) {
          Get.snackbar(
            "Terjadi Kesalahan",
            "Tidak dapat login",
            backgroundColor: Colours.green2,
            overlayBlur: 1,
            duration: const Duration(seconds: 1),
          );
        } finally {
          isLoading.value = false;
        }
      } else {
        Get.snackbar(
          "Terjadi Kesalahan",
          "Email Yang Anda Masukan, Bukan Email",
          backgroundColor: Colours.green2,
          overlayBlur: 1,
          duration: const Duration(seconds: 1),
        );
      }
    } else {
      Get.snackbar(
        "Terjadi Kesalahan",
        "Semua Form Harus Diisi",
        backgroundColor: Colours.green2,
        overlayBlur: 1,
        duration: const Duration(seconds: 1),
      );
    }
  }
}
