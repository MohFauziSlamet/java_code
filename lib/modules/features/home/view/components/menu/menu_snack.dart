// ignore_for_file: invalid_use_of_protected_member, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:java_code/constant/core/assets_const.dart';
import 'package:java_code/modules/features/home/controllers/home_controller.dart';
import 'package:java_code/modules/features/home/view/components/item_menu.dart';
import 'package:java_code/modules/features/home/view/components/judul_menu.dart';

class MenuSnack extends StatelessWidget {
  const MenuSnack({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        initState: (_) {},
        builder: (_) {
          return Column(children: [
            // JUDUL MENU
            JudulMenu(
              iconMenu: AssetConts.iconMakanan,
              judulMenu: HomeController.to.listSnack[0].kategori!,
            ),
            // ITEM MENU SNACK
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: HomeController.to.listSnack.length,
              itemBuilder: (context, index) {
                return ItemMenu(
                  result: HomeController.to.listSnack[index],
                  index: index,
                );
              },
            ),
          ]);
        });
  }
}
