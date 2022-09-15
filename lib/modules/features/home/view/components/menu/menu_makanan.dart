// ignore_for_file: invalid_use_of_protected_member, avoid_print
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:java_code/constant/core/assets_const.dart';
import 'package:java_code/modules/features/home/controllers/home_controller.dart';
import 'package:java_code/modules/features/home/view/components/item_menu.dart';
import 'package:java_code/modules/features/home/view/components/judul_menu.dart';

class MenuMakanan extends StatelessWidget {
  const MenuMakanan({
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
              iconMenu: AssetConts.iconMakanan,
              judulMenu: HomeController.to.listMakanan[0].kategori!,
            ),

            /// ITEM MENU MAKANAN
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: HomeController.to.listMakanan.length,
              itemBuilder: (context, index) {
                return ItemMenu(
                  result: HomeController.to.listMakanan[index],
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
