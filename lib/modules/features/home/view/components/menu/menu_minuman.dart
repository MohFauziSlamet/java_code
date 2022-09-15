// ignore_for_file: invalid_use_of_protected_member, avoid_print

import 'package:flutter/material.dart';

import 'package:java_code/constant/core/assets_const.dart';
import 'package:java_code/modules/features/home/controllers/home_controller.dart';
import 'package:java_code/modules/features/home/view/components/item_menu.dart';
import 'package:java_code/modules/features/home/view/components/judul_menu.dart';
import 'package:get/get.dart';

class MenuMinuman extends StatelessWidget {
  const MenuMinuman({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      initState: (_) {},
      builder: (_) {
        return Column(
          children: [
            JudulMenu(
              iconMenu: AssetConts.iconMinuman,
              judulMenu: HomeController.to.listMinuman[0].kategori!,
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: HomeController.to.listMinuman.length,
              itemBuilder: (context, index) {
                return ItemMenu(
                  result: HomeController.to.listMinuman[index],
                  index: index,
                );
              },
            ),
          ],
        );
      },
    );
  }
}
