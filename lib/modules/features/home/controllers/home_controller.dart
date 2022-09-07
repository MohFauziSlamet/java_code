// ignore_for_file: avoid_print, invalid_use_of_protected_member

import 'package:get/get.dart';
import 'package:java_code/modules/features/home/repositories/home_repository.dart';
import 'package:java_code/modules/models/all_menu_res/all_menu_res.dart';
import 'package:flutter/material.dart';
import 'package:java_code/modules/models/all_menu_res/datum.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();

  /// TEXTEDITING CONTROLLER
  TextEditingController controllerPencarian = TextEditingController();

  ///
  ///
  HomeRepository homeRepository = HomeRepository();

  /// RXLIST ALL MENU
  RxList<Datum> listAllMenu = <Datum>[].obs;
  RxList<Datum> listMenuMakanan = <Datum>[].obs;
  RxList<Datum> listMenuMinuman = <Datum>[].obs;
  RxList<Datum> listMenuSnack = <Datum>[].obs;

  Rx<AllMenuRes> allMenuRes = Rx<AllMenuRes>(AllMenuRes());

  /// LIST TAB MENU
  RxList tabMenu = [
    'Semua Menu',
    'Makanan',
    'Snack',
    'Minuman',
  ].obs;

  /// TAB INDEX MENU
  RxInt index = 0.obs;

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
        return [];
      } else {
        for (var element in value.data!) {
          listAllMenu.add(element);

          listAllMenu.refresh();
        }

        for (var element in value.data!) {
          listAllMenu.add(element);

          listAllMenu.refresh();
        }
        for (var element in value.data!) {
          listMenuMakanan.addIf(element.kategori == 'makanan', element);

          listMenuMakanan.refresh();
        }
        for (var element in value.data!) {
          listMenuMinuman.addIf(element.kategori == 'minuman', element);
          listMenuMinuman.refresh();
        }
        for (var element in value.data!) {
          listMenuSnack.addIf(element.kategori == 'snack', element);
          listMenuSnack.refresh();
        }
      }
    });
    // print('Debug Homecontroller');
    // print('LIST MENU PERTAMA : ${listAllMenu.value[0]}');
    // print('LIST MENU Makanan : ${listMenuMakanan.value[0].kategori}');
    // print('LIST MENU Minuman : ${listMenuMinuman.value[0].kategori}');
    // print('LIST MENU Snack : ${listMenuSnack.value[0].kategori}');
  }

  /// =============== PENCARI MENU ===============
  ///
  // void pencarianMenu(String query) {
  //   List<Datum> listAll = listAllMenu.value.where((datum) {
  //     final namaMenu = datum.nama!.toLowerCase();
  //     final input = query.toLowerCase();

  //     return namaMenu.contains(input, 0);
  //   }).toList();
  //   if (query.isEmpty || query == '') {
  //     listAllMenu;
  //     listAllMenu.refresh();
  //     getAllMenu();
  //   } else {
  //     listAllMenu.value = listAll;
  //     listAllMenu.refresh();
  //   }
  // }

  // void pencarianMenu(String query) {
  //   // String element = tabMenu.value[0].toString();
  //   // print(element);
  //   //listAllMenu[0].kategori
  //   switch (tabMenu.value.toString()) {
  //     case 'Semua Menu':
  //       List<Datum> listAll = listAllMenu.value.where((datum) {
  //         final namaMenu = datum.nama!.toLowerCase();
  //         final input = query.toLowerCase();

  //         return namaMenu.contains(input, 0);
  //       }).toList();
  //       if (query.isEmpty || query == '') {
  //         listAllMenu;
  //         listAllMenu.refresh();
  //         getAllMenu();
  //       } else {
  //         listAllMenu.value = listAll;
  //         listAllMenu.refresh();
  //       }
  //       break;
  //     case 'Makanan':
  //       List<Datum> listMakan = listMenuMakanan.value.where((datum) {
  //         final namaMenu = datum.nama!.toLowerCase();

  //         return namaMenu.contains(query.toLowerCase(), 0);
  //       }).toList();
  //       listMenuMakanan.value = listMakan;
  //       if (query.isEmpty || query == '') {
  //         getAllMenu();
  //         listMenuMakanan;
  //         listMenuMakanan.refresh();
  //       } else {
  //         listMenuMakanan.value = listMakan;
  //         listMenuMakanan.refresh();
  //       }
  //       // listMenuMakanan.refresh();
  //       break;
  //     case 'Snack':
  //       List<Datum> listSnack = listMenuSnack.value.where(
  //         (datum) {
  //           final namaMenu = datum.nama!.toLowerCase();
  //           final input = query.toLowerCase();

  //           return namaMenu.contains(input, 0);
  //         },
  //       ).toList();

  //       if (query.isEmpty || query == '') {
  //         getAllMenu();
  //         listMenuSnack;
  //         listMenuSnack.refresh();
  //       } else {
  //         listMenuSnack.value = listSnack;
  //         listMenuSnack.refresh();
  //       }

  //       break;
  //     case 'Minuman':
  //       List<Datum> listMinuman = listMenuMinuman.value.where((datum) {
  //         final namaMenu = datum.nama!.toLowerCase();
  //         final input = query.toLowerCase();

  //         return namaMenu.contains(input, 0);
  //       }).toList();
  //       listMenuMinuman.value = listMinuman;
  //       if (query.isEmail || query == '') {
  //         getAllMenu();
  //         listMenuMinuman;
  //         listMenuMinuman.refresh();
  //       } else {
  //         listMenuMinuman.value = listMinuman;
  //         listMenuMinuman.refresh();
  //       }

  //       break;

  //     default:
  //   }
  // }

  // void pencarianMenu(String query, int index) {
  //   switch (index) {
  //     case 0:
  //       print('object 0');
  //       List<Datum> listAll = listAllMenu.value.where((datum) {
  //         final namaMenu = datum.nama!.toLowerCase();
  //         final input = query.toLowerCase();

  //         return namaMenu.contains(input, 0);
  //       }).toList();
  //       if (query.isEmpty || query == '') {
  //         listAll.clear();
  //         getAllMenu();
  //         listAllMenu;
  //         listAllMenu.refresh();
  //       } else {
  //         listAllMenu.value = listAll;
  //         listAllMenu.refresh();
  //       }
  //       break;
  //     case 1:
  //       print('object 1');
  //       List<Datum> listMakan = listMenuMakanan.value.where((datum) {
  //         final namaMenu = datum.nama!.toLowerCase();

  //         return namaMenu.contains(query.toLowerCase(), 0);
  //       }).toList();
  //       listMenuMakanan.value = listMakan;
  //       if (query.isEmpty || query == '') {
  //         listMakan.clear();
  //         getAllMenu();
  //         listMenuMakanan;
  //         listMenuMakanan.refresh();
  //       } else {
  //         listMenuMakanan.value = listMakan;
  //         listMenuMakanan.refresh();
  //       }
  //       // listMenuMakanan.refresh();
  //       break;
  //     case 2:
  //       print('object 2');
  //       List<Datum> listSnack = listMenuSnack.value.where(
  //         (datum) {
  //           final namaMenu = datum.nama!.toLowerCase();
  //           final input = query.toLowerCase();

  //           return namaMenu.contains(input, 0);
  //         },
  //       ).toList();

  //       if (query.isEmpty || query == '') {
  //         listSnack.clear();
  //         getAllMenu();
  //         listMenuSnack;
  //         listMenuSnack.refresh();
  //       } else {
  //         listMenuSnack.value = listSnack;
  //         listMenuSnack.refresh();
  //       }
  //       break;
  //     case 3:
  //       print('object 3');
  //       List<Datum> listMinuman = listMenuMinuman.value.where((datum) {
  //         final namaMenu = datum.nama!.toLowerCase();
  //         final input = query.toLowerCase();

  //         return namaMenu.contains(input, 0);
  //       }).toList();
  //       listMenuMinuman.value = listMinuman;
  //       if (query.isEmail || query == '') {
  //         listMinuman.clear();
  //         getAllMenu();
  //         listMenuMinuman;
  //         listMenuMinuman.refresh();
  //       } else {
  //         listMenuMinuman.value = listMinuman;
  //         listMenuMinuman.refresh();
  //       }

  //       break;

  //     default:
  //   }
  // }
  void pencarianMenu(String query, int index) {
    switch (index) {
      case 0:
        print('object 0');
        List<Datum> listAll = listAllMenu.value.where((datum) {
          final namaMenu = datum.nama!.toLowerCase();
          final input = query.toLowerCase();

          return namaMenu.contains(input, 0);
        }).toList();
        if (query.isEmpty || query == '') {
          listAllMenu.clear();
          getAllMenu();
          listAllMenu;
          listAllMenu.refresh();
        } else {
          listAllMenu.value = listAll;
          listAllMenu.refresh();
        }
        break;
      case 1:
        print('object 1');
        List<Datum> listMakan = listMenuMakanan.value.where((datum) {
          final namaMenu = datum.nama!.toLowerCase();

          return namaMenu.contains(query.toLowerCase(), 0);
        }).toList();
        listMenuMakanan.value = listMakan;
        if (query.isEmpty || query == '') {
          listMenuMakanan.clear();
          getAllMenu();
          listMenuMakanan;
          listMenuMakanan.refresh();
        } else {
          listMenuMakanan.value = listMakan;
          listMenuMakanan.refresh();
        }
        // listMenuMakanan.refresh();
        break;
      case 2:
        print('object 2');
        List<Datum> listSnack = listMenuSnack.value.where(
          (datum) {
            final namaMenu = datum.nama!.toLowerCase();
            final input = query.toLowerCase();

            return namaMenu.contains(input, 0);
          },
        ).toList();

        if (query.isEmpty || query == '') {
          listMenuSnack.clear();
          getAllMenu();
          listMenuSnack;
          listMenuSnack.refresh();
        } else {
          listMenuSnack.value = listSnack;
          listMenuSnack.refresh();
        }
        break;
      case 3:
        print('object 3');
        List<Datum> listMinuman = listMenuMinuman.value.where((datum) {
          final namaMenu = datum.nama!.toLowerCase();
          final input = query.toLowerCase();

          return namaMenu.contains(input, 0);
        }).toList();
        listMenuMinuman.value = listMinuman;
        if (query.isEmail || query == '') {
          listMenuMinuman.clear();
          getAllMenu();
          listMenuMinuman;
          listMenuMinuman.refresh();
        } else {
          listMenuMinuman.value = listMinuman;
          listMenuMinuman.refresh();
        }

        break;

      default:
    }
  }

  @override
  void onInit() async {
    await getAllMenu();

    super.onInit();
  }
}
