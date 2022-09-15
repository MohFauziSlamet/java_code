// ignore_for_file: avoid_print, invalid_use_of_protected_member

import 'dart:developer';

import 'package:get/get.dart';
import 'package:java_code/config/routes/app_routes.dart';
import 'package:java_code/constant/core/api_const.dart';
import 'package:java_code/modules/features/home/repositories/home_repository.dart';
import 'package:flutter/material.dart';
import 'package:java_code/modules/models/all_menu_res/data_menu.dart';
import 'package:java_code/modules/models/all_promo_res/data_promo.dart';

enum Kategori {
  all,
  makanan,
  snack,
  minuman,
}

class HomeController extends GetxController {
  static HomeController get to => Get.find();

  /// RxString UNTUK STATUS KONDISI DARI GET_ALL_MENU
  /// DIGUNAKAN UNTUK PENGKONDISIAN PADA VIEW
  RxString loading = 'loading'.obs;

  /// RxString UNTUK STATUS KONDISI DARI GET_ALL_PROMO
  /// DIGUNAKAN UNTUK PENGKONDISIAN PADA VIEW
  RxString loadingPromo = 'loading'.obs;

  /// TEXTEDITING CONTROLLER UNTUK PENCARIAN
  Rx<TextEditingController> controllerPencarian = TextEditingController().obs;

  /// MEMANGGIL CLASS HOMEREPOSITORY UNTUK MENGGUNAKAN GET_ALL_MENU
  HomeRepository homeRepository = HomeRepository();

  /// RXLIST ALL MENU
  RxList<DataMenu> listAllMenu = <DataMenu>[].obs;

  /// RXLIST MENU PESANAN
  RxList<DataMenu> listMenuInOrder = <DataMenu>[].obs;

  /// RXLIST ALL PROMO
  RxList<DataPromo> listAlLPromo = <DataPromo>[].obs;

  /// MEMBUAT GETTER UNTUK MENDAMPILKAN LIST MENU SESUAI DENGAN KEBUTUHAN
  RxList<DataMenu> get listMakanan => filteringMenuWithSearch(kategori.value);
  RxList<DataMenu> get listSnack => filteringMenuWithSearch(kategori.value);
  RxList<DataMenu> get listMinuman => filteringMenuWithSearch(kategori.value);
  RxList<DataMenu> get listAllMenuRes =>
      filteringMenuWithSearch(kategori.value);

  /// LIST PENAMAAN TAB MENU
  RxList tabMenu = [
    'Semua Menu',
    'Makanan',
    'Snack',
    'Minuman',
  ].obs;

  /// TAB INDEX MENU
  RxInt index = 0.obs;
  RxList<String> tabMenuKategori = [
    'all',
    'makanan',
    'snack',
    'minuman',
  ].obs;

  /// KATEGORI UNTUK PENCARIAN
  RxString kategori = ''.obs;

  RxString searchValue = ''.obs;

  /// =============== CHANGE PAGE ===============
  RxInt pageIndex = 0.obs;
  void changePage({required int index}) async {
    pageIndex.value = index;
  }

  /// =============== GET ALL MENU ===============
  Future<void> getAllMenu() async {
    await homeRepository.getAllMenu().then((value) {
      // ignore: prefer_is_empty
      if (value.data?.length == 0 || value.data == null) {
        /// SUKSES NAMUN TIDAK MENDAPATKAN DATA
        loading.value = 'empty';
        return [];
      } else if (value.statusCode == 200) {
        /// SUKSES DAN MENDAPATKAN DATA
        loading.value = 'sukses';
        listAllMenu.value = value.data!;
      } else {
        loading.value = 'error';
        print('Debug HomeController ln-68');
        print('[GET - ${ApiConst.getAllMenuURL}] ERROR ${value.statusCode}');
      }
    });
  }

  /// =============== GET ALL PROMO ===============
  Future<void> getAllPromo() async {
    await homeRepository.getAllPromo().then((value) {
      // ignore: prefer_is_empty
      if (value.data?.length == 0 || value.data == null) {
        /// SUKSES NAMUN TIDAK MENDAPATKAN DATA
        loadingPromo.value = 'empty';
        return [];
      } else if (value.statusCode == 200) {
        /// SUKSES DAN MENDAPATKAN DATA
        loadingPromo.value = 'sukses';
        listAlLPromo.value = value.data!;
      } else {
        loadingPromo.value = 'error';
        log('Debug HomeController ln-68');
        log('[GET - ${ApiConst.getAllPromo}] ERROR ${value.statusCode}');
      }
    });
  }

  RxList<DataMenu> filteringMenuWithSearch(String category) {
    if (category == 'all') {
      listAllMenu.value.sort(
        (a, b) {
          if (a.kategoriWeight - b.kategoriWeight != 0) {
            return a.kategoriWeight - b.kategoriWeight;
          }
          return b.kategoriWeight - a.kategoriWeight;
        },
      );

      return listAllMenu
          .where((e) => e.nama!.toLowerCase().contains(searchValue.value))
          .toList()
          .obs;
    }
    return listAllMenu
        .where((e) =>
            e.kategori == category &&
            e.nama!.toLowerCase().contains(searchValue.value))
        .toList()
        .obs;
  }

  /// INCREMENT ORDER
  void incrementOrder({required int idMenu}) {
    /// JIKA PERTAMA KALI MENAMBAHKAN ORDER , AKAN DI ROUTING KE DETAIL MENU
    if (getMenuByIdMenu(idMenu: idMenu)[0].count == 0) {
      Get.toNamed(AppRoutes.detailMenu, arguments: {
        'id_menu': idMenu, // DIPAKAI DI DETAIL MENU CONTROLLER LANGSUNG
      });
    }

    /// MENGUBAH CURRRENT PADA LISTALLMENU
    DataMenu current = listAllMenu.where((e) => e.idMenu == idMenu).toList()[0];
    current.count = current.count! + 1;

    // /// MENAMBAHKAN PADA KERANJANG
    // // CEK MENU SUDAH ADA DI DALAM KERANJANG LIST
    // if (listMenuInOrder.isEmpty) {
    //   // pertama kali menabahkan
    //   // belum ada menu => menambahkan menu baru
    //   listMenuInOrder.add(current);
    //   update();
    //   log('PERTAMA KALI MENAMBAHKAN : ${listMenuInOrder.length}');
    // } else if (listMenuInOrder
    //     .where((e) => e.idMenu == idMenu)
    //     .toList()
    //     .isEmpty) {
    //   // menambahkan menu baru kedalam keranjang yang berbeda dari menu sebelumnya
    //   update();
    //   log('CEK BUG');
    //   listMenuInOrder.add(current);
    //   log('MENAMBAHKAN MENU LAIN : ${listMenuInOrder.length}');
    // } else {
    //   // sudah ada menu , hanya menambahkan jumlah count
    //   var existMenu =
    //       listMenuInOrder.where((e) => e.idMenu == idMenu).toList()[0];
    //   existMenu.count = existMenu.count!;
    //   update();
    //   log('${existMenu.nama} - ${existMenu.count} ');
    //   log('MENAMBAHKAN COUNT SAJA : ${listMenuInOrder.length}');
    // }
    // log('LIST PESANAN : ${listMenuInOrder.toJson().toString()}');
    update();
  }

  /// DECREMENT ORDER
  void decrementOrder({required int idMenu}) {
    // if (listAllMenu.where((e) => e.idMenu == idMenu).toList()[0].count != 0) {
    /// MENGURANGI PADA LIST ALL MENU
    DataMenu current = listAllMenu.where((e) => e.idMenu == idMenu).toList()[0];
    current.count = current.count! - 1;
    // log('DECREMENT NAMA MENU : ${listAllMenu.where((e) => e.idMenu == idMenu).toList()[0].nama}');
    // log('DECREMENT IDMENU MENU : ${listAllMenu.where((e) => e.idMenu == idMenu).toList()[0].idMenu}');
    // log('DECREMENT COUNT MENU : ${listAllMenu.where((e) => e.idMenu == idMenu).toList()[0].count}');

    // /// MENGURANGI PADA KERANGJANG
    // /// PASTI ADA MINIMAL 1 MENU
    // List<DataMenu> axistMenu =
    //     listMenuInOrder.where((e) => e.idMenu == idMenu).toList();

    // if (axistMenu[0].count == 1) {
    //   // JIKA YANG MAU DI HAPUS MEMILIKI AXIST COUNT HANYA 1
    //   log("JIKA YANG MAU DI HAPUS MEMILIKI AXIST COUNT HANYA 1");

    //   // DI HAPUS DARI LIST
    //   listMenuInOrder.remove(axistMenu[0]);
    // } else {
    //   // BERARTI AXIST MENU MEMILIKI COUNT LEBIH DARI 1
    //   axistMenu[0].count = axistMenu[0].count!;
    // }

    // log('LIST PESANAN ${listMenuInOrder.toJson()}');
    update();
    // }
  }

  RxList<DataMenu> getMenuByIdMenu({required int idMenu}) {
    return listAllMenu.where((e) => e.idMenu == idMenu).toList().obs;
  }

  /// MEMASUKAN PESANAN KEDALAM KERANJANG
  RxList<DataMenu> menuBucket = <DataMenu>[].obs;
  void insetMenuToBucketMenu({required int idMenu}) {
    if (getMenuByIdMenu(idMenu: idMenu)[0].count != 0) {
      var data =
          HomeController.to.listAllMenu.where((e) => e.count != 0).toList();
      log('BUCKET LENGHT : ${data.length}');
      // HomeController.to.listAllMenu.where((e) => e.count != 0).toList();
      menuBucket.value.addAll(
          HomeController.to.listAllMenu.where((e) => e.count != 0).toList());
      log('DETAIL MENU CONTROLLER');
      log('BUCKET LENGHT : ${menuBucket.length}');
      log('BUCKET LENGHT : ${listAllMenu.length}');
      log('BUCKET CONTAINS : ${menuBucket[0].nama} -  ${menuBucket[0].count}');

      Get.toNamed(AppRoutes.pesanan);
    }
  }

  @override
  void onInit() async {
    /// MENGAMBIL ALL DATA MENU
    await getAllMenu();

    /// MENGAMBIL ALL DATA PROMO
    await getAllPromo();

    filteringMenuWithSearch(kategori.value);
    listMakanan;
    listMinuman;
    listSnack;
    listAllMenuRes;

    /// KATEGORI AWAL KETIKA STARTING MENU
    kategori.value = tabMenuKategori[0];

    super.onInit();
  }
}
