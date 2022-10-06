// ignore_for_file: avoid_print, depend_on_referenced_packages

import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:java_code/config/routes/app_routes.dart';

import 'package:java_code/constant/core/hive_const.dart';
import 'package:java_code/modules/features/detail_menu/repository/detail_menu_repository.dart';
import 'package:java_code/modules/models/detail_menu_res/detail_menu_res.dart';
import 'package:java_code/modules/models/detail_menu_res/level.dart';
import 'package:java_code/modules/models/detail_menu_res/menu.dart';
import 'package:java_code/modules/models/hive/menu_hive_model.dart';
import 'package:java_code/modules/models/hive/order_hive_model.dart';
import 'package:java_code/modules/models/hive/topping_hive_model.dart';
import 'package:java_code/utils/extensions/currency_format_to_idr.dart';
import 'package:java_code/utils/services/hive_services.dart';

class DetailMenuController extends GetxController {
  static DetailMenuController get to => Get.find();

  // CONTROLLER UNTUK MENAMBAKAN CATATAN
  TextEditingController catatanController = TextEditingController();

  /// UNTUK DINAMAMIS CHOISE PADA LEVEL MENU
  RxInt listIndexLevel = 0.obs;
  RxString keteranganLevel = '0'.obs;

  /// UNTUK DINAMAMIS CHOISE PADA TOPING MENU
  RxInt listIndexToping = 0.obs;
  RxString keteranganToping = 'Anda Belum Memilih'.obs;

  DetailMenuRepository detailMenuRepository = DetailMenuRepository();

  /// DATA DETAIL MENU
  DetailMenuRes detailMenuResult = DetailMenuRes();
  MenuHive menuHive = MenuHive();
  RxBool isLoading = false.obs;
  Menu menu = Menu();

  var orderBox = Hive.box<OrderHive>(HiveConst.orderHiveBox);

  // var orderBox = Hive.box(HiveConst.orderHiveBox);

  /// DETAIL MENU CONTROLLER
  Future<void> detailMenuRes({required int idMenu}) async {
    var data = await detailMenuRepository.detailMenu(idMenu: idMenu);

    detailMenuResult = data;
    log('Debug DetailMenuController');
    log('DETAIL MENU  : ${detailMenuResult.data?.menu?.toJson()}');
    log('DETAIL TOPING  : ${detailMenuResult.data?.topping}');
    log('DETAIL LEVEL  : ${detailMenuResult.data?.level}');
    menu = data.data!.menu!;
    menuHive.nama = menu.nama ?? "";
    menuHive.gambar = menu.foto ?? "";
    menuHive.harga = menu.harga ?? 0;
    menuHive.hargaAsli = menu.harga ?? 0;
    menuHive.id_menu = menu.idMenu ?? 0;
    menuHive.jumlah = 1;
    menuHive.level = 0;
    menuHive.kategori = menu.kategori ?? "";
    menuHive.kategori = menu.deskripsi ?? "";

    update();
  }

// TAMBAH JUMLAH PESANAN
  addAmount() {
    menuHive.jumlah = menuHive.jumlah! + 1;
    hitungTotalHarga();

    update();
  }

// KURANG JUMLAH PESANAN
  subtractAmount() {
    if (menuHive.jumlah! > 1) {
      menuHive.jumlah = menuHive.jumlah! - 1;
      hitungTotalHarga();
      update();
    }
  }

// MENGHITUNG HARGA
  hitungTotalHarga() {
    menuHive.harga = (menuHive.hargaAsli! * menuHive.jumlah!) + (menuHive.jumlah! * menuHive.hargaLevel!) + (menuHive.jumlah! * menuHive.totalHargaTopping!);
  }

// MEMILIH LEVEL
  void chooseLevel(Level level) {
    if (menuHive.level != level.idDetail) {
      menuHive.keteranganLevel = level.keterangan!;
      menuHive.level = level.idDetail;
      menuHive.hargaLevel = level.harga!;
      hitungTotalHarga();
    } else {
      menuHive.keteranganLevel = 0.toString();
      menuHive.level = 0;
      menuHive.hargaLevel = 0;
      hitungTotalHarga();
    }
    update();
  }

// MEMILIH TOPING
  String getToppingName(List<String?> data) {
    return data.join(", ");
  }

  void addTopping(Level topping, int index) {
    int isAny = menuHive.toppingDetail!.indexWhere((element) => element.idDetail == topping.idDetail);

    if (isAny >= 0) {
      menuHive.toppingDetail!.removeWhere((element) => element.idDetail == topping.idDetail);

      menuHive.topping!.removeWhere((element) => element == topping.idDetail);
      menuHive.totalHargaTopping = menuHive.totalHargaTopping! > 0 ? menuHive.totalHargaTopping! - topping.harga! : 0;
      detailMenuResult.data!.topping![index].isSelected = false;
      hitungTotalHarga();
    } else {
      ToppingHive newTopping = ToppingHive();
      newTopping.harga = topping.harga;
      newTopping.idDetail = topping.idDetail;
      newTopping.idMenu = topping.idMenu;
      newTopping.isSelected = true;
      newTopping.keterangan = topping.keterangan;
      newTopping.type = topping.type;

      menuHive.toppingDetail!.add(newTopping);
      menuHive.topping!.add(newTopping.idDetail!);
      menuHive.totalHargaTopping = menuHive.totalHargaTopping! + topping.harga!;
      detailMenuResult.data!.topping![index].isSelected = true;
      hitungTotalHarga();
    }
    update();
  }

  void onChangedCatatan(String note) {
    menuHive.catatan = note;
    update();
  }

  Future<void> addOrderMenu() async {
    OrderHive? tempOrderHive = orderBox.reactive.value!.values.firstOrNull;
    tempOrderHive?.menu?.add(menuHive);
    log(tempOrderHive.toString());
    tempOrderHive?.totalBayar = tempOrderHive.totalBayar! + menuHive.harga!;
    tempOrderHive?.menu?.map((e) => log(e.nama)).toList();

    log('SEBELUM MENYIMPAN');
    HiveServices.addOrderMenu(tempOrderHive ?? OrderHive());

    log('SESUDAH MENYIMPAN');
    log('${tempOrderHive?.menu?.length}');
    if (tempOrderHive?.menu?.length != null) {
      Get.back();
      Get.snackbar(
        "success_add_menu".tr,
        '${menuHive.jumlah} ${menuHive.nama} ${CurrencyFormat.convertToIdr(menuHive.harga, 2)} ',
      );
      update();
      Get.toNamed(AppRoutes.pesanan);
    } else {}

    menuHive = MenuHive();
    menuHive.nama = menu.nama ?? "";
    menuHive.gambar = menu.foto ?? "";
    menuHive.harga = menu.harga ?? 0;
    menuHive.id_menu = menu.idMenu ?? 0;
    menuHive.jumlah = 1;
    menuHive.level = 0;
    menuHive.kategori = menu.kategori ?? "";
    update();
  }

  @override
  void onInit() {
    log('ON INIT DETAIL MENU CONTROLLER');
    log("DETAIL MENU  : ${Get.arguments['id_menu']}");
    detailMenuRes(idMenu: Get.arguments['id_menu']);

    super.onInit();
  }
}
