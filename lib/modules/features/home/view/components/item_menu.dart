// ignore_for_file: invalid_use_of_protected_member, avoid_print, must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:java_code/config/routes/app_routes.dart';
import 'package:java_code/modules/models/all_menu_res/data_menu.dart';
import 'package:java_code/utils/extensions/currency_format_to_idr.dart';
import '/config/themes/colours.dart';
import '/constant/core/assets_const.dart';

class ItemMenu extends StatelessWidget {
  ItemMenu({
    Key? key,
    required this.result,
    required this.index,
  }) : super(key: key);

  DataMenu result;
  int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () async {
        Get.toNamed(AppRoutes.detailMenu, arguments: {
          'index': index, // DIPAKAI DI VIEW DETAIL MENU
          'id_menu': result.idMenu, // DIPAKAI DI CONTROLLER LANGSUNG
          // 'DataMenu': result, // DIPAKAI DI VIEW DETAIL MENU
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
                      child: FadeInImage(
                        fit: BoxFit.cover,
                        placeholder: const AssetImage(AssetConts.gifLoadingImage),
                        image: NetworkImage(
                          result.foto ?? "",
                        ),
                        imageErrorBuilder: (context, error, stackTrace) => Image.asset(AssetConts.iconEmptyMenu, fit: BoxFit.cover),
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
                          CurrencyFormat.convertToIdr(result.harga ?? 0, 0),
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
                              "add_note".tr,
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
                    // GetBuilder<HomeController>(
                    //   builder: (_) {
                    //     return Material(
                    //       child: SizedBox(
                    //         height: 21.w,
                    //         width: 21.w,
                    //         child: Conditional.single(
                    //           context: context,
                    //           conditionBuilder: (context) =>
                    //               HomeController.to
                    //                   .getMenuByIdMenu(
                    //                       idMenu: result.idMenu ?? 0)[0]
                    //                   .count !=
                    //               0,
                    //           widgetBuilder: (context) => InkWell(
                    //             splashColor: Colors.grey,
                    //             onTap: () {
                    //               if (HomeController.to
                    //                       .getMenuByIdMenu(
                    //                           idMenu: result.idMenu ?? 0)[0]
                    //                       .count !=
                    //                   0) {
                    //                 if (HomeController.to
                    //                         .getMenuByIdMenu(
                    //                             idMenu: result.idMenu ?? 0)[0]
                    //                         .count ==
                    //                     1) {
                    //                   Get.defaultDialog(
                    //                     title: '',
                    //                     content: Container(
                    //                       width: 338.w,
                    //                       height: 418.h,
                    //                       decoration: BoxDecoration(
                    //                         color: Colours.white,
                    //                         borderRadius:
                    //                             BorderRadius.circular(30.r),
                    //                       ),
                    //                       child: Column(
                    //                         mainAxisAlignment:
                    //                             MainAxisAlignment.center,
                    //                         children: [
                    //                           iconNotifcation(),
                    //                           SizedBox(height: 30.h),
                    //                           Text(
                    //                             'Hapus item ?',
                    //                             style: GoogleFonts.montserrat(
                    //                               fontSize: 20.sp,
                    //                               color: Colours.darkGrey,
                    //                               fontWeight: FontWeight.w400,
                    //                             ),
                    //                           ),
                    //                           SizedBox(height: 15.h),
                    //                           Padding(
                    //                             padding: EdgeInsets.symmetric(
                    //                                 horizontal: 40.sp),
                    //                             child: RichText(
                    //                               textAlign: TextAlign.center,
                    //                               text: TextSpan(
                    //                                   text:
                    //                                       'Kamu akan mengeluarkan menu ini dari',
                    //                                   style: GoogleFonts
                    //                                       .montserrat(
                    //                                     fontSize: 16.sp,
                    //                                     color: Colours.darkGrey
                    //                                         .withOpacity(0.5),
                    //                                     fontWeight:
                    //                                         FontWeight.w300,
                    //                                   ),
                    //                                   children: <TextSpan>[
                    //                                     TextSpan(
                    //                                       text: ' Pesanan',
                    //                                       style: GoogleFonts
                    //                                           .montserrat(
                    //                                         fontSize: 16.sp,
                    //                                         color: Colours.grey,
                    //                                         fontWeight:
                    //                                             FontWeight.w700,
                    //                                       ),
                    //                                     )
                    //                                   ]),
                    //                             ),
                    //                           ),
                    //                           SizedBox(height: 15.h),
                    //                           Padding(
                    //                             padding: EdgeInsets.symmetric(
                    //                                 horizontal: 40.sp),
                    //                             child: Row(
                    //                               mainAxisAlignment:
                    //                                   MainAxisAlignment
                    //                                       .spaceEvenly,
                    //                               children: [
                    //                                 SizedBox(
                    //                                   height: 40.h,
                    //                                   width: 100.w,
                    //                                   child: TextButton(
                    //                                     style: TextButton
                    //                                         .styleFrom(
                    //                                       shape:
                    //                                           RoundedRectangleBorder(
                    //                                         borderRadius:
                    //                                             BorderRadius
                    //                                                 .circular(
                    //                                                     30.r),
                    //                                         side:
                    //                                             const BorderSide(
                    //                                           color: Colours
                    //                                               .green2,
                    //                                           width: 1,
                    //                                         ),
                    //                                       ),
                    //                                     ),
                    //                                     onPressed: () {
                    //                                       HomeController.to
                    //                                           .decrementOrder(
                    //                                               idMenu: result
                    //                                                       .idMenu ??
                    //                                                   0);
                    //                                       Get.back();
                    //                                       Get.toNamed(AppRoutes
                    //                                           .dashboardView);
                    //                                     },
                    //                                     child:
                    //                                         const Text('Oke'),
                    //                                   ),
                    //                                 ),
                    //                                 SizedBox(
                    //                                   height: 40.h,
                    //                                   width: 100.w,
                    //                                   child: ElevatedButton(
                    //                                     style: ElevatedButton
                    //                                         .styleFrom(
                    //                                       primary:
                    //                                           Colours.green2,
                    //                                       shape:
                    //                                           RoundedRectangleBorder(
                    //                                         borderRadius:
                    //                                             BorderRadius
                    //                                                 .circular(
                    //                                                     30.r),
                    //                                         side:
                    //                                             const BorderSide(
                    //                                           color:
                    //                                               Colours.white,
                    //                                           width: 1,
                    //                                         ),
                    //                                       ),
                    //                                     ),
                    //                                     onPressed: () {
                    //                                       Get.back();
                    //                                     },
                    //                                     child: const Text(
                    //                                         'Kembali'),
                    //                                   ),
                    //                                 ),
                    //                               ],
                    //                             ),
                    //                           )
                    //                         ],
                    //                       ),
                    //                     ),
                    //                   );
                    //                 } else {
                    //                   HomeController.to.decrementOrder(
                    //                       idMenu: result.idMenu ?? 0);
                    //                 }
                    //               } else {
                    //                 CustomSnackbar().snackBar(
                    //                   title: 'Perhatian',
                    //                   message: 'Counter sudah nol',
                    //                 );
                    //               }
                    //             },
                    //             child: Image.asset(
                    //               AssetConts.iconKurang,
                    //             ),
                    //           ),
                    //           fallbackBuilder: (context) => Container(
                    //             color: Colours.whiteItem,
                    //           ),
                    //         ),
                    //       ),
                    //     );
                    //   },
                    // ),

                    // JUMLAH COUNT
                    const SizedBox(width: 11),

                    Text(
                      '0',
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w500,
                        fontSize: 18.sp,
                      ),
                    ),

                    SizedBox(width: 11.w),
                    // BUTTON TAMBAH
                    Material(
                      child: InkWell(
                        splashColor: Colors.grey,
                        onTap: () {
                          // HomeController.to
                          //     .incrementOrder(idMenu: result.idMenu ?? 0);
                          Get.toNamed(AppRoutes.detailMenu, arguments: {'id_menu': result.idMenu});
                        },
                        child: SizedBox(
                          height: 21.w,
                          width: 21.w,
                          child: Image.asset(
                            AssetConts.iconTambah,
                          ),
                        ),
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
