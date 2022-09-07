// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:flutter_conditional_rendering/conditional_switch.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:java_code/config/themes/colours.dart';
import 'package:java_code/constant/core/assets_const.dart';
import 'package:java_code/modules/features/detail_menu/controller/detail_menu_controller.dart';
import 'package:java_code/modules/features/detail_menu/view/component/button_card.dart';
import 'package:java_code/modules/features/detail_menu/view/component/custom_text_button.dart';
import 'package:java_code/modules/features/home/controllers/home_controller.dart';
import 'package:java_code/modules/models/all_menu_res/datum.dart';
import 'package:java_code/modules/models/detail_menu_res/detail_menu_res.dart';
import 'package:java_code/shared/widgets/custom_snackbar.dart';

class DetailMenuView extends StatelessWidget {
  const DetailMenuView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(DetailMenuController());

    return Scaffold(
      backgroundColor: Colours.bgColors,
      body: GetBuilder<DetailMenuController>(
        builder: (_) => Conditional.single(
          context: context,
          conditionBuilder: (context) =>
              DetailMenuController.to.detailMenuResult != null,
          widgetBuilder: (context) => const DetailMenuSukses(),
          fallbackBuilder: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}

class DetailMenuSukses extends StatelessWidget {
  const DetailMenuSukses({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DetailMenuRes result = DetailMenuController.to.detailMenuResult!;
    // MENDAPATKAN INDEX DARI ARGUMENT
    var index = Get.arguments['index'];
    return SafeArea(
      child: ListView(
        children: [
          /// APPBAR DETAIL MENU
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
              child: Stack(
                children: [
                  IconButton(
                    onPressed: () {
                      // if (count != 0) {
                      //   count--;
                      // }
                      Get.back();
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_new,
                      size: 18.sp,
                      color: Colours.green2,
                    ),
                  ),
                  Center(
                    child: Text(
                      "Detail Menu",
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w700,
                        fontSize: 20.sp,
                        color: Colours.darkGrey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 25.h),

          /// GAMBAR MENU
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 234.w,
                height: 181.h,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30.r),
                  child: Image.network(
                    result.data?.menu?.foto ?? AssetConts.iconEmptyMenu,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 25.h),

          /// BOX DETAIL MENU
          Container(
            height: 600.h,
            decoration: BoxDecoration(
              color: Colours.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.sp),
                topRight: Radius.circular(30.sp),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 46.h),
                Container(
                  margin: EdgeInsets.only(
                    left: 25.sp,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// NAMA MENU DAN BUTTON COUNTER
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // NAMA MENU
                          Text(
                            result.data?.menu?.nama ??
                                'Belum ada nama untuk menu ini',
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w700,
                              fontSize: 20.sp,
                              color: Colours.green2,
                            ),
                          ),
                          // BUTTON KURANG , COUNT , BUTTON TAMBAH
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              // BUTTON KURANG
                              Material(
                                child: SizedBox(
                                  height: 21.w,
                                  width: 21.w,
                                  child: ConditionalSwitch.single(
                                    context: context,
                                    valueBuilder: (context) =>
                                        result.data!.menu!.kategori,
                                    caseBuilders: {
                                      'makanan': (context) => Obx(
                                            () => Conditional.single(
                                              context: context,
                                              conditionBuilder: (context) {
                                                Datum currentData =
                                                    HomeController.to
                                                        .listMenuMakanan[index];
                                                return currentData.count != 0;
                                              },
                                              widgetBuilder: (context) =>
                                                  InkWell(
                                                splashColor: Colors.grey,
                                                onTap: () {
                                                  Datum currentData = Datum(
                                                    count: HomeController
                                                            .to
                                                            .listMenuMakanan[
                                                                index]
                                                            .count! -
                                                        1,
                                                    deskripsi: HomeController
                                                        .to
                                                        .listMenuMakanan[index]
                                                        .deskripsi,
                                                    foto: HomeController
                                                        .to
                                                        .listMenuMakanan[index]
                                                        .foto,
                                                    harga: HomeController
                                                        .to
                                                        .listMenuMakanan[index]
                                                        .harga,
                                                    idMenu: HomeController
                                                        .to
                                                        .listMenuMakanan[index]
                                                        .idMenu,
                                                    kategori: HomeController
                                                        .to
                                                        .listMenuMakanan[index]
                                                        .kategori,
                                                    nama: HomeController
                                                        .to
                                                        .listMenuMakanan[index]
                                                        .nama,
                                                    status: HomeController
                                                        .to
                                                        .listMenuMakanan[index]
                                                        .status,
                                                  );

                                                  if (HomeController
                                                          .to
                                                          .listMenuMakanan[
                                                              index]
                                                          .count! !=
                                                      0) {
                                                    HomeController
                                                            .to.listMenuMakanan[
                                                        index] = currentData;
                                                  } else {
                                                    CustomSnackbar().snackBar(
                                                        title: "Perhatian",
                                                        message:
                                                            'Counter sudah nol');
                                                  }
                                                  print(
                                                      'FAK ==  ${HomeController.to.listMenuMakanan[index].nama!} - ${HomeController.to.listMenuMakanan[index].count!}');
                                                },
                                                child: Image.asset(
                                                  AssetConts.iconKurang,
                                                ),
                                              ),
                                              fallbackBuilder: (context) =>
                                                  Container(
                                                color: Colours.white,
                                              ),
                                            ),
                                          ),
                                      'minuman': (context) => Obx(
                                            () => Conditional.single(
                                              context: context,
                                              conditionBuilder: (context) {
                                                Datum currentData =
                                                    HomeController.to
                                                        .listMenuMinuman[index];
                                                return currentData.count != 0;
                                              },
                                              widgetBuilder: (context) =>
                                                  InkWell(
                                                splashColor: Colors.grey,
                                                onTap: () {
                                                  Datum currentData = Datum(
                                                    count: HomeController
                                                            .to
                                                            .listMenuMinuman[
                                                                index]
                                                            .count! -
                                                        1,
                                                    deskripsi: HomeController
                                                        .to
                                                        .listMenuMinuman[index]
                                                        .deskripsi,
                                                    foto: HomeController
                                                        .to
                                                        .listMenuMinuman[index]
                                                        .foto,
                                                    harga: HomeController
                                                        .to
                                                        .listMenuMinuman[index]
                                                        .harga,
                                                    idMenu: HomeController
                                                        .to
                                                        .listMenuMinuman[index]
                                                        .idMenu,
                                                    kategori: HomeController
                                                        .to
                                                        .listMenuMinuman[index]
                                                        .kategori,
                                                    nama: HomeController
                                                        .to
                                                        .listMenuMinuman[index]
                                                        .nama,
                                                    status: HomeController
                                                        .to
                                                        .listMenuMinuman[index]
                                                        .status,
                                                  );

                                                  if (HomeController
                                                          .to
                                                          .listMenuMinuman[
                                                              index]
                                                          .count! !=
                                                      0) {
                                                    HomeController
                                                            .to.listMenuMinuman[
                                                        index] = currentData;
                                                  } else {
                                                    Get.snackbar("Perhatian",
                                                        'Counter sudah nol');
                                                    CustomSnackbar().snackBar(
                                                      title: 'Perhatian',
                                                      message:
                                                          'Counter sudah nol',
                                                    );
                                                  }
                                                  print(
                                                      'FAK ==  ${HomeController.to.listMenuMinuman[index].nama!} - ${HomeController.to.listMenuMinuman[index].count!}');
                                                },
                                                child: Image.asset(
                                                  AssetConts.iconKurang,
                                                ),
                                              ),
                                              fallbackBuilder: (context) =>
                                                  Container(
                                                color: Colours.white,
                                              ),
                                            ),
                                          ),
                                      'snack': (context) => Obx(
                                            () => Conditional.single(
                                              context: context,
                                              conditionBuilder: (context) {
                                                Datum currentData =
                                                    HomeController.to
                                                        .listMenuSnack[index];
                                                return currentData.count != 0;
                                              },
                                              widgetBuilder: (context) =>
                                                  InkWell(
                                                splashColor: Colors.grey,
                                                onTap: () {
                                                  Datum currentData = Datum(
                                                    count: HomeController
                                                            .to
                                                            .listMenuSnack[
                                                                index]
                                                            .count! -
                                                        1,
                                                    deskripsi: HomeController
                                                        .to
                                                        .listMenuSnack[index]
                                                        .deskripsi,
                                                    foto: HomeController
                                                        .to
                                                        .listMenuSnack[index]
                                                        .foto,
                                                    harga: HomeController
                                                        .to
                                                        .listMenuSnack[index]
                                                        .harga,
                                                    idMenu: HomeController
                                                        .to
                                                        .listMenuSnack[index]
                                                        .idMenu,
                                                    kategori: HomeController
                                                        .to
                                                        .listMenuSnack[index]
                                                        .kategori,
                                                    nama: HomeController
                                                        .to
                                                        .listMenuSnack[index]
                                                        .nama,
                                                    status: HomeController
                                                        .to
                                                        .listMenuSnack[index]
                                                        .status,
                                                  );

                                                  if (HomeController
                                                          .to
                                                          .listMenuSnack[index]
                                                          .count! !=
                                                      0) {
                                                    if (HomeController
                                                            .to
                                                            .listMenuSnack[
                                                                index]
                                                            .count! ==
                                                        1) {
                                                      // Get.defaultDialog(
                                                      //   title: 'Verifikasi Pesanan',
                                                      //   titleStyle: GoogleFonts.montserrat(
                                                      //     fontWeight: FontWeight.w600,
                                                      //     fontSize: 22.sp,
                                                      //     color: Colours.darkGrey,
                                                      //   ),
                                                      //   titlePadding:
                                                      //       EdgeInsets.only(top: 24.sp),
                                                      //   content: SizedBox(
                                                      //     width: 338.w,
                                                      //     child: Column(
                                                      //       children: [
                                                      //         Text(
                                                      //           "Masukan Kode PIN",
                                                      //           style:
                                                      //               GoogleFonts.montserrat(
                                                      //             fontWeight:
                                                      //                 FontWeight.w400,
                                                      //             fontSize: 16.sp,
                                                      //             color: const Color(
                                                      //                 0xff969696),
                                                      //           ),
                                                      //         ),
                                                      //         SizedBox(height: 24.h),
                                                      //         // INPUT PIN
                                                      //         Form(
                                                      //           child: Row(
                                                      //             children: [
                                                      //               SizedBox(
                                                      //                 height: 35.h,
                                                      //                 width: 34.w,
                                                      //                 child: TextField(
                                                      //                   decoration:
                                                      //                       InputDecoration(
                                                      //                     enabledBorder:
                                                      //                         OutlineInputBorder(
                                                      //                       borderRadius:
                                                      //                           BorderRadius
                                                      //                               .circular(
                                                      //                                   10),
                                                      //                       borderSide:
                                                      //                           const BorderSide(
                                                      //                               color: Colours
                                                      //                                   .grey),
                                                      //                     ),
                                                      //                     focusedBorder:
                                                      //                         OutlineInputBorder(
                                                      //                       borderRadius:
                                                      //                           BorderRadius
                                                      //                               .circular(
                                                      //                                   10),
                                                      //                       borderSide: const BorderSide(
                                                      //                           color: Colours
                                                      //                               .green2),
                                                      //                     ),
                                                      //                   ),
                                                      //                 ),
                                                      //               ),
                                                      //             ],
                                                      //           ),
                                                      //         ),
                                                      //       ],
                                                      //     ),
                                                      //   ),
                                                      // );
                                                    }
                                                    HomeController
                                                            .to.listMenuSnack[
                                                        index] = currentData;
                                                  } else {
                                                    CustomSnackbar().snackBar(
                                                      title: 'Perhatian',
                                                      message:
                                                          'Counter sudah nol',
                                                    );
                                                  }
                                                  print(
                                                      'FAK ==  ${HomeController.to.listMenuSnack[index].nama!} - ${HomeController.to.listMenuSnack[index].count!}');
                                                },
                                                child: Image.asset(
                                                  AssetConts.iconKurang,
                                                ),
                                              ),
                                              fallbackBuilder: (context) =>
                                                  Container(
                                                color: Colours.white,
                                              ),
                                            ),
                                          ),
                                    },
                                    // KONDISI BUKAN MAKANAN , MINUMAN DAN SNACK
                                    // TIDAK MEMUNCULKAN TOMBOL MINES
                                    fallbackBuilder: (context) =>
                                        Container(color: Colours.white),
                                  ),
                                ),
                              ),
                              // NOMINAL COUNT
                              const SizedBox(width: 11),
                              ConditionalSwitch.single(
                                context: context,
                                valueBuilder: (context) =>
                                    result.data!.menu!.kategori,
                                caseBuilders: {
                                  'makanan': (context) => Obx(
                                        () => Text(
                                          '${HomeController.to.listMenuMakanan[index].count}',
                                          style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18.sp,
                                          ),
                                        ),
                                      ),
                                  'minuman': (context) => Obx(
                                        () => Text(
                                          '${HomeController.to.listMenuMinuman[index].count}',
                                          style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18.sp,
                                          ),
                                        ),
                                      ),
                                  'snack': (context) => Obx(
                                        () => Text(
                                          '${HomeController.to.listMenuSnack[index].count}',
                                          style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18.sp,
                                          ),
                                        ),
                                      ),
                                },
                                // KONDISI BUKAN MAKANAN , MINUMAN DAN SNACK
                                // TIDAK MEMUNCULKAN JUMLAH COUNT
                                fallbackBuilder: (context) =>
                                    Container(color: Colours.whiteItem),
                              ),
                              const SizedBox(width: 11),
                              // BUTTON TAMBAH
                              Material(
                                child: ConditionalSwitch.single(
                                  context: context,
                                  valueBuilder: (context) =>
                                      result.data!.menu!.kategori,
                                  caseBuilders: {
                                    'makanan': (context) => InkWell(
                                          splashColor: Colors.grey,
                                          onTap: () {
                                            // MENDAPATKAN INDEX DARI ARGUMENT
                                            var index = Get.arguments['index'];
                                            // LOGIC INCREMENT
                                            Datum currentData = Datum(
                                              count: HomeController
                                                      .to
                                                      .listMenuMakanan[index]
                                                      .count! +
                                                  1,
                                              deskripsi: HomeController
                                                  .to
                                                  .listMenuMakanan[index]
                                                  .deskripsi,
                                              foto: HomeController.to
                                                  .listMenuMakanan[index].foto,
                                              harga: HomeController.to
                                                  .listMenuMakanan[index].harga,
                                              idMenu: HomeController
                                                  .to
                                                  .listMenuMakanan[index]
                                                  .idMenu,
                                              kategori: HomeController
                                                  .to
                                                  .listMenuMakanan[index]
                                                  .kategori,
                                              nama: HomeController.to
                                                  .listMenuMakanan[index].nama,
                                              status: HomeController
                                                  .to
                                                  .listMenuMakanan[index]
                                                  .status,
                                            );

                                            HomeController
                                                    .to.listMenuMakanan[index] =
                                                currentData;
                                            print(
                                                'FAK == ${HomeController.to.listMenuMakanan[index].nama!} - ${HomeController.to.listMenuMakanan[index].count!}');
                                          },
                                          child: SizedBox(
                                            height: 21.w,
                                            width: 21.w,
                                            child: Image.asset(
                                              AssetConts.iconTambah,
                                            ),
                                          ),
                                        ),
                                    'minuman': (context) => InkWell(
                                          splashColor: Colors.grey,
                                          onTap: () {
                                            var index = Get.arguments['index'];
                                            Datum currentData = Datum(
                                              count: HomeController
                                                      .to
                                                      .listMenuMinuman[index]
                                                      .count! +
                                                  1,
                                              deskripsi: HomeController
                                                  .to
                                                  .listMenuMinuman[index]
                                                  .deskripsi,
                                              foto: HomeController.to
                                                  .listMenuMinuman[index].foto,
                                              harga: HomeController.to
                                                  .listMenuMinuman[index].harga,
                                              idMenu: HomeController
                                                  .to
                                                  .listMenuMinuman[index]
                                                  .idMenu,
                                              kategori: HomeController
                                                  .to
                                                  .listMenuMinuman[index]
                                                  .kategori,
                                              nama: HomeController.to
                                                  .listMenuMinuman[index].nama,
                                              status: HomeController
                                                  .to
                                                  .listMenuMinuman[index]
                                                  .status,
                                            );

                                            HomeController
                                                    .to.listMenuMinuman[index] =
                                                currentData;
                                            print(
                                                'FAK == ${HomeController.to.listMenuMinuman[index].nama!} - ${HomeController.to.listMenuMinuman[index].count!}');
                                          },
                                          child: Container(
                                            height: 21,
                                            width: 21,
                                            decoration: const BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage(
                                                  AssetConts.iconTambah,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                    'snack': (context) => InkWell(
                                          splashColor: Colors.grey,
                                          onTap: () {
                                            // MENDAPATKAN INDEX ARGUMENT
                                            var index = Get.arguments['index'];
                                            Datum currentData = Datum(
                                              count: HomeController
                                                      .to
                                                      .listMenuSnack[index]
                                                      .count! +
                                                  1,
                                              deskripsi: HomeController
                                                  .to
                                                  .listMenuSnack[index]
                                                  .deskripsi,
                                              foto: HomeController
                                                  .to.listMenuSnack[index].foto,
                                              harga: HomeController.to
                                                  .listMenuSnack[index].harga,
                                              idMenu: HomeController.to
                                                  .listMenuSnack[index].idMenu,
                                              kategori: HomeController
                                                  .to
                                                  .listMenuSnack[index]
                                                  .kategori,
                                              nama: HomeController
                                                  .to.listMenuSnack[index].nama,
                                              status: HomeController.to
                                                  .listMenuSnack[index].status,
                                            );

                                            HomeController
                                                    .to.listMenuSnack[index] =
                                                currentData;
                                            print(
                                                'FAK == ${HomeController.to.listMenuSnack[index].nama!} - ${HomeController.to.listMenuSnack[index].count!}');
                                          },
                                          child: Container(
                                            height: 21,
                                            width: 21,
                                            decoration: const BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage(
                                                  AssetConts.iconTambah,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                  },
                                  // KONDISI BUKAN MAKANAN , MINUMAN DAN SNACK
                                  // TIDAK MEMUNCULKAN TOMBOL
                                  fallbackBuilder: (context) =>
                                      Container(color: Colours.whiteItem),
                                ),
                              ),
                              SizedBox(width: 23.w)
                            ],
                          ),
                        ],
                      ),

                      SizedBox(height: 14.h),

                      /// DETAIL MENU
                      SizedBox(
                        width: 295.w,
                        child: Text(
                          result.data?.menu?.deskripsi ??
                              'Menu enak sehat dan bergizi',
                          softWrap: true,
                          maxLines: 10,
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w600,
                            fontSize: 16.sp,
                            color: Colours.darkGrey,
                          ),
                        ),
                      ),

                      SizedBox(height: 39.h),

                      /// BUTTON CARD HARGA
                      ButtonCard(
                        stringIcon: AssetConts.iconHarga,
                        widthIcon: 16.w,
                        heightIcon: 16.w,
                        nama: 'Harga',
                        child: Text(
                          '${result.data?.menu?.harga ?? 0}',
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w700,
                            fontSize: 20.sp,
                            color: Colours.green2,
                          ),
                        ),
                      ),

                      /// BUTTON LEVEL
                      ButtonCard(
                        stringIcon: AssetConts.iconLevel,
                        widthIcon: 20.w,
                        heightIcon: 20.w,
                        nama: 'Level',
                        child: Obx(
                          () => customTextButton(
                              nama:
                                  DetailMenuController.to.keteranganLevel.value,
                              ontap: () {
                                Get.bottomSheet(
                                  barrierColor: Colours.grey.withOpacity(0.5),
                                  Container(
                                    height: 120.h,
                                    width: ScreenUtil().screenWidth,
                                    decoration: BoxDecoration(
                                      color: Colours.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30.r),
                                        topRight: Radius.circular(30.r),
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 19.h),
                                        Center(
                                          child: Container(
                                            width: 104.w,
                                            height: 4.h,
                                            decoration: BoxDecoration(
                                              color: const Color(0xffC4C4C4)
                                                  .withOpacity(0.5),
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 13.h),
                                        Container(
                                          margin: EdgeInsets.only(left: 17.sp),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Pilih Level",
                                                style: GoogleFonts.montserrat(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 18.sp,
                                                  color: Colours.darkGrey,
                                                ),
                                              ),
                                              SizedBox(height: 17.sp),
                                              // LIST LEVEL
                                              Conditional.single(
                                                context: context,
                                                conditionBuilder: (context) =>
                                                    result.data!.level!
                                                        .isNotEmpty,
                                                widgetBuilder: (context) =>
                                                    SizedBox(
                                                  height: 25.h,
                                                  width:
                                                      ScreenUtil().screenWidth,
                                                  child: ListView.builder(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemCount: result.data
                                                            ?.level?.length ??
                                                        0,
                                                    itemBuilder:
                                                        (context, index) {
                                                      // MENGAMBL LIST INDEX LEVEL
                                                      var listIndex =
                                                          DetailMenuController
                                                              .to
                                                              .listIndexLevel;
                                                      return Obx(
                                                        () => InkWell(
                                                          onTap: () {
                                                            listIndex.value =
                                                                index;
                                                            DetailMenuController
                                                                    .to
                                                                    .keteranganLevel
                                                                    .value =
                                                                result
                                                                    .data!
                                                                    .level![
                                                                        index]
                                                                    .keterangan!;
                                                          },
                                                          child: Container(
                                                            width: 48.w,
                                                            height: 25.h,
                                                            margin:
                                                                EdgeInsets.only(
                                                                    left:
                                                                        10.sp),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: listIndex
                                                                          .value ==
                                                                      index
                                                                  ? Colours
                                                                      .green2
                                                                  : Colours
                                                                      .white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          30.sp),
                                                              border:
                                                                  Border.all(
                                                                color: listIndex
                                                                            .value ==
                                                                        index
                                                                    ? Colours
                                                                        .white
                                                                    : Colours
                                                                        .green2,
                                                              ),
                                                            ),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  "${result.data!.level![index].keterangan} ",
                                                                  style: GoogleFonts
                                                                      .montserrat(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    fontSize:
                                                                        12.sp,
                                                                    color: listIndex.value ==
                                                                            index
                                                                        ? Colours
                                                                            .white
                                                                        : Colours
                                                                            .darkGrey,
                                                                  ),
                                                                ),
                                                                Image.asset(
                                                                  AssetConts
                                                                      .iconCeklis,
                                                                  width: 12.w,
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                                fallbackBuilder: (context) =>
                                                    Center(
                                                  child: Text(
                                                    "Tidak ada level untuk menu ini",
                                                    style:
                                                        GoogleFonts.montserrat(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 18.sp,
                                                      color: Colours.darkGrey,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ),

                      /// BUTTON TOPPING
                      ButtonCard(
                        stringIcon: AssetConts.iconTopping,
                        widthIcon: 18.w,
                        heightIcon: 18.w,
                        nama: 'Topping',
                        child: Obx(
                          () => customTextButton(
                              nama: DetailMenuController
                                  .to.keteranganToping.value,
                              ontap: () {
                                Get.bottomSheet(
                                  barrierColor: Colours.grey.withOpacity(0.5),
                                  Container(
                                    height: 120.h,
                                    width: ScreenUtil().screenWidth,
                                    decoration: BoxDecoration(
                                      color: Colours.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30.r),
                                        topRight: Radius.circular(30.r),
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 19.h),
                                        // GARIS TENGAH
                                        Center(
                                          child: Container(
                                            width: 104.w,
                                            height: 4.h,
                                            decoration: BoxDecoration(
                                              color: const Color(0xffC4C4C4)
                                                  .withOpacity(0.5),
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 13.h),
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: 17.sp, right: 17.sp),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              // TEXT TOPPING
                                              Text(
                                                "Pilih Toping",
                                                style: GoogleFonts.montserrat(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 18,
                                                  color: Colours.darkGrey,
                                                ),
                                              ),
                                              SizedBox(height: 17.sp),
                                              // PILIH TOPPING
                                              Conditional.single(
                                                context: context,
                                                conditionBuilder: (context) =>
                                                    result.data!.topping!
                                                        .isNotEmpty,
                                                widgetBuilder: (context) =>
                                                    SizedBox(
                                                  height: 25.h,
                                                  width:
                                                      ScreenUtil().screenWidth,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child: ListView.builder(
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          itemCount: result
                                                                  .data
                                                                  ?.topping
                                                                  ?.length ??
                                                              0,
                                                          itemBuilder:
                                                              (context, index) {
                                                            // MENGAMBL LIST INDEX LEVEL
                                                            var listIndex =
                                                                DetailMenuController
                                                                    .to
                                                                    .listIndexToping;

                                                            return Obx(
                                                              () => Row(
                                                                children: [
                                                                  InkWell(
                                                                    onTap: () {
                                                                      listIndex
                                                                              .value =
                                                                          index;
                                                                      DetailMenuController
                                                                          .to
                                                                          .keteranganToping
                                                                          .value = result
                                                                              .data!
                                                                              .topping![index]
                                                                          [
                                                                          'keterangan'];
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      width:
                                                                          94.w,
                                                                      height:
                                                                          25.h,
                                                                      margin: EdgeInsets.only(
                                                                          left:
                                                                              10.sp),
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: listIndex.value ==
                                                                                index
                                                                            ? Colours.green2
                                                                            : Colours.white,
                                                                        borderRadius:
                                                                            BorderRadius.circular(30.sp),
                                                                        border:
                                                                            Border.all(
                                                                          color: listIndex.value == index
                                                                              ? Colours.white
                                                                              : Colours.green2,
                                                                        ),
                                                                      ),
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          Text(
                                                                            "${result.data!.topping![index]['keterangan']} ",
                                                                            style:
                                                                                GoogleFonts.montserrat(
                                                                              fontWeight: FontWeight.w400,
                                                                              fontSize: 12.sp,
                                                                              color: listIndex.value == index ? Colours.white : Colours.darkGrey,
                                                                            ),
                                                                          ),
                                                                          Image
                                                                              .asset(
                                                                            AssetConts.iconCeklis,
                                                                            width:
                                                                                12.w,
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  //
                                                                ],
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                      Conditional.single(
                                                        context: context,
                                                        conditionBuilder:
                                                            (context) => result
                                                                .data!
                                                                .topping!
                                                                .isNotEmpty,
                                                        widgetBuilder:
                                                            (context) =>
                                                                SizedBox(
                                                          width: 94.w,
                                                          height: 25.h,
                                                          child: ElevatedButton(
                                                            onPressed: () {
                                                              DetailMenuController
                                                                      .to
                                                                      .keteranganToping
                                                                      .value =
                                                                  'Anda Belum Memilih';
                                                              Get.back();
                                                            },
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              primary: Colours
                                                                  .green2,
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            30.r),
                                                              ),
                                                            ),
                                                            child: const Text(
                                                                'Batal'),
                                                          ),
                                                        ),
                                                        fallbackBuilder:
                                                            (context) =>
                                                                const SizedBox(),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                fallbackBuilder: (context) =>
                                                    Center(
                                                  child: Text(
                                                    "Tidak ada topping untuk menu ini",
                                                    style:
                                                        GoogleFonts.montserrat(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 18.sp,
                                                      color: Colours.darkGrey,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ),

                      /// CATATAN
                      ButtonCard(
                        stringIcon: AssetConts.iconCatatan,
                        widthIcon: 20.w,
                        heightIcon: 22.w,
                        nama: 'Catatan',
                        child: customTextButton(
                          nama: 'Tambahkan Catatan...',
                          ontap: () {
                            Get.bottomSheet(
                              barrierColor: Colours.grey.withOpacity(0.5),
                              Container(
                                height: 200.h,
                                width: ScreenUtil().screenWidth,
                                decoration: BoxDecoration(
                                  color: Colours.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30.r),
                                    topRight: Radius.circular(30.r),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 19.h),
                                    Center(
                                      child: Container(
                                        width: 104.w,
                                        height: 4.h,
                                        decoration: BoxDecoration(
                                          color: const Color(0xffC4C4C4)
                                              .withOpacity(0.5),
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                      ),
                                    ),

                                    ///
                                    SizedBox(height: 13.h),
                                    Container(
                                      margin: EdgeInsets.only(left: 17.sp),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Buat Catatan",
                                            style: GoogleFonts.montserrat(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 18,
                                              color: Colours.darkGrey,
                                            ),
                                          ),
                                          SizedBox(height: 17.sp),
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 349.w,
                                                child: const TextField(
                                                  autocorrect: false,
                                                  textInputAction:
                                                      TextInputAction.done,
                                                  maxLength: 100,
                                                  // onEditingComplete: () {},
                                                ),
                                              ),
                                              SizedBox(width: 9.w),
                                              InkWell(
                                                onTap: () {
                                                  Get.back();
                                                },
                                                child: Container(
                                                  width: 24.w,
                                                  height: 24.w,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            24),
                                                    color: Colours.green2,
                                                    image:
                                                        const DecorationImage(
                                                      image: AssetImage(
                                                          AssetConts
                                                              .iconCeklis),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      Container(
                        width: 381.w,
                        height: 1.h,
                        decoration: BoxDecoration(
                          color: Colours.darkGrey.withOpacity(0.25),
                        ),
                      ),
                      SizedBox(height: 40.h),

                      /// BUTTON TAMBAHKAN KE KERANJANG
                      Container(
                        height: 44.h,
                        width: ScreenUtil().screenWidth,
                        margin: EdgeInsets.only(right: 23.sp),
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            elevation: 5.sp,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.r),
                            ),
                          ),
                          child: Text(
                            "Tambahakan Ke Keranjang",
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: Colours.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
