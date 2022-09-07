import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:java_code/config/routes/app_routes.dart';
import 'package:java_code/constant/core/api_const.dart';
import 'package:java_code/modules/models/user_data_res/user_data_res.dart';
import 'package:java_code/modules/models/user_google_res/user_google_res.dart';
import 'package:java_code/utils/services/dio_service.dart';
import 'package:get/get.dart';

class LoginRepository {
  Future<DataUserRes> loginWithEndpoint({
    required String email,
    required String password,
  }) async {
    try {
      // PASANG DIO SERVICE YANG DI BUAT
      var response = await DioService.dioCall().post(
        ApiConst.postLoginURL,
        queryParameters: {
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
        print(
            '[POST - ${ApiConst.postLoginURL}] ERROR ${e.response?.statusCode} ==> ${e.response?.data}');

        return DataUserRes.fromJson(e.response?.data);
      } else {
        if (e.response == null) {
          Get.snackbar('Terjadi Kesalahan', 'Unknown Error');
          // ignore: avoid_print
          print(
              '[POST - ${ApiConst.postLoginURL}] ERROR ${e.response?.statusCode} ==> ${e.response?.data}');

          return DataUserRes.fromJson(e.response?.data);
        } else {
          // ignore: avoid_print
          print(
              '[POST - ${ApiConst.postLoginURL}] ERROR ${e.response?.statusCode} ==> ${e.response?.data}');

          return DataUserRes.fromJson(e.response?.data);
        }
      }
    }
  }

  /// -----------------------LOGIN_WITH_GOOGLE--------------------------
  /// Membuat fungsi authLogin dengan google
  // membuat variabel apakah dia sudah pernah login (auth)
  // tujuannya: jika sudah pernah auth , akan ke home_screen
  // jika belum , akan ke login_screen
  RxBool isAuth = false.obs;

  /// membuat variabel user dari UserModel
  var userModel = UserGoogleRes().obs;

  // inisiasi _googleSignIn
  GoogleSignIn googleSignIn = GoogleSignIn();

  /// inisiasi cloud firestore
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // menghandle user
  // buat variabel untuk menampung data value dari signIn
  // dengan tipe kembalian GoogleSignInAccount
  GoogleSignInAccount? _currentUser;

  // digunakan untuk menampung value credential dari proses
  // signInWithCredential(credential)
  UserCredential? userCredential;
  Future<void> authLogin() async {
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

        // ignore: avoid_print
        print(userCredential);

        /// ------------------------------
        /// sebelum masuk
        /// kita simpan data kedalam firestore
        /// kita buat CollectionReference sbg nama tempat penyimpaanannya
        CollectionReference users = firestore.collection("googleUsers");

        /// sebelum ditambahakan kedalam database
        /// kita check dulu , dia pengguna baru atau hanya sekedar login kembali
        /// hal ini terjadi , karena button login dan signUp menjadi satu
        /// pertama kita coba ambil data email yang di buat signIn , sudah ada di database apa tidak
        final checkUser = await users.doc(_currentUser!.email).get();

        if (checkUser.data() == null) {
          /// jika data yang diambil kosong. maka ,
          /// menambahkan data kedalam firestore
          /// doc(): untuk membuat uniq id sendiri, agar tidak di generate oleh firestore
          /// set(): proses setelah doc. yaitu menambahkan data yang akan disimpan di firebase firestore
          await users.doc(_currentUser!.email).set({
            'uid': userCredential!.user!.uid,
            'name': userCredential!.user!.displayName,
            "email": userCredential!.user!.email,
            "photoURL": userCredential!.user!.photoURL ?? 'no image',
            "creationTime":
                userCredential!.user!.metadata.creationTime!.toIso8601String(),
            "lastSignInTime": userCredential!.user!.metadata.lastSignInTime!
                .toIso8601String(),
            "updatedAt": DateTime.now().toIso8601String(),
          });
        } else {
          /// jika ternyata data yang di ambil berdasarkan email , ada isinya
          /// maka hanya akan melakukan update pada lastSignInTime
          await users.doc(_currentUser!.email).update({
            "lastSignInTime": userCredential!.user!.metadata.lastSignInTime!
                .toIso8601String(),
          });
        }

        /// setelah berhasil dimasukan ke dalam database
        /// data kita ambil lagi , dan kita masukan kedalam model
        /// untuk digunakan didalam aplikasi

        /// ambil data
        final currUser = await users.doc(_currentUser!.email).get();

        /// memasukan data kedalam variabel
        Map<String, dynamic> currentUserData = {};
        currentUserData = currUser.data() as Map<String, dynamic>;

        /// memasukan data kedalam model
        /// dengan mengupdate keseluruhan data / override / mereplace
        /// menggunakan methode dari GetX baru
        /// dikarenakan ketika awal memasukan data , kita tidak menambahkan data chats
        /// kareana chat merupakan sebuah collection baru
        userModel(UserGoogleRes.fromJson(currentUserData));
        userModel.refresh();
        // ignore: avoid_print
        print(userModel);

        /// ------------------------------
        // jika value true
        // maka berhasil login
        // kita ubah isAuth = true
        isAuth.value = true;
        Get.offAllNamed(AppRoutes.loadingLokasi);
        //

      } else {
        // ignore: avoid_print
        print('Gagal Login !');
        // jika value false
        // maka gagal login
      }
    } catch (error) {
      Get.defaultDialog(title: 'Terjadi kesalahan', middleText: "$error");
      // ignore: avoid_print
      print("terjadi kesalahan $error");
    }
  }

  Future<bool> autoLogin() async {
    try {
      /// kita check apakah aplikasi dalam kondisi ada akun google(sudah signIn)
      /// isSigned = akan mengembalikan nilai bool .
      final isSigned = await googleSignIn.isSignedIn();
      if (isSigned) {
        /// sebelum mengembalikan nilai true
        /// jika benar2 signIn dan ada data nya , kita akan memasukan data kedalam UserModel
        /// signInSilently : Upaya untuk masuk ke pengguna yang sebelumnya diautentikasi tanpa interaksi.(autoLogin)
        await googleSignIn.signInSilently().then(
              (value) => _currentUser = value,
            );

        /// ==== proses memasukan data login ke firebase_auth ====
        /// kita juga akan buat credential baru
        /// uratan langkahnya sbb
        /// mendapatkan accessToken dam idToken dari _currentUser
        final googleAuth = await _currentUser!.authentication;

        /// mendapatkan credential dari GoogleAuthProvider
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        /// buat variabel untuk menampung value credential dari proses signInWithCredential(credential)
        UserCredential? userCredential;

        // memasukan data kedalam firebase Auth
        // kita membutuhkan firebase instance
        // dan
        // kita membutuhkan Oauthcredential sebagai pengisi paramater
        await FirebaseAuth.instance
            .signInWithCredential(credential)
            .then((value) => userCredential = value);

        /// ======================================================

        /// sebelum masuk ke home
        /// kita simpan data kedalam firestore
        /// kita buat CollectionReference sbg nama tempat penyimpaanannya
        CollectionReference users = firestore.collection("users");

        /// karena autoLogin, sudah pasti ada datanya, kita tidak perlu mengechek lagi.
        /// kita bisa langsung melakukan update pada lastSignInTime
        await users.doc(_currentUser!.email).update({
          "lastSignInTime":
              userCredential!.user!.metadata.lastSignInTime!.toIso8601String(),
        });

        /// setelah berhasil dimasukan ke dalam database
        /// data kita ambil lagi , dan kita masukan kedalam model
        /// untuk digunakan didalam aplikasi

        /// ambil data
        final currUser = await users.doc(_currentUser!.email).get();

        /// memasukan data kedalam variabel
        Map<String, dynamic> currentUserData =
            currUser.data() as Map<String, dynamic>;

        /// memasukan data kedalam model
        /// dengan mengupdate keseluruhan data / override / mereplace
        /// menggunakan methode dari GetX baru
        /// dikarenakan ketika awal memasukan data , kita tidak menambahkan data chats
        /// kareana chat merupakan sebuah collection baru
        userModel(UserGoogleRes.fromJson(currentUserData));

        userModel.refresh();

        /// mengembalikan nilai true
        return true;
      }
      return false;
    } catch (e) {
      Get.defaultDialog(
        title: 'Terjadi Kesalahan',
        middleText: "$e",
        onConfirm: () {
          Get.back();
        },
        textConfirm: 'kembali',
      );

      // ignore: avoid_print
      print("terjadi kesalahan auto login : $e");

      return false;
    }
  }

  /// -----------------------FIRST_INITIALIZED--------------------------
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
}
