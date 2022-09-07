// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:java_code/constant/core/assets_const.dart';
import 'package:java_code/modules/features/home/controllers/home_controller.dart';
import 'package:java_code/modules/features/home/view/components/item_menu.dart';
import 'package:java_code/modules/features/home/view/components/judul_menu.dart';
import 'package:java_code/modules/models/all_menu_res/datum.dart';

class MenuSnack extends StatelessWidget {
  const MenuSnack({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return Column(
      children: [
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 1,
          itemBuilder: (context, index) {
            Datum data = HomeController.to.listMenuSnack.value[index];
            return JudulMenu(
              iconMenu: AssetConts.iconMakanan,
              judulMenu: data.kategori!,
            );
          },
        ),

        /// ITEM MENU SNACK
        Obx(
          () => ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: HomeController.to.listMenuSnack.length,
            itemBuilder: (context, index) {
              Datum dataSnack = HomeController.to.listMenuSnack.value[index];

              return ItemMenu(
                result: dataSnack,
                index: index,
              );
            },
          ),
        ),
      ],
    );
  }
}
