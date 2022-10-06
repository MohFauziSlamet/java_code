// ignore_for_file: avoid_print, invalid_use_of_protected_member

import 'dart:developer';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:java_code/config/routes/app_routes.dart';
import 'package:java_code/constant/core/api_const.dart';
import 'package:java_code/constant/core/hive_const.dart';
import 'package:java_code/modules/features/home/repositories/home_repository.dart';
import 'package:flutter/material.dart';
import 'package:java_code/modules/models/all_menu_res/data_menu.dart';
import 'package:java_code/modules/models/all_promo_res/data_promo.dart';
import 'package:java_code/modules/models/hive/menu_hive_model.dart';
import 'package:java_code/modules/models/hive/order_hive_model.dart';

enum Kategori {
  all,
  makanan,
  snack,
  minuman,
}

class HomeController extends GetxController {
  static HomeController get to => Get.find();
  var languageBox = Hive.box(HiveConst.languageHiveBox);
  List<MenuHive>? hiveMenu = <MenuHive>[].obs;

  Future<void> getHiveMenuRes() async {
    hiveMenu = Hive.box<OrderHive>(HiveConst.orderHiveBox).values.first.menu ?? [];
    update();
  }

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
  RxList<DataMenu> get listAllMenuRes => filteringMenuWithSearch(kategori.value);

  /// LIST PENAMAAN TAB MENU
  RxList tabMenu = [
    'all_menu'.tr,
    'food'.tr,
    'snack'.tr,
    'beverage'.tr,
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

      return listAllMenu.where((e) => e.nama!.toLowerCase().contains(searchValue.value)).toList().obs;
    }
    return listAllMenu.where((e) => e.kategori == category && e.nama!.toLowerCase().contains(searchValue.value)).toList().obs;
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
    update();
  }

  /// DECREMENT ORDER
  void decrementOrder({required int idMenu}) {
    /// MENGURANGI PADA LIST ALL MENU
    DataMenu current = listAllMenu.where((e) => e.idMenu == idMenu).toList()[0];
    current.count = current.count! - 1;

    update();
  }

  RxList<DataMenu> getMenuByIdMenu({required int idMenu}) {
    return listAllMenu.where((e) => e.idMenu == idMenu).toList().obs;
  }

  Future<void> cekLanguage() async {
    String? selectedLanguage = languageBox.get("country_id");
    if (selectedLanguage == null) {
      languageBox.put("country_id", Get.deviceLocale?.languageCode ?? "en");
      return;
    }
    return;
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

    ///
    cekLanguage();
    if (Hive.box<OrderHive>(HiveConst.orderHiveBox).values.first.menu != null) {
      await getHiveMenuRes();
      update();
    }

    super.onInit();
  }
}
