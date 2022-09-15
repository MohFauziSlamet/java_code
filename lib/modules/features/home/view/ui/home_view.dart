// ignore_for_file: invalid_use_of_protected_member

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:java_code/config/routes/app_routes.dart';
import 'package:java_code/modules/features/detail_menu/controller/detail_menu_controller.dart';
import 'package:java_code/modules/features/home/view/components/image_diskon.dart';
import 'package:java_code/modules/features/home/view/components/item_menu.dart';
import 'package:java_code/modules/features/home/view/components/judul_menu.dart';
import 'package:java_code/modules/features/home/view/components/state_view_status_menu/empty_state_view.dart';
import 'package:java_code/modules/features/home/view/components/state_view_status_menu/error_state_view.dart';
import 'package:java_code/modules/features/home/view/components/state_view_status_menu/loading_state_view.dart';
import 'package:java_code/modules/features/home/view/components/state_view_status_promo/state_empty_promo.dart';
import 'package:java_code/modules/features/home/view/components/state_view_status_promo/state_error_promo.dart';
import '/modules/features/home/view/components/image_promo.dart';
import '/config/themes/colours.dart';
import '/constant/core/assets_const.dart';
import '/modules/features/home/controllers/home_controller.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    final Debouncer debounce =
        Debouncer(delay: const Duration(milliseconds: 1000));

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        backgroundColor: Colours.bgColors,
        body: Obx(
          () => Conditional.single(
            context: context,
            conditionBuilder: (context) =>
                HomeController.to.loading.value == 'loading',
            widgetBuilder: (context) => const LoadingStateView(),
            fallbackBuilder: (context) => SafeArea(
              child: ListView(
                children: [
                  /// APPBAR PENCARIAN
                  Material(
                    elevation: 2,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30.sp),
                      bottomRight: Radius.circular(30.sp),
                    ),
                    child: Container(
                      width: ScreenUtil().screenWidth,
                      height: 66.h,
                      decoration: BoxDecoration(
                        color: Colours.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30.sp),
                          bottomRight: Radius.circular(30.sp),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 25.sp, vertical: 11.sp),
                        child: TextField(
                          controller:
                              HomeController.to.controllerPencarian.value,
                          onChanged: (value) {
                            debounce(() {
                              HomeController.to.searchValue.value = value;
                            });
                          },
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 12.sp),
                            prefixIcon: SizedBox(
                              width: 26.h,
                              height: 26.h,
                              child: Image.asset(AssetConts.iconPencarian),
                            ),
                            hintText: "Pencarian",
                            hintStyle: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w600,
                              fontSize: 18.sp,
                              color: Colours.textGrey,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.sp),
                              borderSide:
                                  const BorderSide(color: Colours.green2),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 22.h),

                  /// TEXT PROMO
                  Container(
                    height: 21.h,
                    width: ScreenUtil().screenWidth,
                    margin: EdgeInsets.only(left: 25.sp),
                    child: Row(
                      children: [
                        Image.asset(AssetConts.iconPromo),
                        SizedBox(width: 9.w),
                        Text(
                          "Promo yang Tersedia",
                          style: GoogleFonts.montserrat(
                            color: Colours.darkGrey,
                            fontWeight: FontWeight.w700,
                            fontSize: 20.sp,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 21.h),

                  /// LOGO PROMO
                  Obx(() => ConditionalSwitch.single(
                        context: context,
                        valueBuilder: (context) =>
                            HomeController.to.loadingPromo.value,
                        caseBuilders: {
                          'empty': (context) => const EmptyStatePromoView(),
                          'error': (context) => const ErrorStatePromoView(),
                        },
                        fallbackBuilder: (context) {
                          return SizedBox(
                            height: 161.sp,
                            width: ScreenUtil().screenWidth,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: HomeController.to.listAlLPromo.length,
                              itemBuilder: (context, index) {
                                return ConditionalSwitch.single(
                                  context: context,
                                  valueBuilder: (context) => HomeController
                                      .to.listAlLPromo[index].type,
                                  caseBuilders: {
                                    'voucher': (context) => ImagePromo(
                                          resultPromo: HomeController
                                              .to.listAlLPromo[index],
                                        ),
                                  },
                                  fallbackBuilder: (context) => ImageDiskon(
                                    resultPromo:
                                        HomeController.to.listAlLPromo[index],
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      )),

                  const SizedBox(height: 20),

                  /// TAB MENU
                  Container(
                    height: 35,
                    width: ScreenUtil().screenWidth,
                    margin: const EdgeInsets.only(left: 25),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: HomeController.to.tabMenu.value.length,
                      itemBuilder: (context, index) {
                        return Obx(
                          () => InkWell(
                            onTap: () {
                              HomeController.to.index.value = index;
                              // MEMASUKAN KATEGORI UNTUK PENCARIAN YANG AKTIF
                              HomeController.to.kategori.value = HomeController
                                  .to.tabMenuKategori.value[index];
                              log('TAB : ');
                              log(HomeController
                                  .to.tabMenuKategori.value[index]);
                              log('kategori di controller: ');
                              log(HomeController.to.kategori.value);
                            },
                            child: Container(
                              height: 35,
                              padding: EdgeInsets.symmetric(
                                  vertical: 5.sp, horizontal: 14.sp),
                              margin: const EdgeInsets.only(right: 13),
                              decoration: BoxDecoration(
                                color: HomeController.to.index.value == index
                                    ? Colours.darkGrey
                                    : Colours.green2,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Row(
                                children: [
                                  ConditionalSwitch.single(
                                    context: context,
                                    valueBuilder: (context) => index,
                                    caseBuilders: {
                                      0: (context) =>
                                          Image.asset(AssetConts.iconSemuaMenu),
                                      1: (context) =>
                                          Image.asset(AssetConts.iconMakanan),
                                      2: (context) =>
                                          Image.asset(AssetConts.iconMakanan),
                                    },
                                    fallbackBuilder: (context) =>
                                        Image.asset(AssetConts.iconMinuman),
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Text(
                                    HomeController.to.tabMenu.value[index],
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                      color: Colours.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  /// PENGKONDISIAN TAMPILAN KETIKA LOADING, EMPTY, ERROR, SUKSES
                  ConditionalSwitch.single(
                    context: context,
                    valueBuilder: (context) => HomeController.to.loading,
                    caseBuilders: {
                      'empty': (context) => const EmptyStateView(),
                      'error': (context) => const ErrorStateView(),
                    },
                    fallbackBuilder: (context) => Container(
                      // LIST MENU
                      //  TAMPILAN SUKSES GET ALL MENU
                      margin: EdgeInsets.symmetric(
                          horizontal: 25.sp, vertical: 11.sp),
                      child: Column(
                        children: ConditionalSwitch.list(
                          context: context,
                          valueBuilder: (context) => HomeController.to.kategori,
                          caseBuilders: {
                            'all': (context) => [
                                  // LOGIC VIEW
                                  // logic di view :
                                  // tampilkan judul makanan
                                  // tampilkan list makanan
                                  // jika kategori makanan sudah di tampilkan semua
                                  // tampilkan judul snack
                                  // tampilkan list snack
                                  // jika kategori snack sudah di tampilkan semua
                                  // tampilkan judul minuman
                                  // tampilkan list minuman

                                  Obx(
                                    () => Column(
                                      children: [
                                        JudulMenu(
                                            iconMenu: AssetConts.iconMakanan,
                                            judulMenu: 'Makanan'),
                                        ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: HomeController
                                              .to.listAllMenuRes
                                              .where((e) =>
                                                  e.kategori == 'makanan')
                                              .toList()
                                              .length,
                                          itemBuilder: (context, index) {
                                            log(' PANJANG MAKANAN : ${HomeController.to.listAllMenuRes.where((e) => e.kategori == 'makanan').toList().length}');
                                            return ItemMenu(
                                                result: HomeController
                                                    .to.listAllMenuRes
                                                    .where((e) =>
                                                        e.kategori == 'makanan')
                                                    .toList()[index],
                                                index: index);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  Obx(
                                    () => Column(
                                      children: [
                                        JudulMenu(
                                            iconMenu: AssetConts.iconMakanan,
                                            judulMenu: 'Snack'),
                                        ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: HomeController
                                              .to.listAllMenuRes
                                              .where(
                                                  (e) => e.kategori == 'snack')
                                              .toList()
                                              .length,
                                          itemBuilder: (context, index) {
                                            log(' PANJANG SNACK : ${HomeController.to.listAllMenuRes.where((e) => e.kategori == 'snack').toList().length}');
                                            return ItemMenu(
                                                result: HomeController
                                                    .to.listAllMenuRes
                                                    .where((e) =>
                                                        e.kategori == 'snack')
                                                    .toList()[index],
                                                index: index);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  Obx(
                                    () => Column(
                                      children: [
                                        JudulMenu(
                                            iconMenu: AssetConts.iconMakanan,
                                            judulMenu: 'Minuman'),
                                        ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: HomeController
                                              .to.listAllMenuRes
                                              .where((e) =>
                                                  e.kategori == 'minuman')
                                              .toList()
                                              .length,
                                          itemBuilder: (context, index) {
                                            log(' PANJANG Minuman : ${HomeController.to.listAllMenuRes.where((e) => e.kategori == 'minuman').toList().length}');
                                            return ItemMenu(
                                                result: HomeController
                                                    .to.listAllMenuRes
                                                    .where((e) =>
                                                        e.kategori == 'minuman')
                                                    .toList()[index],
                                                index: index);
                                          },
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                            'makanan': (context) => [
                                  JudulMenu(
                                      iconMenu: AssetConts.iconMakanan,
                                      judulMenu: 'Makanan'),
                                  ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount:
                                        HomeController.to.listMakanan.length,
                                    itemBuilder: (context, index) {
                                      log(' PANJANG MAKANAN : ${HomeController.to.listMakanan.length}');
                                      return ItemMenu(
                                          result: HomeController
                                              .to.listMakanan[index],
                                          index: index);
                                    },
                                  ),
                                ],
                            'snack': (context) => [
                                  JudulMenu(
                                      iconMenu: AssetConts.iconMakanan,
                                      judulMenu: 'Snack'),
                                  ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount:
                                        HomeController.to.listSnack.length,
                                    itemBuilder: (context, index) {
                                      log(' PANJANG SNACK : ${HomeController.to.listSnack.length}');
                                      return ItemMenu(
                                          result: HomeController
                                              .to.listSnack[index],
                                          index: index);
                                    },
                                  ),
                                ]
                          },
                          fallbackBuilder: (context) => [
                            JudulMenu(
                                iconMenu: AssetConts.iconMinuman,
                                judulMenu: 'Minuman'),
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: HomeController.to.listMinuman.length,
                              itemBuilder: (context, index) {
                                log(' PANJANG MINUMAN : ${HomeController.to.listMinuman.length}');
                                return ItemMenu(
                                    result:
                                        HomeController.to.listMinuman[index],
                                    index: index);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: Obx(
          () => Conditional.single(
            context: context,
            conditionBuilder: (context) => HomeController.to.menuBucket.isEmpty,
            widgetBuilder: (context) => const SizedBox(),
            fallbackBuilder: (context) => Stack(
              children: [
                FloatingActionButton(
                  onPressed: () {
                    Get.toNamed(AppRoutes.pesanan);
                  },
                  backgroundColor: Colours.green2,
                  child: Image.asset(
                    AssetConts.iconKeranjang,
                    color: Colours.white,
                    width: 25,
                  ),
                ),
                Positioned(
                  left: 41.sp,
                  bottom: 37.sp,
                  child: Container(
                    height: 22.w,
                    width: 22.w,
                    decoration: BoxDecoration(
                      color: Colours.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colours.green2),
                    ),
                    child: Center(
                      child: Text(
                        HomeController.to.menuBucket.length.toString(),
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Colours.green2,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // floatingActionButton: Stack(
        //   children: [
        //     FloatingActionButton(
        //       onPressed: () {
        //         Get.toNamed(AppRoutes.pesanan);
        //       },
        //       backgroundColor: Colours.green2,
        //       child: Image.asset(
        //         AssetConts.iconKeranjang,
        //         color: Colours.white,
        //         width: 25,
        //       ),
        //     ),
        //     Positioned(
        //       left: 41.sp,
        //       bottom: 37.sp,
        //       child: Container(
        //         height: 22.w,
        //         width: 22.w,
        //         decoration: BoxDecoration(
        //           color: Colours.white,
        //           borderRadius: BorderRadius.circular(20),
        //           border: Border.all(color: Colours.green2),
        //         ),
        //         child: Center(
        //           child: Text(
        //             '1',
        //             style: GoogleFonts.montserrat(
        //               fontWeight: FontWeight.w600,
        //               fontSize: 14,
        //               color: Colours.green2,
        //             ),
        //           ),
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
