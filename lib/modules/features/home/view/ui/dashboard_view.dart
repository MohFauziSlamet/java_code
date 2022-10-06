import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:java_code/config/themes/colours.dart';
import 'package:java_code/constant/core/assets_const.dart';
import 'package:java_code/modules/features/checkout/controller/checkout_controller.dart';
import 'package:java_code/modules/features/checkout/view/ui/checkout_view.dart';
import 'package:java_code/modules/features/home/controllers/home_controller.dart';
import 'package:java_code/modules/features/home/view/ui/home_view.dart';
import 'package:java_code/modules/features/no_connecntion/view/ui/no_connection_view.dart';
import 'package:java_code/modules/features/profile/view/ui/profile_view.dart';
import 'package:java_code/modules/global_controllers/check_connection_controller.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    Get.put(CheckoutController());

    RxInt index = HomeController.to.pageIndex;
    return Scaffold(
      backgroundColor: Colours.bgColors,
      body: Obx(
        () => ConnectionManagerController.to.connectionType.value != 0
            ? IndexedStack(
                index: HomeController.to.pageIndex.value,
                children: const [
                  HomeView(),
                  CheckoutView(),
                  ProfileView(),
                ],
              )
            : const NoConnectionView(),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(30.sp), topRight: Radius.circular(30.sp)),
        child: Obx(
          () => BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Image.asset(
                  AssetConts.iconHome,
                  color: index.value == 0 ? Colours.white : null,
                ),
                label: "home".tr,
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  AssetConts.iconPesanan,
                  color: index.value == 1 ? Colours.white : null,
                ),
                label: "order".tr,
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  AssetConts.iconProfile,
                  color: index.value == 2 ? Colours.white : null,
                ),
                label: "profil".tr,
              ),
            ],
            currentIndex: HomeController.to.pageIndex.value,
            selectedItemColor: Colours.white,
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: true,
            backgroundColor: Colours.darkBlack,
            onTap: (index) {
              HomeController.to.changePage(index: index);
            },
          ),
        ),
      ),
    );
  }
}
