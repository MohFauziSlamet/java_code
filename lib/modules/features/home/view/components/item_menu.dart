// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:java_code/config/routes/app_routes.dart';
import 'package:java_code/modules/features/home/controllers/home_controller.dart';
import 'package:java_code/modules/models/all_menu_res/datum.dart';
import 'package:java_code/shared/widgets/custom_snackbar.dart';
import '/config/themes/colours.dart';
import '/constant/core/assets_const.dart';

// ignore: must_be_immutable
class ItemMenu extends StatelessWidget {
  ItemMenu({
    Key? key,
    required this.result,
    required this.index,
  }) : super(key: key);

  Datum result;
  int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () async {
        Get.toNamed(AppRoutes.detailMenu, arguments: {
          'index': index, // DIPAKAI DI VIEW DETAIL MENU
          'id_menu': result.idMenu, // DIPAKAI DI CONTROLLER LANGSUNG
          'datum': result, // DIPAKAI DI VIEW DETAIL MENU
        });
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 17.sp),
        child: Material(
          elevation: 4.sp,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 90.h,
            width: 378.w,
            decoration: BoxDecoration(
              color: Colours.whiteItem,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                /// GAMBAR MENU
                Container(
                  margin: const EdgeInsets.all(7),
                  height: 75.w,
                  width: 75.w,
                  decoration: BoxDecoration(
                    color: const Color(0xffDFDFDF),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: SizedBox(
                      width: 75.w,
                      height: 75.w,
                      child: result.foto != null
                          ? Image.network(
                              result.foto!,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              AssetConts.iconEmptyMenu,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ),
                SizedBox(width: 5.sp),

                /// NAMA/HARGA/CATATAN
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /// NAMA MENU
                      SizedBox(height: 7.sp),
                      FittedBox(
                        child: Text(
                          result.nama ?? '',
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w500,
                            fontSize: 23.sp,
                            color: Colours.darkGrey,
                          ),
                        ),
                      ),

                      /// HARGA MENU
                      FittedBox(
                        child: Text(
                          "Rp ${result.harga ?? 0}",
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w700,
                            fontSize: 18.sp,
                            color: Colours.green2,
                          ),
                        ),
                      ),
                      const SizedBox(height: 3),

                      /// ICON TAMBAH  NOTE
                      Row(
                        children: [
                          Container(
                            height: 11.h,
                            width: 13.w,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                  AssetConts.iconTambahNote,
                                ),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          const SizedBox(width: 7),
                          SizedBox(
                            width: Get.width * 0.3,
                            child: Text(
                              "Tambahkan Catatan",
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w500,
                                fontSize: 12.sp,
                                color: Colours.textGrey,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 14.sp),
                    ],
                  ),
                ),

                /// TOMBOL TAMBAH, KURANG, COUNT
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
                          valueBuilder: (context) => result.kategori,
                          caseBuilders: {
                            'makanan': (context) => Obx(
                                  () => Conditional.single(
                                    context: context,
                                    conditionBuilder: (context) {
                                      Datum currentData = HomeController
                                          .to.listMenuMakanan[index];
                                      return currentData.count != 0;
                                    },
                                    widgetBuilder: (context) => InkWell(
                                      splashColor: Colors.grey,
                                      onTap: () {
                                        Datum currentData = Datum(
                                          count: HomeController
                                                  .to
                                                  .listMenuMakanan[index]
                                                  .count! -
                                              1,
                                          deskripsi: HomeController.to
                                              .listMenuMakanan[index].deskripsi,
                                          foto: HomeController
                                              .to.listMenuMakanan[index].foto,
                                          harga: HomeController
                                              .to.listMenuMakanan[index].harga,
                                          idMenu: HomeController
                                              .to.listMenuMakanan[index].idMenu,
                                          kategori: HomeController.to
                                              .listMenuMakanan[index].kategori,
                                          nama: HomeController
                                              .to.listMenuMakanan[index].nama,
                                          status: HomeController
                                              .to.listMenuMakanan[index].status,
                                        );

                                        if (HomeController
                                                .to
                                                .listMenuMakanan[index]
                                                .count! !=
                                            0) {
                                          HomeController
                                                  .to.listMenuMakanan[index] =
                                              currentData;
                                        } else {
                                          CustomSnackbar().snackBar(
                                            title: 'Perhatian',
                                            message: 'Counter sudah nol',
                                          );
                                        }
                                        print(
                                            'FAK ==  ${HomeController.to.listMenuMakanan[index].nama!} - ${HomeController.to.listMenuMakanan[index].count!}');
                                      },
                                      child: Image.asset(
                                        AssetConts.iconKurang,
                                      ),
                                    ),
                                    fallbackBuilder: (context) => Container(
                                      color: Colours.whiteItem,
                                    ),
                                  ),
                                ),
                            'minuman': (context) => Obx(
                                  () => Conditional.single(
                                    context: context,
                                    conditionBuilder: (context) {
                                      Datum currentData = HomeController
                                          .to.listMenuMinuman[index];
                                      return currentData.count != 0;
                                    },
                                    widgetBuilder: (context) => InkWell(
                                      splashColor: Colors.grey,
                                      onTap: () {
                                        Datum currentData = Datum(
                                          count: HomeController
                                                  .to
                                                  .listMenuMinuman[index]
                                                  .count! -
                                              1,
                                          deskripsi: HomeController.to
                                              .listMenuMinuman[index].deskripsi,
                                          foto: HomeController
                                              .to.listMenuMinuman[index].foto,
                                          harga: HomeController
                                              .to.listMenuMinuman[index].harga,
                                          idMenu: HomeController
                                              .to.listMenuMinuman[index].idMenu,
                                          kategori: HomeController.to
                                              .listMenuMinuman[index].kategori,
                                          nama: HomeController
                                              .to.listMenuMinuman[index].nama,
                                          status: HomeController
                                              .to.listMenuMinuman[index].status,
                                        );

                                        if (HomeController
                                                .to
                                                .listMenuMinuman[index]
                                                .count! !=
                                            0) {
                                          HomeController
                                                  .to.listMenuMinuman[index] =
                                              currentData;
                                        } else {
                                          CustomSnackbar().snackBar(
                                            title: 'Perhatian',
                                            message: 'Counter sudah nol',
                                          );
                                        }
                                        print(
                                            'FAK ==  ${HomeController.to.listMenuMinuman[index].nama!} - ${HomeController.to.listMenuMinuman[index].count!}');
                                      },
                                      child: Image.asset(
                                        AssetConts.iconKurang,
                                      ),
                                    ),
                                    fallbackBuilder: (context) => Container(
                                      color: Colours.whiteItem,
                                    ),
                                  ),
                                ),
                            'snack': (context) => Obx(
                                  () => Conditional.single(
                                    context: context,
                                    conditionBuilder: (context) {
                                      Datum currentData = HomeController
                                          .to.listMenuSnack[index];
                                      return currentData.count != 0;
                                    },
                                    widgetBuilder: (context) => InkWell(
                                      splashColor: Colors.grey,
                                      onTap: () {
                                        Datum currentData = Datum(
                                          count: HomeController.to
                                                  .listMenuSnack[index].count! -
                                              1,
                                          deskripsi: HomeController.to
                                              .listMenuSnack[index].deskripsi,
                                          foto: HomeController
                                              .to.listMenuSnack[index].foto,
                                          harga: HomeController
                                              .to.listMenuSnack[index].harga,
                                          idMenu: HomeController
                                              .to.listMenuSnack[index].idMenu,
                                          kategori: HomeController
                                              .to.listMenuSnack[index].kategori,
                                          nama: HomeController
                                              .to.listMenuSnack[index].nama,
                                          status: HomeController
                                              .to.listMenuSnack[index].status,
                                        );

                                        if (HomeController.to
                                                .listMenuSnack[index].count! !=
                                            0) {
                                          if (HomeController
                                                  .to
                                                  .listMenuSnack[index]
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
                                                  .to.listMenuSnack[index] =
                                              currentData;
                                        } else {
                                          CustomSnackbar().snackBar(
                                            title: 'Perhatian',
                                            message: 'Counter sudah nol',
                                          );
                                        }
                                        print(
                                            'FAK ==  ${HomeController.to.listMenuSnack[index].nama!} - ${HomeController.to.listMenuSnack[index].count!}');
                                      },
                                      child: Image.asset(
                                        AssetConts.iconKurang,
                                      ),
                                    ),
                                    fallbackBuilder: (context) => Container(
                                      color: Colours.whiteItem,
                                    ),
                                  ),
                                ),
                          },
                          // KONDISI BUKAN MAKANAN , MINUMAN DAN SNACK
                          // TIDAK MEMUNCULKAN TOMBOL MINES
                          fallbackBuilder: (context) =>
                              Container(color: Colours.whiteItem),
                        ),
                      ),
                    ),

                    // JUMLAH COUNT
                    const SizedBox(width: 11),
                    ConditionalSwitch.single(
                      context: context,
                      valueBuilder: (context) => result.kategori,
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

                    SizedBox(width: 11.w),
                    // BUTTON TAMBAH
                    Material(
                      child: ConditionalSwitch.single(
                        context: context,
                        valueBuilder: (context) => result.kategori,
                        caseBuilders: {
                          'makanan': (context) => InkWell(
                                splashColor: Colors.grey,
                                onTap: () {
                                  // LOGIC INCREMENT
                                  Datum currentData = Datum(
                                    count: HomeController
                                            .to.listMenuMakanan[index].count! +
                                        1,
                                    deskripsi: HomeController
                                        .to.listMenuMakanan[index].deskripsi,
                                    foto: HomeController
                                        .to.listMenuMakanan[index].foto,
                                    harga: HomeController
                                        .to.listMenuMakanan[index].harga,
                                    idMenu: HomeController
                                        .to.listMenuMakanan[index].idMenu,
                                    kategori: HomeController
                                        .to.listMenuMakanan[index].kategori,
                                    nama: HomeController
                                        .to.listMenuMakanan[index].nama,
                                    status: HomeController
                                        .to.listMenuMakanan[index].status,
                                  );

                                  HomeController.to.listMenuMakanan[index] =
                                      currentData;
                                  print(
                                      'FAK == ${HomeController.to.listMenuMakanan[index].nama!} - ${HomeController.to.listMenuMakanan[index].count!}');
                                  // ON TAP TO DETAIL MENU
                                  Get.toNamed(AppRoutes.detailMenu, arguments: {
                                    'index':
                                        index, // DIPAKAI DI VIEW DETAIL MENU
                                    'id_menu': result
                                        .idMenu, // DIPAKAI DI DETAIL MENU CONTROLLER LANGSUNG
                                    'datum':
                                        result, // DIPAKAI DI VIEW DETAIL MENU
                                  });
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
                                  Datum currentData = Datum(
                                    count: HomeController
                                            .to.listMenuMinuman[index].count! +
                                        1,
                                    deskripsi: HomeController
                                        .to.listMenuMinuman[index].deskripsi,
                                    foto: HomeController
                                        .to.listMenuMinuman[index].foto,
                                    harga: HomeController
                                        .to.listMenuMinuman[index].harga,
                                    idMenu: HomeController
                                        .to.listMenuMinuman[index].idMenu,
                                    kategori: HomeController
                                        .to.listMenuMinuman[index].kategori,
                                    nama: HomeController
                                        .to.listMenuMinuman[index].nama,
                                    status: HomeController
                                        .to.listMenuMinuman[index].status,
                                  );

                                  HomeController.to.listMenuMinuman[index] =
                                      currentData;
                                  print(
                                      'FAK == ${HomeController.to.listMenuMinuman[index].nama!} - ${HomeController.to.listMenuMinuman[index].count!}');
                                  // ON TAP TO DETAIL MENU
                                  Get.toNamed(AppRoutes.detailMenu, arguments: {
                                    'index':
                                        index, // DIPAKAI DI VIEW DETAIL MENU
                                    'id_menu': result
                                        .idMenu, // DIPAKAI DI DETAIL MENU CONTROLLER LANGSUNG
                                    'datum':
                                        result, // DIPAKAI DI VIEW DETAIL MENU
                                  });
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
                                  Datum currentData = Datum(
                                    count: HomeController
                                            .to.listMenuSnack[index].count! +
                                        1,
                                    deskripsi: HomeController
                                        .to.listMenuSnack[index].deskripsi,
                                    foto: HomeController
                                        .to.listMenuSnack[index].foto,
                                    harga: HomeController
                                        .to.listMenuSnack[index].harga,
                                    idMenu: HomeController
                                        .to.listMenuSnack[index].idMenu,
                                    kategori: HomeController
                                        .to.listMenuSnack[index].kategori,
                                    nama: HomeController
                                        .to.listMenuSnack[index].nama,
                                    status: HomeController
                                        .to.listMenuSnack[index].status,
                                  );

                                  HomeController.to.listMenuSnack[index] =
                                      currentData;
                                  print(
                                      'FAK == ${HomeController.to.listMenuSnack[index].nama!} - ${HomeController.to.listMenuSnack[index].count!}');
                                  // ON TAP TO DETAIL MENU
                                  Get.toNamed(AppRoutes.detailMenu, arguments: {
                                    'index':
                                        index, // DIPAKAI DI VIEW DETAIL MENU
                                    'id_menu': result
                                        .idMenu, // DIPAKAI DI DETAIL MENU CONTROLLER LANGSUNG
                                    'datum':
                                        result, // DIPAKAI DI VIEW DETAIL MENU
                                  });
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

                    const SizedBox(width: 9)
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
