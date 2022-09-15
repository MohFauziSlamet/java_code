import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:java_code/config/themes/colours.dart';
import 'package:java_code/constant/core/assets_const.dart';
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

    // HomeController.to.getAllMenu();

    RxInt index = HomeController.to.pageIndex;
    return Scaffold(
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
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.sp), topRight: Radius.circular(30.sp)),
        child: Obx(
          () => BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Image.asset(
                  AssetConts.iconHome,
                  color: index.value == 0 ? Colours.white : null,
                ),
                label: "Beranda",
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  AssetConts.iconPesanan,
                  color: index.value == 1 ? Colours.white : null,
                ),
                label: "Pesanan",
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  AssetConts.iconProfile,
                  color: index.value == 2 ? Colours.white : null,
                ),
                label: "Profil",
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

// class DashboardView extends StatelessWidget {
//   const DashboardView({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Obx(
//         () => IndexedStack(
//           index: DashboardController.to.tabIndex.value,
//           children: const [
//             HomeView(),
//             OrderView(),
//             ProfileView(),
//           ],
//         ),
//       ),
//       bottomNavigationBar: ClipRRect(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
//         child: Obx(
//           () => BottomNavigationBar(
//             onTap: DashboardController.to.changeTabIndex,
//             currentIndex: DashboardController.to.tabIndex.value,
//             backgroundColor: AppColor.darkColor2,
//             selectedLabelStyle: Get.textTheme.labelSmall,
//             unselectedLabelStyle: Get.textTheme.labelSmall,
//             selectedItemColor: Colors.white,
//             unselectedItemColor: AppColor.greyColor2,
//             items: [
//               BottomNavigationBarItem(
//                 icon: Padding(
//                   padding: EdgeInsets.only(bottom: 5.r),
//                   child: SvgPicture.asset(
//                     AssetConst.iconHome,
//                     color: AppColor.greyColor2,
//                     height: 27.r,
//                     width: 27.r,
//                   ),
//                 ),
//                 activeIcon: Padding(
//                   padding: EdgeInsets.only(bottom: 5.r),
//                   child: SvgPicture.asset(
//                     AssetConst.iconHome,
//                     color: Colors.white,
//                     height: 27.r,
//                     width: 27.r,
//                   ),
//                 ),
//                 label: 'Home'.tr,
//               ),
//               BottomNavigationBarItem(
//                 icon: Padding(
//                   padding: EdgeInsets.only(bottom: 5.r),
//                   child: Obx(
//                     () => Badge(
//                       showBadge: OrderController.to.onGoingOrders.isNotEmpty,
//                       badgeColor: AppColor.blueColor,
//                       badgeContent: Text(
//                         OrderController.to.onGoingOrders.length.toString(),
//                         style: Get.textTheme.labelMedium!
//                             .copyWith(color: Colors.white),
//                       ),
//                       child: SvgPicture.asset(
//                         AssetConst.iconOrder,
//                         color: AppColor.greyColor2,
//                         height: 27.r,
//                         width: 27.r,
//                       ),
//                     ),
//                   ),
//                 ),
//                 activeIcon: Padding(
//                   padding: EdgeInsets.only(bottom: 5.r),
//                   child: Obx(
//                     () => Badge(
//                       showBadge: OrderController.to.onGoingOrders.isNotEmpty,
//                       badgeColor: AppColor.blueColor,
//                       badgeContent: Text(
//                         OrderController.to.onGoingOrders.length.toString(),
//                         style: Get.textTheme.labelMedium!
//                             .copyWith(color: Colors.white),
//                       ),
//                       child: SvgPicture.asset(
//                         AssetConst.iconOrder,
//                         color: Colors.white,
//                         height: 27.r,
//                         width: 27.r,
//                       ),
//                     ),
//                   ),
//                 ),
//                 label: 'Order'.tr,
//               ),
//               BottomNavigationBarItem(
//                 icon: Padding(
//                   padding: EdgeInsets.only(bottom: 5.r),
//                   child: SvgPicture.asset(
//                     AssetConst.iconProfile,
//                     color: AppColor.greyColor2,
//                     height: 27.r,
//                     width: 27.r,
//                   ),
//                 ),
//                 activeIcon: Padding(
//                   padding: EdgeInsets.only(bottom: 5.r),
//                   child: SvgPicture.asset(
//                     AssetConst.iconProfile,
//                     color: Colors.white,
//                     height: 27.r,
//                     width: 27.r,
//                   ),
//                 ),
//                 label: 'Profile'.tr,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
