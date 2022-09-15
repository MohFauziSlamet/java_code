// ignore_for_file: avoid_print

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:java_code/config/themes/colours.dart';
import 'package:java_code/constant/core/assets_const.dart';
import 'package:java_code/modules/features/detail_menu/controller/detail_menu_controller.dart';
import 'package:java_code/modules/features/detail_menu/view/component/button_card.dart';
import 'package:java_code/modules/features/detail_menu/view/component/custom_text_button.dart';
import 'package:java_code/modules/features/home/controllers/home_controller.dart';
import 'package:java_code/modules/features/no_connecntion/view/ui/no_connection_view.dart';
import 'package:java_code/modules/global_controllers/check_connection_controller.dart';
import 'package:java_code/modules/models/detail_menu_res/detail_menu_res.dart';
import 'package:java_code/shared/widgets/custom_snackbar.dart';
import 'package:java_code/shared/widgets/icon_notification.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class DetailMenuView extends StatelessWidget {
  const DetailMenuView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log('CEK DATA DARI ARGUMEN => DETAIL MENU VIEW');

    log('id_menu : ${Get.arguments['id_menu']}');
    Get.put(DetailMenuController());
    log('MEMANGGIL FUNCTION');
    var data =
        DetailMenuController.to.detailMenuRes(idMenu: Get.arguments['id_menu']);
    log('MEMANGGIL FUNCTION');
    log('HASIL PIPA TAMBAL : ${data}');
    return Scaffold(
      backgroundColor: Colours.bgColors,
      body: Obx(
        () => ConnectionManagerController.to.connectionType.value != 0
            ? GetBuilder<DetailMenuController>(
                builder: (_) => Conditional.single(
                  context: context,
                  conditionBuilder: (context) =>
                      DetailMenuController.to.detailMenuResult.data != null,
                  widgetBuilder: (context) => const DetailMenuSukses(),
                  fallbackBuilder: (context) => Center(
                    child: LoadingAnimationWidget.prograssiveDots(
                        color: Colours.green2, size: 100),
                  ),
                ),
              )
            : const NoConnectionView(),
      ),
    );
  }
}

// ignore: must_be_immutable
class DetailMenuSukses extends StatelessWidget {
  const DetailMenuSukses({
    Key? key,
  }) : super(key: key);
  // MENDAPATKAN INDEX DARI ARGUMENT
  // int index;
  @override
  Widget build(BuildContext context) {
    DetailMenuRes result = DetailMenuController.to.detailMenuResult;
    log('DATA DARI API');
    log('NAMA MENU DARI API ${result.data!.menu!.nama}');
    log('ID MENU DARI API ${result.data!.menu!.idMenu}');

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
                      if (HomeController.to
                              .getMenuByIdMenu(
                                  idMenu: result.data?.menu?.idMenu ?? 0)[0]
                              .count !=
                          0) {
                        Get.defaultDialog(
                          title: 'HALO',
                          middleText:
                              'Kamu belum menambahkan menu pada keranjang !',
                          actions: [
                            TextButton(
                              style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.r),
                                  side: const BorderSide(
                                    color: Colours.green2,
                                    width: 1,
                                  ),
                                ),
                              ),
                              onPressed: () {
                                Get.back();
                              },
                              child: const Text('Batal'),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colours.green2,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.r),
                                  side: const BorderSide(
                                    color: Colours.white,
                                    width: 1,
                                  ),
                                ),
                              ),
                              onPressed: () {
                                HomeController.to.insetMenuToBucketMenu(
                                    idMenu: result.data?.menu?.idMenu ?? 0);
                              },
                              child: const Text('Tambahkan'),
                            ),
                          ],
                        );
                      } else {
                        Get.back();
                      }
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
                              GetBuilder<HomeController>(
                                builder: (_) {
                                  return Material(
                                    child: SizedBox(
                                      height: 21.w,
                                      width: 21.w,
                                      child: Conditional.single(
                                        context: context,
                                        conditionBuilder: (context) =>
                                            HomeController.to
                                                .getMenuByIdMenu(
                                                    idMenu: result.data?.menu
                                                            ?.idMenu ??
                                                        0)[0]
                                                .count !=
                                            0,
                                        widgetBuilder: (context) => InkWell(
                                          splashColor: Colors.grey,
                                          onTap: () {
                                            if (HomeController.to
                                                    .getMenuByIdMenu(
                                                        idMenu: result
                                                                .data
                                                                ?.menu
                                                                ?.idMenu ??
                                                            0)[0]
                                                    .count !=
                                                0) {
                                              if (HomeController.to
                                                      .getMenuByIdMenu(
                                                          idMenu: result
                                                                  .data
                                                                  ?.menu
                                                                  ?.idMenu ??
                                                              0)[0]
                                                      .count ==
                                                  1) {
                                                Get.defaultDialog(
                                                  title: '',
                                                  content: Container(
                                                    width: 338.w,
                                                    height: 418.h,
                                                    decoration: BoxDecoration(
                                                      color: Colours.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30.r),
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        iconNotifcation(),
                                                        SizedBox(height: 30.h),
                                                        Text(
                                                          'Hapus item ?',
                                                          style: GoogleFonts
                                                              .montserrat(
                                                            fontSize: 20.sp,
                                                            color: Colours
                                                                .darkGrey,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ),
                                                        SizedBox(height: 15.h),
                                                        Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      40.sp),
                                                          child: RichText(
                                                            textAlign: TextAlign
                                                                .center,
                                                            text: TextSpan(
                                                                text:
                                                                    'Kamu akan mengeluarkan menu ini dari',
                                                                style: GoogleFonts
                                                                    .montserrat(
                                                                  fontSize:
                                                                      16.sp,
                                                                  color: Colours
                                                                      .darkGrey
                                                                      .withOpacity(
                                                                          0.5),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300,
                                                                ),
                                                                children: <
                                                                    TextSpan>[
                                                                  TextSpan(
                                                                    text:
                                                                        ' Pesanan',
                                                                    style: GoogleFonts
                                                                        .montserrat(
                                                                      fontSize:
                                                                          16.sp,
                                                                      color: Colours
                                                                          .grey,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                    ),
                                                                  )
                                                                ]),
                                                          ),
                                                        ),
                                                        SizedBox(height: 15.h),
                                                        Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      40.sp),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: [
                                                              SizedBox(
                                                                height: 40.h,
                                                                width: 100.w,
                                                                child:
                                                                    TextButton(
                                                                  style: TextButton
                                                                      .styleFrom(
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              30.r),
                                                                      side:
                                                                          const BorderSide(
                                                                        color: Colours
                                                                            .green2,
                                                                        width:
                                                                            1,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    HomeController
                                                                        .to
                                                                        .decrementOrder(
                                                                            idMenu:
                                                                                result.data?.menu?.idMenu ?? 0);
                                                                    Get.back();
                                                                  },
                                                                  child:
                                                                      const Text(
                                                                          'Oke'),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 40.h,
                                                                width: 100.w,
                                                                child:
                                                                    ElevatedButton(
                                                                  style: ElevatedButton
                                                                      .styleFrom(
                                                                    primary: Colours
                                                                        .green2,
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              30.r),
                                                                      side:
                                                                          const BorderSide(
                                                                        color: Colours
                                                                            .white,
                                                                        width:
                                                                            1,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    Get.back();
                                                                  },
                                                                  child: const Text(
                                                                      'Kembali'),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              } else {
                                                HomeController.to
                                                    .decrementOrder(
                                                        idMenu: result
                                                                .data
                                                                ?.menu
                                                                ?.idMenu ??
                                                            0);
                                              }
                                            } else {
                                              CustomSnackbar().snackBar(
                                                title: 'Perhatian',
                                                message: 'Counter sudah nol',
                                              );
                                            }
                                          },
                                          child: Image.asset(
                                            AssetConts.iconKurang,
                                          ),
                                        ),
                                        fallbackBuilder: (context) => Container(
                                          color: Colours.white,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),

                              // NOMINAL COUNT
                              const SizedBox(width: 11),
                              GetBuilder<HomeController>(
                                builder: (_) => Text(
                                  '${HomeController.to.getMenuByIdMenu(idMenu: result.data?.menu?.idMenu ?? 0)[0].count}',
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18.sp,
                                  ),
                                ),
                              ),

                              const SizedBox(width: 11),
                              // BUTTON TAMBAH
                              Material(
                                child: InkWell(
                                  splashColor: Colors.grey,
                                  onTap: () {
                                    HomeController.to.incrementOrder(
                                        idMenu: result.data?.menu?.idMenu ?? 0);

                                    print(
                                        'YOK BISA YOK == ${HomeController.to.getMenuByIdMenu(idMenu: result.data?.menu?.idMenu ?? 0)[0].nama!} - ${HomeController.to.getMenuByIdMenu(idMenu: result.data?.menu?.idMenu ?? 0)[0].count!}');
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
                      Conditional.single(
                        context: context,
                        conditionBuilder: (context) =>
                            result.data!.level!.isNotEmpty,
                        widgetBuilder: (context) => ButtonCard(
                          stringIcon: AssetConts.iconLevel,
                          widthIcon: 20.w,
                          heightIcon: 20.w,
                          nama: 'Level',
                          child: customTextButton(
                            nama: DetailMenuController.to.keteranganLevel.value,
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
                                            SizedBox(
                                              height: 25.h,
                                              width: ScreenUtil().screenWidth,
                                              child: ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount: result
                                                        .data?.level?.length ??
                                                    0,
                                                itemBuilder: (context, index) {
                                                  // MENGAMBL LIST INDEX LEVEL
                                                  var listIndex =
                                                      DetailMenuController
                                                          .to.listIndexLevel;
                                                  return Obx(
                                                    () => InkWell(
                                                      onTap: () {
                                                        listIndex.value = index;
                                                        DetailMenuController
                                                                .to
                                                                .keteranganLevel
                                                                .value =
                                                            result
                                                                .data!
                                                                .level![index]
                                                                .keterangan!;
                                                      },
                                                      child: Container(
                                                        width: 48.w,
                                                        height: 25.h,
                                                        margin: EdgeInsets.only(
                                                            left: 10.sp),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: listIndex
                                                                      .value ==
                                                                  index
                                                              ? Colours.green2
                                                              : Colours.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      30.sp),
                                                          border: Border.all(
                                                            color: listIndex
                                                                        .value ==
                                                                    index
                                                                ? Colours.white
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
                                                                fontSize: 12.sp,
                                                                color: listIndex
                                                                            .value ==
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
                        fallbackBuilder: (context) => const SizedBox(),
                      ),
                      // ButtonCard(
                      //   stringIcon: AssetConts.iconLevel,
                      //   widthIcon: 20.w,
                      //   heightIcon: 20.w,
                      //   nama: 'Level',
                      //   child: Obx(
                      //     () => customTextButton(
                      //         nama:
                      //             DetailMenuController.to.keteranganLevel.value,
                      //         ontap: () {
                      //           Get.bottomSheet(
                      //             barrierColor: Colours.grey.withOpacity(0.5),
                      //             Container(
                      //               height: 120.h,
                      //               width: ScreenUtil().screenWidth,
                      //               decoration: BoxDecoration(
                      //                 color: Colours.white,
                      //                 borderRadius: BorderRadius.only(
                      //                   topLeft: Radius.circular(30.r),
                      //                   topRight: Radius.circular(30.r),
                      //                 ),
                      //               ),
                      //               child: Column(
                      //                 crossAxisAlignment:
                      //                     CrossAxisAlignment.start,
                      //                 children: [
                      //                   SizedBox(height: 19.h),
                      //                   Center(
                      //                     child: Container(
                      //                       width: 104.w,
                      //                       height: 4.h,
                      //                       decoration: BoxDecoration(
                      //                         color: const Color(0xffC4C4C4)
                      //                             .withOpacity(0.5),
                      //                         borderRadius:
                      //                             BorderRadius.circular(30),
                      //                       ),
                      //                     ),
                      //                   ),
                      //                   SizedBox(height: 13.h),
                      //                   Container(
                      //                     margin: EdgeInsets.only(left: 17.sp),
                      //                     child: Column(
                      //                       mainAxisAlignment:
                      //                           MainAxisAlignment.start,
                      //                       crossAxisAlignment:
                      //                           CrossAxisAlignment.start,
                      //                       children: [
                      //                         Text(
                      //                           "Pilih Level",
                      //                           style: GoogleFonts.montserrat(
                      //                             fontWeight: FontWeight.w700,
                      //                             fontSize: 18.sp,
                      //                             color: Colours.darkGrey,
                      //                           ),
                      //                         ),
                      //                         SizedBox(height: 17.sp),
                      //                         // LIST LEVEL
                      //                         Conditional.single(
                      //                           context: context,
                      //                           conditionBuilder: (context) =>
                      //                               result.data!.level!
                      //                                   .isNotEmpty,
                      //                           widgetBuilder: (context) =>
                      //                               SizedBox(
                      //                             height: 25.h,
                      //                             width:
                      //                                 ScreenUtil().screenWidth,
                      //                             child: ListView.builder(
                      //                               scrollDirection:
                      //                                   Axis.horizontal,
                      //                               itemCount: result.data
                      //                                       ?.level?.length ??
                      //                                   0,
                      //                               itemBuilder:
                      //                                   (context, index) {
                      //                                 // MENGAMBL LIST INDEX LEVEL
                      //                                 var listIndex =
                      //                                     DetailMenuController
                      //                                         .to
                      //                                         .listIndexLevel;
                      //                                 return Obx(
                      //                                   () => InkWell(
                      //                                     onTap: () {
                      //                                       listIndex.value =
                      //                                           index;
                      //                                       DetailMenuController
                      //                                               .to
                      //                                               .keteranganLevel
                      //                                               .value =
                      //                                           result
                      //                                               .data!
                      //                                               .level![
                      //                                                   index]
                      //                                               .keterangan!;
                      //                                     },
                      //                                     child: Container(
                      //                                       width: 48.w,
                      //                                       height: 25.h,
                      //                                       margin:
                      //                                           EdgeInsets.only(
                      //                                               left:
                      //                                                   10.sp),
                      //                                       decoration:
                      //                                           BoxDecoration(
                      //                                         color: listIndex
                      //                                                     .value ==
                      //                                                 index
                      //                                             ? Colours
                      //                                                 .green2
                      //                                             : Colours
                      //                                                 .white,
                      //                                         borderRadius:
                      //                                             BorderRadius
                      //                                                 .circular(
                      //                                                     30.sp),
                      //                                         border:
                      //                                             Border.all(
                      //                                           color: listIndex
                      //                                                       .value ==
                      //                                                   index
                      //                                               ? Colours
                      //                                                   .white
                      //                                               : Colours
                      //                                                   .green2,
                      //                                         ),
                      //                                       ),
                      //                                       child: Row(
                      //                                         mainAxisAlignment:
                      //                                             MainAxisAlignment
                      //                                                 .center,
                      //                                         children: [
                      //                                           Text(
                      //                                             "${result.data!.level![index].keterangan} ",
                      //                                             style: GoogleFonts
                      //                                                 .montserrat(
                      //                                               fontWeight:
                      //                                                   FontWeight
                      //                                                       .w400,
                      //                                               fontSize:
                      //                                                   12.sp,
                      //                                               color: listIndex.value ==
                      //                                                       index
                      //                                                   ? Colours
                      //                                                       .white
                      //                                                   : Colours
                      //                                                       .darkGrey,
                      //                                             ),
                      //                                           ),
                      //                                           Image.asset(
                      //                                             AssetConts
                      //                                                 .iconCeklis,
                      //                                             width: 12.w,
                      //                                           )
                      //                                         ],
                      //                                       ),
                      //                                     ),
                      //                                   ),
                      //                                 );
                      //                               },
                      //                             ),
                      //                           ),
                      //                           fallbackBuilder: (context) =>
                      //                               Center(
                      //                             child: Text(
                      //                               "Tidak ada level untuk menu ini",
                      //                               style:
                      //                                   GoogleFonts.montserrat(
                      //                                 fontWeight:
                      //                                     FontWeight.w400,
                      //                                 fontSize: 18.sp,
                      //                                 color: Colours.darkGrey,
                      //                               ),
                      //                             ),
                      //                           ),
                      //                         ),
                      //                       ],
                      //                     ),
                      //                   )
                      //                 ],
                      //               ),
                      //             ),
                      //           );
                      //         }),
                      //   ),
                      // ),

                      /// BUTTON TOPPING
                      Conditional.single(
                        context: context,
                        conditionBuilder: (context) =>
                            result.data!.topping!.isNotEmpty,
                        widgetBuilder: (context) => ButtonCard(
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
                        fallbackBuilder: (context) => const SizedBox(),
                      ),

                      // ButtonCard(
                      //   stringIcon: AssetConts.iconTopping,
                      //   widthIcon: 18.w,
                      //   heightIcon: 18.w,
                      //   nama: 'Topping',
                      //   child: Obx(
                      //     () => customTextButton(
                      //         nama: DetailMenuController
                      //             .to.keteranganToping.value,
                      //         ontap: () {
                      //           Get.bottomSheet(
                      //             barrierColor: Colours.grey.withOpacity(0.5),
                      //             Container(
                      //               height: 120.h,
                      //               width: ScreenUtil().screenWidth,
                      //               decoration: BoxDecoration(
                      //                 color: Colours.white,
                      //                 borderRadius: BorderRadius.only(
                      //                   topLeft: Radius.circular(30.r),
                      //                   topRight: Radius.circular(30.r),
                      //                 ),
                      //               ),
                      //               child: Column(
                      //                 crossAxisAlignment:
                      //                     CrossAxisAlignment.start,
                      //                 children: [
                      //                   SizedBox(height: 19.h),
                      //                   // GARIS TENGAH
                      //                   Center(
                      //                     child: Container(
                      //                       width: 104.w,
                      //                       height: 4.h,
                      //                       decoration: BoxDecoration(
                      //                         color: const Color(0xffC4C4C4)
                      //                             .withOpacity(0.5),
                      //                         borderRadius:
                      //                             BorderRadius.circular(30),
                      //                       ),
                      //                     ),
                      //                   ),
                      //                   SizedBox(height: 13.h),
                      //                   Container(
                      //                     margin: EdgeInsets.only(
                      //                         left: 17.sp, right: 17.sp),
                      //                     child: Column(
                      //                       mainAxisAlignment:
                      //                           MainAxisAlignment.start,
                      //                       crossAxisAlignment:
                      //                           CrossAxisAlignment.start,
                      //                       children: [
                      //                         // TEXT TOPPING
                      //                         Text(
                      //                           "Pilih Toping",
                      //                           style: GoogleFonts.montserrat(
                      //                             fontWeight: FontWeight.w700,
                      //                             fontSize: 18,
                      //                             color: Colours.darkGrey,
                      //                           ),
                      //                         ),
                      //                         SizedBox(height: 17.sp),
                      //                         // PILIH TOPPING
                      //                         Conditional.single(
                      //                           context: context,
                      //                           conditionBuilder: (context) =>
                      //                               result.data!.topping!
                      //                                   .isNotEmpty,
                      //                           widgetBuilder: (context) =>
                      //                               SizedBox(
                      //                             height: 25.h,
                      //                             width:
                      //                                 ScreenUtil().screenWidth,
                      //                             child: Row(
                      //                               mainAxisAlignment:
                      //                                   MainAxisAlignment
                      //                                       .spaceBetween,
                      //                               children: [
                      //                                 Expanded(
                      //                                   child: ListView.builder(
                      //                                     scrollDirection:
                      //                                         Axis.horizontal,
                      //                                     itemCount: result
                      //                                             .data
                      //                                             ?.topping
                      //                                             ?.length ??
                      //                                         0,
                      //                                     itemBuilder:
                      //                                         (context, index) {
                      //                                       // MENGAMBL LIST INDEX LEVEL
                      //                                       var listIndex =
                      //                                           DetailMenuController
                      //                                               .to
                      //                                               .listIndexToping;
                      //                                       return Obx(
                      //                                         () => Row(
                      //                                           children: [
                      //                                             InkWell(
                      //                                               onTap: () {
                      //                                                 listIndex
                      //                                                         .value =
                      //                                                     index;
                      //                                                 DetailMenuController
                      //                                                     .to
                      //                                                     .keteranganToping
                      //                                                     .value = result
                      //                                                         .data!
                      //                                                         .topping![index]
                      //                                                     [
                      //                                                     'keterangan'];
                      //                                               },
                      //                                               child:
                      //                                                   Container(
                      //                                                 width:
                      //                                                     94.w,
                      //                                                 height:
                      //                                                     25.h,
                      //                                                 margin: EdgeInsets.only(
                      //                                                     left:
                      //                                                         10.sp),
                      //                                                 decoration:
                      //                                                     BoxDecoration(
                      //                                                   color: listIndex.value ==
                      //                                                           index
                      //                                                       ? Colours.green2
                      //                                                       : Colours.white,
                      //                                                   borderRadius:
                      //                                                       BorderRadius.circular(30.sp),
                      //                                                   border:
                      //                                                       Border.all(
                      //                                                     color: listIndex.value == index
                      //                                                         ? Colours.white
                      //                                                         : Colours.green2,
                      //                                                   ),
                      //                                                 ),
                      //                                                 child:
                      //                                                     Row(
                      //                                                   mainAxisAlignment:
                      //                                                       MainAxisAlignment.center,
                      //                                                   children: [
                      //                                                     Text(
                      //                                                       "${result.data!.topping![index]['keterangan']} ",
                      //                                                       style:
                      //                                                           GoogleFonts.montserrat(
                      //                                                         fontWeight: FontWeight.w400,
                      //                                                         fontSize: 12.sp,
                      //                                                         color: listIndex.value == index ? Colours.white : Colours.darkGrey,
                      //                                                       ),
                      //                                                     ),
                      //                                                     Image
                      //                                                         .asset(
                      //                                                       AssetConts.iconCeklis,
                      //                                                       width:
                      //                                                           12.w,
                      //                                                     )
                      //                                                   ],
                      //                                                 ),
                      //                                               ),
                      //                                             ),
                      //                                             //
                      //                                           ],
                      //                                         ),
                      //                                       );
                      //                                     },
                      //                                   ),
                      //                                 ),
                      //                                 Conditional.single(
                      //                                   context: context,
                      //                                   conditionBuilder:
                      //                                       (context) => result
                      //                                           .data!
                      //                                           .topping!
                      //                                           .isNotEmpty,
                      //                                   widgetBuilder:
                      //                                       (context) =>
                      //                                           SizedBox(
                      //                                     width: 94.w,
                      //                                     height: 25.h,
                      //                                     child: ElevatedButton(
                      //                                       onPressed: () {
                      //                                         DetailMenuController
                      //                                                 .to
                      //                                                 .keteranganToping
                      //                                                 .value =
                      //                                             'Anda Belum Memilih';
                      //                                         Get.back();
                      //                                       },
                      //                                       style:
                      //                                           ElevatedButton
                      //                                               .styleFrom(
                      //                                         primary: Colours
                      //                                             .green2,
                      //                                         shape:
                      //                                             RoundedRectangleBorder(
                      //                                           borderRadius:
                      //                                               BorderRadius
                      //                                                   .circular(
                      //                                                       30.r),
                      //                                         ),
                      //                                       ),
                      //                                       child: const Text(
                      //                                           'Batal'),
                      //                                     ),
                      //                                   ),
                      //                                   fallbackBuilder:
                      //                                       (context) =>
                      //                                           const SizedBox(),
                      //                                 ),
                      //                               ],
                      //                             ),
                      //                           ),
                      //                           fallbackBuilder: (context) =>
                      //                               Center(
                      //                             child: Text(
                      //                               "Tidak ada topping untuk menu ini",
                      //                               style:
                      //                                   GoogleFonts.montserrat(
                      //                                 fontWeight:
                      //                                     FontWeight.w400,
                      //                                 fontSize: 18.sp,
                      //                                 color: Colours.darkGrey,
                      //                               ),
                      //                             ),
                      //                           ),
                      //                         ),
                      //                       ],
                      //                     ),
                      //                   )
                      //                 ],
                      //               ),
                      //             ),
                      //           );
                      //         }),
                      //   ),
                      // ),

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
                      GetBuilder<HomeController>(
                        initState: (_) {},
                        builder: (_) {
                          return Container(
                            height: 44.h,
                            width: ScreenUtil().screenWidth,
                            margin: EdgeInsets.only(right: 23.sp),
                            child: ElevatedButton(
                              onPressed: () {
                                HomeController.to.insetMenuToBucketMenu(
                                    idMenu: result.data?.menu?.idMenu ?? 0);
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 5.sp,
                                primary: HomeController.to
                                            .getMenuByIdMenu(
                                                idMenu:
                                                    result.data?.menu?.idMenu ??
                                                        0)[0]
                                            .count !=
                                        0
                                    ? Colours.green2
                                    : Colours.grey,
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
                          );
                        },
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
