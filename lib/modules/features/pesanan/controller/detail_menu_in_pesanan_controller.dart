// ignore_for_file: avoid_print
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
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

class DetailMenuInPesananController extends GetxController {
  static DetailMenuInPesananController get to => Get.find();

  // CONTROLLER UNTUK MENAMBAKAN CATATAN
  TextEditingController catatanController = TextEditingController();

  int index = 0;
  int hargaAwal = 0;
  // MenuHive tempMenuHive = MenuHive();
  bool isUpdated = false;

  DetailMenuRepository detailMenuRepository = DetailMenuRepository();

  /// DATA DETAIL MENU
  DetailMenuRes? detailMenuResult = DetailMenuRes();
  MenuHive menuHive = MenuHive();
  RxBool isLoading = false.obs;
  Menu menu = Menu();

  // OrderHive orderBox = OrderHive();

  // var orderBox = Hive.box(HiveConst.orderHiveBox);

  /// DETAIL MENU CONTROLLER
  Future<void> detailMenuRes({required int idMenu}) async {
    var data = await detailMenuRepository.detailMenu(idMenu: idMenu);

    detailMenuResult = data;

    if (detailMenuResult != null) {
      menu = detailMenuResult!.data!.menu!;

      if (detailMenuResult!.data!.topping != null) {
        int index = 0;
        for (var element in detailMenuResult!.data!.topping!) {
          for (var checker in menuHive.toppingDetail!) {
            if (element.idDetail == checker.idDetail) {
              detailMenuResult!.data!.topping![index].isSelected = true;
            }
          }
          index += 1;
        }
      }
    }

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
    menuHive.harga = (menuHive.hargaAsli! * menuHive.jumlah!) +
        (menuHive.jumlah! * menuHive.hargaLevel!) +
        (menuHive.jumlah! * menuHive.totalHargaTopping!);

    // print("harga" + menuHive.harga.toString());
  }

// MEMILIH LEVEL
  void chooseLevel(Level level) {
    if (menuHive.level != level.idDetail) {
      if (menuHive.level != 0) {
        menuHive.hargaLevel = 0;
        hitungTotalHarga();
      }

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
    int isAny = menuHive.toppingDetail!
        .indexWhere((element) => element.idDetail == topping.idDetail);

    if (isAny >= 0) {
      menuHive.toppingDetail!
          .removeWhere((element) => element.idDetail == topping.idDetail);

      menuHive.topping!.removeWhere((element) => element == topping.idDetail);
      menuHive.totalHargaTopping = menuHive.totalHargaTopping! > 0
          ? menuHive.totalHargaTopping! - topping.harga!
          : 0;
      detailMenuResult!.data!.topping![index].isSelected = false;
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
      detailMenuResult!.data!.topping![index].isSelected = true;
      hitungTotalHarga();
    }
    update();
  }

  void onChangedCatatan(String note) {
    menuHive.catatan = note;
    update();
  }

  Future<void> addOrderMenu() async {
    // // print(orderBox.values.length.toString());
    OrderHive tempOrderHive =
        Hive.box<OrderHive>(HiveConst.orderHiveBox).values.first;
    tempOrderHive.menu?.add(menuHive);
    tempOrderHive.totalBayar = tempOrderHive.totalBayar! + menuHive.harga!;
    tempOrderHive.menu?.map((e) => log(e.nama)).toList();
    // print("harga Fix" + menuHive.harga.toString());

    log('SEBELUM MENYIMPAN');
    HiveServices.addOrderMenu(tempOrderHive);
    // orderBox.put(orderBox.keys.first, tempOrderHive);
    log('SESUDAH MENYIMPAN');
    log('${tempOrderHive.menu!.length}');
    Get.back();
    Get.snackbar(
      "success_add_menu".tr,
      '${menuHive.jumlah} ${menuHive.nama} ${CurrencyFormat.convertToIdr(menuHive.harga, 2)} ',
    );

    // print(orderBox.values.first.menu!.length.toString());
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

  /// GET MENU HIVE FOR DETAIL
  // List<MenuHive> getOderMenuHIve = <MenuHive>[];
  // void initHiveMenuDetail({required int idMenu}) {
  //   List<MenuHive> getOderMenuHIve = Hive.box<OrderHive>(HiveConst.orderHiveBox)
  //       .values
  //       .first
  //       .menu!
  //       .where((e) => e.id_menu == idMenu)
  //       .toList();
  //   log('MENGAMBIL DATA DARI HIVE BY ID MENU NAMA : ${getOderMenuHIve.first.nama}');
  //   log('MENGAMBIL DATA DARI HIVE BY ID MENU IDMENU : ${getOderMenuHIve.first.id_menu}');
  //   log('MENGAMBIL DATA DARI HIVE BY ID MENU JUMLAH : ${getOderMenuHIve.first.jumlah}');
  //   log('MENGAMBIL DATA DARI HIVE BY ID MENU DESK : ${getOderMenuHIve.first.deskripsi}');
  //   log('MENGAMBIL DATA DARI HIVE BY ID MENU HARGA ASLI : ${getOderMenuHIve.first.hargaAsli}');
  //   log('MENGAMBIL DATA DARI HIVE BY ID MENU HARGA ASLI X JUMLAH : ${getOderMenuHIve.first.harga}');
  // }
  // getMenuHive() async {
  //   isLoading = true.obs;
  //   update();
  //   MenuHive dataTemp = MenuHive()
  //     ..nama = getOderMenuHIve[0].nama
  //     ..catatan = getOderMenuHIve[0].catatan
  //     ..gambar = getOderMenuHIve[0].gambar
  //     ..harga = getOderMenuHIve[0].harga
  //     ..hargaAsli = getOderMenuHIve[0].hargaAsli
  //     ..hargaLevel = getOderMenuHIve[0].hargaLevel
  //     ..id_menu = getOderMenuHIve[0].id_menu
  //     ..jumlah = getOderMenuHIve[0].jumlah
  //     ..kategori = getOderMenuHIve[0].kategori
  //     ..keteranganLevel = getOderMenuHIve[0].keteranganLevel
  //     ..level = getOderMenuHIve[0].level
  //     ..topping = getOderMenuHIve[0].topping
  //     ..toppingDetail = getOderMenuHIve[0].toppingDetail
  //     ..totalHargaTopping = getOderMenuHIve[0].totalHargaTopping;
  //   tempMenuHive = dataTemp;
  //   menuHive = getOderMenuHIve[0];
  //   hargaAwal = menuHive.harga!;
  //   log('MENGAMBIL DATA DARI HIVE BY ID MENU NAMA : ${menuHive.nama}');
  //   log('MENGAMBIL DATA DARI HIVE BY ID MENU  ID MENU : ${menuHive.id_menu}');
  //   log('MENGAMBIL DATA DARI HIVE BY ID MENU JUMALH PESANAN : ${menuHive.jumlah}');
  //   log('MENGAMBIL DATA DARI HIVE BY ID MENU HARGA ASLI : ${menuHive.hargaAsli}');
  //   log('MENGAMBIL DATA DARI HIVE BY ID MENU HARGA X TOTAL : ${menuHive.harga}');
  //   // await getMenu(menuHive.id_menu!);
  //   isLoading = false.obs;
  //   update();
  // }

  simpanEditMenu() {
    OrderHive tempOrderHive =
        Hive.box<OrderHive>(HiveConst.orderHiveBox).values.first;
    tempOrderHive.menu![index] = menuHive;
    tempOrderHive.totalBayar =
        (tempOrderHive.totalBayar! - hargaAwal) + menuHive.harga!;
    HiveServices.addOrderMenu(tempOrderHive);
    // orderBox.put(orderBox.keys.first, tempOrderHive);
    Get.snackbar("edit_food_success_title".tr,
        "${menuHive.jumlah} ${menuHive.nama} Rp. ${menuHive.harga}");
    isUpdated = true;
    update();
  }

  @override
  void onInit() {
    log('GET ARGUMEN DETAIL PESANA : ${Get.arguments['result']}');
    menuHive = Get.arguments['result'];
    update();
    detailMenuRes(idMenu: menuHive.id_menu!);
    update();
    // initHiveMenuDetail(idMenu: menuHive.id_menu!);
    // getMenuHive();
    update();
    super.onInit();
  }
}
