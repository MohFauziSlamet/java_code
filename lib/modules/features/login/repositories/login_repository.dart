import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:java_code/constant/core/api_const.dart';
import 'package:java_code/modules/models/user_data_res/user_data_res.dart';
import 'package:java_code/utils/services/dio_service.dart';
import 'package:get/get.dart';

class LoginRepository {
  Future<DataUserRes> loginWithEndpoint({
    required String email,
    required String password,
  }) async {
    // PASANG DIO SERVICE YANG DI BUAT

    try {
      // PASANG DIO SERVICE YANG DI BUAT
      var response = await DioService.dioCall().post(
        ApiConst.postLoginURL,
        data: {
          "email": email,
          "password": password,
        },
      );

      var jsonResponse = response.data;

      if (jsonResponse['status_code'] == 200) {
        return DataUserRes.fromJson(response.data);
      }
      return DataUserRes(statusCode: response.statusCode);
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        Get.snackbar('Terjadi Kesalahan', 'Connection Timeout');
        // ignore: avoid_print
        log('[POST - ${ApiConst.postLoginURL}] ERROR ${e.response?.statusCode} ==> ${e.response?.data} ln40');

        return DataUserRes.fromJson(e.response?.data);
      } else {
        if (e.response == null) {
          Get.snackbar('Terjadi Kesalahan', 'Unknown Error');
          log('[POST - ${ApiConst.postLoginURL}] ERROR ${e.response?.statusCode} ==> ${e.response?.data} ln 45');

          return DataUserRes();
        } else {
          Get.snackbar('Terjadi Kesalahan', 'Unknown Error');
          // ignore: avoid_log
          log('[POST - ${ApiConst.postLoginURL}] ERROR ${e.response?.statusCode} ==> ${e.response?.data} ln 55');

          return DataUserRes();
        }
      }
    }
  }

  /// -----------------------LOGIN_WITH_GOOGLE--------------------------
  // inisiasi _googleSignIn
  GoogleSignIn googleSignIn = GoogleSignIn();
  // menghandle user
  // buat variabel untuk menampung data value dari signIn
  // dengan tipe kembalian GoogleSignInAccount
  GoogleSignInAccount? _currentUser;

  // digunakan untuk menampung value credential dari proses
  // signInWithCredential(credential)
  UserCredential? userCredential;
  Future<UserCredential?> authLoginGoogle() async {
    try {
      // signOut :Menandai pengguna saat ini berada dalam status keluar.
      // memastikan pengguna telah signed out dari hp , sebelum melakukan login kembali
      await googleSignIn.signOut();

      // signIn() : Memulai proses masuk interaktif.
      // Returned Future diselesaikan ke instans [GoogleSignInAccount] untuk proses masuk
      // atau null yang dikembalikan jika proses masuk dibatalkan.
      // Proses otentikasi dipicu hanya jika tidak ada pengguna yang masuk
      // (yaitu saat currentUser == null),
      // jika tidak metode ini mengembalikan Masa Depan yang diselesaikan ke instans pengguna yang sama.
      // Autentikasi ulang hanya dapat dipicu setelah [signOut] atau [disconnect].
      // methode ini untuk mendapatkan google account
      await googleSignIn.signIn().then(
            (value) => _currentUser = value,
          );

      // mengecek  status login user apakah sedang sign in atau tidak
      // mengembalikan nilai true or false
      final isSignIn = await googleSignIn.isSignedIn();

      if (isSignIn) {
        // kondisi login berhasil
        // print("SUDAH BERHASIL LOGIN DENGAN AKUN : ");
        // print(_currentUser);
        //
        // mendapatkan accessToken dam idToken dari _currentUser
        final googleAuth = await _currentUser!.authentication;

        // mendapatkan credential dari GoogleAuthProvider
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        // memasukan data kedalam firebase Auth
        // kita membutuhkan firebase instance
        // dan
        // kita membutuhkan Oauthcredential sebagai pengisi paramater
        await FirebaseAuth.instance
            .signInWithCredential(credential)
            .then((value) => userCredential = value);

        return userCredential;
      } else {
        Get.defaultDialog(
            title: 'Terjadi kesalahan', middleText: "Gagal Login");
        log('Gagal Login !');
        return userCredential;
      }
    } catch (error) {
      Get.defaultDialog(title: 'Terjadi kesalahan', middleText: "$error");
      // ignore: avoid_print
      print("terjadi kesalahan $error");

      return userCredential;
    }
  }

  Future<DataUserRes> loginWithGoogleEndpoint({
    required String email,
    required String nama,
  }) async {
    // PASANG DIO SERVICE YANG DI BUAT

    try {
      // PASANG DIO SERVICE YANG DI BUAT
      var response = await DioService.dioCall().post(
        ApiConst.postLoginWithGoogle,
        data: {
          "email": email,
          "nama": nama,
        },
      );

      var jsonResponse = response.data;

      if (jsonResponse['status_code'] == 200) {
        return DataUserRes.fromJson(response.data);
      }
      return DataUserRes(statusCode: response.statusCode);
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        Get.snackbar('Terjadi Kesalahan', 'Connection Timeout');
        // ignore: avoid_print
        log('[POST - ${ApiConst.postLoginURL}] ERROR ${e.response?.statusCode} ==> ${e.response?.data} ln40');

        return DataUserRes();
      } else {
        if (e.response == null) {
          Get.snackbar('Terjadi Kesalahan', 'Unknown Error');
          log('[POST - ${ApiConst.postLoginURL}] ERROR ${e.response?.statusCode} ==> ${e.response?.data} ln 45');

          return DataUserRes();
        } else {
          Get.snackbar('Terjadi Kesalahan', 'Unknown Error');
          // ignore: avoid_log
          log('[POST - ${ApiConst.postLoginURL}] ERROR ${e.response?.statusCode} ==> ${e.response?.data} ln 55');

          return DataUserRes();
        }
      }
    }
  }
}
