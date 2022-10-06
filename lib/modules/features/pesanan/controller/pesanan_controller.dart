// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:java_code/config/routes/app_routes.dart';
import 'package:java_code/constant/core/hive_const.dart';
import 'package:java_code/modules/features/pesanan/repositories/pesanan_repository.dart';
import 'package:java_code/modules/features/pesanan/view/componen/pop_up_delete.dart';
import 'package:java_code/modules/models/get_diskon_by_user_id_res/get_diskon_by_user_id_res.dart';
import 'package:java_code/modules/models/hive/menu_hive_model.dart';
import 'package:java_code/modules/models/hive/order_hive_model.dart';
import 'package:java_code/modules/models/post_order_res/post_order_res.dart';
import 'package:java_code/modules/models/user_data_res/data_user.dart';
import 'package:java_code/modules/models/user_data_res/user.dart';
import 'package:java_code/utils/services/hive_services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_ios/local_auth_ios.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PesananController extends GetxController {
  static PesananController get to => Get.find();
  RxString loadingDiskon = 'loading'.obs;
  GetDiskonByUserIdRes resultDiskon = GetDiskonByUserIdRes();
  RxInt percentDiskon = 0.obs;
  List<MenuHive>? menuHive = [];
  LocalAuthentication auth = LocalAuthentication();

  PesananRepository repository = PesananRepository();
  PostOrderRes postOrderResult = PostOrderRes();
  TextEditingController pinController = TextEditingController();
  StreamController<ErrorAnimationType> errorController = StreamController<ErrorAnimationType>();
  RxBool isSuccess = false.obs;

  Future<PostOrderRes> postOrderMenu() async {
    OrderHive dataOrder = OrderHive();
    dataOrder.idUser = DataUserManager?.getAllNotes().toMap()[HiveConst.dataUserTokenHiveKey]?.user?.idUser ?? 0;
    dataOrder.idVoucher = 0;
    dataOrder.potongan = diskonAmount() ?? 0;
    dataOrder.totalBayar = grandTotalPrice();
    dataOrder.menu = menuHive;

    var res = await repository.postOrderMenu(dataOrderMenu: dataOrder);

    if (res.data != null) {
      log('PESANAN CONTROLLER => HASIL KEMBALIAN METHODE POST ORDER');

      postOrderResult.statusCode = res.statusCode;
      postOrderResult.data = res.data;
      log('data postOrderResult : ${postOrderResult.toJson()}');
      // hapus data hive list

      // Hive.box<OrderHive>(HiveConst.orderHiveBox).values.first.delete();
      // dataOrder.delete();
      return postOrderResult;
    } else {
      return PostOrderRes();
    }
  }

  /// GET DISKON BY ID USER
  Future<void> getDiskonByIdUser() async {
    GetDiskonByUserIdRes res = await repository.getDiskonByIdUser();

    if (res.statusCode == 200) {
      loadingDiskon.value = 'sukses';
      log('ISI VALUE GET DISKON : ${res.toJson()}');
      resultDiskon = res;
    } else if (res.statusCode == 204) {
      loadingDiskon.value = 'empty';
      log('DATA EMPTY');
    } else {
      loadingDiskon.value = 'error';
      log('DATA ERROR');
    }
  }

  ///
  List<MenuHive>? getMenuHive() {
    menuHive = Hive.box<OrderHive>(HiveConst.orderHiveBox).values.first.menu;
    update();
    return menuHive;
  }

// TAMBAH JUMLAH PESANAN
  addAmount({required int index}) {
    menuHive![index].jumlah = menuHive![index].jumlah! + 1;
    hitungTotalHarga(index: index);

    update();
  }

// KURANG JUMLAH PESANAN
  // RxInt grandTotal = 0.obs;
  subtractAmount({required int index}) {
    if (menuHive![index].jumlah! > 1) {
      menuHive![index].jumlah = menuHive![index].jumlah! - 1;
      hitungTotalHarga(index: index);

      update();
    } else {
      log('MENGHAPUS DATA HIVE');
      Get.defaultDialog(
        title: '',
        content: DialogNotifDeleteCountOrderIfOne(onPressedOke: () async {
          deleteItemFromCart(index);

          Get.back();
          Get.back();
          await Get.toNamed(AppRoutes.dashboardView);
          update();
        }),
      );
    }
  }

  deleteItemFromCart(int index) {
    OrderHive orderHive = Hive.box<OrderHive>(HiveConst.orderHiveBox).values.first;
    if (index >= 0) {
      orderHive.totalBayar = orderHive.totalBayar! - orderHive.menu![index].harga!;
      orderHive.menu!.removeAt(index);

      HiveServices.addOrderMenu(orderHive);

      Get.close(1);
      update();
    }
  }

  // MENGHITUNG HARGA
  hitungTotalHarga({required int index}) {
    menuHive![index].harga = (menuHive![index].hargaAsli! * menuHive![index].jumlah!) + (menuHive![index].jumlah! * menuHive![index].hargaLevel!) + (menuHive![index].jumlah! * menuHive![index].totalHargaTopping!);
  }

  int get totalAmountSementara => menuHive!.map((element) => element.harga!).toList().reduce((value, element) => value + element).toInt();

  int finalAmount() {
    if (totalAmountSementara != 0) {
      return totalAmountSementara;
    }
    update();
    return 0;
  }

  // NOMINAL DISKON
  double? diskonAmount() {
    return (percentDiskon / 100) * totalAmountSementara;
  }

  double? grandTotalPrice() {
    return (finalAmount() - diskonAmount()!.toDouble());
  }

  ///
  Future<void> authenticateWithBiometrics() async {
    final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
    final bool canAuthenticate = canAuthenticateWithBiometrics || await auth.isDeviceSupported();
    log('CEK DEVICE APAKAH SUPORT FINGERPRINT : ${canAuthenticate.toString()}');

    final List<BiometricType> availableBiometrics = await auth.getAvailableBiometrics();

    if (availableBiometrics.isNotEmpty) {
      // terdaftar beberapa biometrik
      log('CEK AVAIABLE : $availableBiometrics');
    } else if (availableBiometrics.contains(BiometricType.strong) || availableBiometrics.contains(BiometricType.face)) {
      log('CEK AVAIABLE TERTENTU: $availableBiometrics');

      // Jenis biometrik tertentu tersedia.
      // Gunakan cek seperti ini dengan hati-hati!
    } else {
      // TIDAK DAPAT FINGERPRINT MAUPUN FACE
      log('CEK AVAIABLE : $availableBiometrics');
    }

    if (canAuthenticate) {
      try {
        final bool didAuthenticate = await auth.authenticate(
          localizedReason: 'Masukan sidik jari untuk login',
          options: const AuthenticationOptions(
            // biometricOnly
            // jika true , maka hanya menggunakan finger print
            // jika false , maka bisa menggunakan  2. yaitu finger print dan pola
            biometricOnly: false,
            stickyAuth: true,
            useErrorDialogs: true,
            sensitiveTransaction: true,
          ),
          authMessages: [
            const AndroidAuthMessages(
              signInTitle: 'Venturo Biometric authentication required!',
              cancelButton: 'No thanks',
              biometricHint: 'Lakukan verifikasi untuk melanjutkan pesanan kamu',
              // biometricNotRecognized: 'biometricNotRecognized : diguakan untuk mengirim Pesan untuk memberi tahu pengguna bahwa autentikasi gagal. Maksimal 60 karakter',
              // biometricRequiredTitle: 'biometricRequiredTitle digunakan untuk mengirim Pesan ditampilkan sebagai judul dalam dialog yang menunjukkan bahwa pengguna belum menyiapkan autentikasi biometrik pada perangkat mereka. Maksimal 60 karakter.',
              goToSettingsButton: 'Open Setting Now',
              biometricSuccess: 'Finger Sukses',
            ),
            const IOSAuthMessages(
              cancelButton: 'No thanks',
            ),
          ],
        );

        // kita cek fingerprint
        // jika bisa , maka true
        // kita kirim post chekcoutnya
        if (didAuthenticate == true) {
          // kirim order
          log('POST ORDER WITH BIOMETRIC');
          await postOrderMenu();
        }
        log('Cek apakah finger benar $didAuthenticate');
      } on PlatformException catch (e) {
        // TERJADI KESALAHAN TERTENTU
        log(e.toString());
      }
    }
  }

  Future<void> checkPin() async {
    if (pinController.text == Hive.box<User>(HiveConst.userHiveBox).values.first.pin) {
      await postOrderMenu();
      isSuccess.value = true;
      log('POST ORDER WITH PIN');
      update();
    } else {
      errorController.add(ErrorAnimationType.shake);
    }
  }

  @override
  void onInit() {
    getMenuHive();

    update();
    super.onInit();
  }
}
