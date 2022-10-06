import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:java_code/config/themes/colours.dart';
import 'package:java_code/constant/core/assets_const.dart';
import 'package:java_code/modules/features/detail_menu/view/component/button_card.dart';
import 'package:java_code/modules/features/detail_menu/view/component/custom_text_button.dart';
import 'package:java_code/modules/features/no_connecntion/view/ui/no_connection_view.dart';
import 'package:java_code/modules/features/pesanan/controller/detail_menu_in_pesanan_controller.dart';
import 'package:java_code/modules/features/pesanan/controller/pesanan_controller.dart';
import 'package:java_code/modules/global_controllers/check_connection_controller.dart';
import 'package:java_code/modules/models/detail_menu_res/detail_menu_res.dart';
import 'package:java_code/utils/extensions/currency_format_to_idr.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class DetailMenuViewInPesanan extends StatelessWidget {
  const DetailMenuViewInPesanan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(DetailMenuInPesananController());

    return Scaffold(
      backgroundColor: Colours.bgColors,
      body: Obx(
        () => ConnectionManagerController.to.connectionType.value != 0
            ? GetBuilder<DetailMenuInPesananController>(
                builder: (_) => Conditional.single(
                  context: context,
                  conditionBuilder: (context) =>
                      DetailMenuInPesananController.to.detailMenuResult?.data !=
                      null,
                  widgetBuilder: (context) =>
                      DetailMenuSukses(index: Get.arguments['index']),
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
  DetailMenuSukses({
    Key? key,
    required this.index,
  }) : super(key: key);
  // MENDAPATKAN INDEX DARI ARGUMENT
  int index;
  @override
  Widget build(BuildContext context) {
    // MenuHive menuHIve = DetailMenuInPesananController.to.menuHive;
    DetailMenuRes result = DetailMenuInPesananController.to.detailMenuResult!;

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
                  child: FadeInImage(
                    fit: BoxFit.contain,
                    placeholder: const AssetImage(AssetConts.gifLoadingImage),
                    image: NetworkImage(
                      result.data!.menu!.foto!,
                    ),
                    imageErrorBuilder: (context, error, stackTrace) =>
                        Image.asset(AssetConts.iconEmptyMenu,
                            fit: BoxFit.cover),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 25.h),

          /// BOX DETAIL MENU
          GetBuilder<DetailMenuInPesananController>(
            builder: (value) => Container(
              height: 630.h,
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
                    margin: EdgeInsets.only(left: 25.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// NAMA MENU DAN BUTTON COUNTER
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // NAMA MENU
                            Text(
                              value.menuHive.nama,
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
                                GetBuilder<PesananController>(
                                  builder: (value) {
                                    return Material(
                                      child: SizedBox(
                                        height: 21.w,
                                        width: 21.w,
                                        child: Conditional.single(
                                          context: context,
                                          conditionBuilder: (context) =>
                                              value.menuHive![index].jumlah !=
                                              0,
                                          widgetBuilder: (context) => InkWell(
                                            splashColor: Colors.grey,
                                            onTap: () {
                                              value.subtractAmount(
                                                  index: index);
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
                                    );
                                  },
                                ),

                                // NOMINAL COUNT
                                const SizedBox(width: 11),
                                GetBuilder<PesananController>(builder: (value) {
                                  return Text(
                                    '${value.menuHive?[index].jumlah ?? 0}',
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18.sp,
                                    ),
                                  );
                                }),
                                // GetBuilder<HomeController>(
                                //   builder: (_) => Text(
                                //     '${HomeController.to.getMenuByIdMenu(idMenu: result.data?.menu?.idMenu ?? 0)[0].count}',
                                //     style: GoogleFonts.montserrat(
                                //       fontWeight: FontWeight.w500,
                                //       fontSize: 18.sp,
                                //     ),
                                //   ),
                                // ),

                                const SizedBox(width: 11),
                                // BUTTON TAMBAH
                                GetBuilder<PesananController>(builder: (value) {
                                  return Material(
                                    child: InkWell(
                                      splashColor: Colors.grey,
                                      onTap: () {
                                        value.addAmount(index: index);
                                      },
                                      child: SizedBox(
                                        height: 21.w,
                                        width: 21.w,
                                        child: Image.asset(
                                          AssetConts.iconTambah,
                                        ),
                                      ),
                                    ),
                                  );
                                }),

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
                          child: GetBuilder<PesananController>(
                            builder: (value) {
                              return Text(
                                CurrencyFormat.convertToIdr(
                                    value.menuHive![index].harga ?? 0, 2),
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20.sp,
                                  color: Colours.green2,
                                ),
                              );
                            },
                          ),
                        ),

                        /// BUTTON LEVEL
                        GetBuilder<DetailMenuInPesananController>(
                          builder: (value) => Conditional.single(
                            context: context,
                            conditionBuilder: (context) =>
                                result.data?.level != null,
                            widgetBuilder: (context) => ButtonCard(
                              stringIcon: AssetConts.iconLevel,
                              widthIcon: 20.w,
                              heightIcon: 20.w,
                              nama: 'Level',
                              child: customTextButton(
                                nama: value.menuHive.keteranganLevel,
                                ontap: () {
                                  Get.bottomSheet(
                                    barrierColor: Colours.grey.withOpacity(0.5),
                                    ShowLevelBottomSheet(result: result),
                                  );
                                },
                              ),
                            ),
                            fallbackBuilder: (context) => const SizedBox(),
                          ),
                        ),

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
                            child: GetBuilder<DetailMenuInPesananController>(
                              builder: (controller) => customTextButton(
                                  nama: DetailMenuInPesananController.to
                                      .getToppingName(
                                          DetailMenuInPesananController
                                              .to.menuHive.toppingDetail!
                                              .map((e) => e.keterangan)
                                              .toList()),
                                  ontap: () {
                                    Get.bottomSheet(
                                      barrierColor:
                                          Colours.grey.withOpacity(0.5),
                                      ShowTopingBottomSheet(result: result),
                                    );
                                  }),
                            ),
                          ),
                          fallbackBuilder: (context) => const SizedBox(),
                        ),

                        /// CATATAN
                        GetBuilder<DetailMenuInPesananController>(
                          builder: (controller) => ButtonCard(
                            stringIcon: AssetConts.iconCatatan,
                            widthIcon: 20.w,
                            heightIcon: 22.w,
                            nama: 'Catatan',
                            child: customTextButton(
                              nama: DetailMenuInPesananController
                                      .to.menuHive.catatan.isEmpty
                                  ? 'Tambahkan Catatan...'
                                  : DetailMenuInPesananController
                                      .to.menuHive.catatan,
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
                                                    child: TextField(
                                                      maxLines: 1,
                                                      controller:
                                                          DetailMenuInPesananController
                                                              .to
                                                              .catatanController,
                                                      onChanged: (value) {
                                                        DetailMenuInPesananController
                                                            .to
                                                            .onChangedCatatan(
                                                                value);
                                                      },
                                                      autofocus: true,
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
                                                            BorderRadius
                                                                .circular(24),
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
                        GetBuilder<DetailMenuInPesananController>(
                          builder: (value) {
                            return Container(
                              height: 44.h,
                              width: ScreenUtil().screenWidth,
                              margin: EdgeInsets.only(right: 23.sp),
                              child: ElevatedButton(
                                onPressed: () async {
                                  Get.back();
                                  // value.simpanEditMenu();
                                },
                                style: ElevatedButton.styleFrom(
                                  elevation: 5.sp,
                                  primary: Colours.green2,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.r),
                                  ),
                                ),
                                child: Text(
                                  "Simpan",
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
          ),
        ],
      ),
    );
  }
}

class ShowTopingBottomSheet extends StatelessWidget {
  const ShowTopingBottomSheet({
    Key? key,
    required this.result,
  }) : super(key: key);

  final DetailMenuRes result;

  @override
  Widget build(BuildContext context) {
    return Container(
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 19.h),
          // GARIS TENGAH
          Center(
            child: Container(
              width: 104.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: const Color(0xffC4C4C4).withOpacity(0.5),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
          SizedBox(height: 13.h),
          Container(
            margin: EdgeInsets.only(left: 17.sp, right: 17.sp),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
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
                  height: 25,
                  child: ListView.builder(
                    itemCount: DetailMenuInPesananController
                        .to.detailMenuResult?.data?.topping?.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          DetailMenuInPesananController.to.addTopping(
                              DetailMenuInPesananController
                                  .to.detailMenuResult!.data!.topping![index],
                              index);
                          Get.back();
                        },
                        child: levelItem(
                            text: DetailMenuInPesananController
                                    .to
                                    .detailMenuResult!
                                    .data
                                    ?.topping?[index]
                                    .keterangan ??
                                "none",
                            selected: DetailMenuInPesananController
                                    .to
                                    .detailMenuResult!
                                    .data
                                    ?.topping?[index]
                                    .isSelected ??
                                false),
                      );
                    },
                  ),
                )
                // SizedBox(
                //   height: 25.h,
                //   width: ScreenUtil().screenWidth,
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Expanded(
                //         child: ListView.builder(
                //           scrollDirection: Axis.horizontal,
                //           itemCount: result.data?.topping?.length ?? 0,
                //           itemBuilder: (context, index) {
                //             // MENGAMBL LIST INDEX LEVEL
                //             var listIndex =
                //                 DetailMenuController.to.listIndexToping;
                //             return Obx(
                //               () => Row(
                //                 children: [
                //                   InkWell(
                //                     onTap: () {
                //                       listIndex.value = index;
                //                       DetailMenuController
                //                               .to.keteranganToping.value =
                //                           result.data!.topping![index]
                //                               ['keterangan'];
                //                     },
                //                     child: Container(
                //                       width: 94.w,
                //                       height: 25.h,
                //                       margin: EdgeInsets.only(left: 10.sp),
                //                       decoration: BoxDecoration(
                //                         color: listIndex.value == index
                //                             ? Colours.green2
                //                             : Colours.white,
                //                         borderRadius:
                //                             BorderRadius.circular(30.sp),
                //                         border: Border.all(
                //                           color: listIndex.value == index
                //                               ? Colours.white
                //                               : Colours.green2,
                //                         ),
                //                       ),
                //                       child: Row(
                //                         mainAxisAlignment:
                //                             MainAxisAlignment.center,
                //                         children: [
                //                           Text(
                //                             "${result.data!.topping![index]['keterangan']} ",
                //                             style: GoogleFonts.montserrat(
                //                               fontWeight: FontWeight.w400,
                //                               fontSize: 12.sp,
                //                               color: listIndex.value == index
                //                                   ? Colours.white
                //                                   : Colours.darkGrey,
                //                             ),
                //                           ),
                //                           Image.asset(
                //                             AssetConts.iconCeklis,
                //                             width: 12.w,
                //                           )
                //                         ],
                //                       ),
                //                     ),
                //                   ),
                //                   //
                //                 ],
                //               ),
                //             );
                //           },
                //         ),
                //       ),
                //       Conditional.single(
                //         context: context,
                //         conditionBuilder: (context) =>
                //             result.data!.topping!.isNotEmpty,
                //         widgetBuilder: (context) => SizedBox(
                //           width: 94.w,
                //           height: 25.h,
                //           child: ElevatedButton(
                //             onPressed: () {
                //               DetailMenuController.to.keteranganToping.value =
                //                   'Anda Belum Memilih';
                //               Get.back();
                //             },
                //             style: ElevatedButton.styleFrom(
                //               primary: Colours.green2,
                //               shape: RoundedRectangleBorder(
                //                 borderRadius: BorderRadius.circular(30.r),
                //               ),
                //             ),
                //             child: const Text('Batal'),
                //           ),
                //         ),
                //         fallbackBuilder: (context) => const SizedBox(),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ShowLevelBottomSheet extends StatelessWidget {
  const ShowLevelBottomSheet({
    Key? key,
    required this.result,
  }) : super(key: key);

  final DetailMenuRes result;

  @override
  Widget build(BuildContext context) {
    return Container(
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 19.h),
          Center(
            child: Container(
              width: 104.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: const Color(0xffC4C4C4).withOpacity(0.5),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
          SizedBox(height: 13.h),
          Container(
            margin: EdgeInsets.only(left: 17.sp, right: 17.sp),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
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
                    scrollDirection: Axis.horizontal,
                    itemCount: result.data?.level?.length ?? 0,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          DetailMenuInPesananController.to.chooseLevel(
                            DetailMenuInPesananController
                                .to.detailMenuResult!.data!.level![index],
                          );
                          Get.back();
                        },
                        child: levelItem(
                            text: DetailMenuInPesananController
                                    .to
                                    .detailMenuResult!
                                    .data
                                    ?.level?[index]
                                    .keterangan ??
                                "none",
                            selected: DetailMenuInPesananController
                                    .to
                                    .detailMenuResult!
                                    .data
                                    ?.level?[index]
                                    .idDetail ==
                                DetailMenuInPesananController
                                    .to.menuHive.level),
                        // Container(
                        //   width: 48.w,
                        //   height: 25.h,
                        //   margin:
                        //       EdgeInsets.only(
                        //           left: 10.sp),
                        //   decoration:
                        //       BoxDecoration(
                        //     color: listIndex
                        //                 .value ==
                        //             index
                        //         ? Colours.green2
                        //         : Colours.white,
                        //     borderRadius:
                        //         BorderRadius
                        //             .circular(
                        //                 30.sp),
                        //     border: Border.all(
                        //       color: listIndex
                        //                   .value ==
                        //               index
                        //           ? Colours
                        //               .white
                        //           : Colours
                        //               .green2,
                        //     ),
                        //   ),
                        //   child: Row(
                        //     mainAxisAlignment:
                        //         MainAxisAlignment
                        //             .center,
                        //     children: [
                        //       Text(
                        //         "${result.data!.level![index].keterangan} ",
                        //         style: GoogleFonts
                        //             .montserrat(
                        //           fontWeight:
                        //               FontWeight
                        //                   .w400,
                        //           fontSize:
                        //               12.sp,
                        //           color: listIndex
                        //                       .value ==
                        //                   index
                        //               ? Colours
                        //                   .white
                        //               : Colours
                        //                   .darkGrey,
                        //         ),
                        //       ),
                        //       Image.asset(
                        //         AssetConts
                        //             .iconCeklis,
                        //         width: 12.w,
                        //       )
                        //     ],
                        //   ),
                        // ),
                      );
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

Container levelItem({required String text, required bool selected}) {
  return Container(
    height: 25,
    decoration: BoxDecoration(
      color: selected ? Colours.green2 : Colors.white,
      borderRadius: const BorderRadius.all(
        Radius.circular(50),
      ),
      border: Border.all(color: selected ? Colors.white : Colours.green2),
    ),
    margin: const EdgeInsets.only(right: 8),
    padding: const EdgeInsets.symmetric(horizontal: 12),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Text(
            text,
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 12,
                color: selected ? Colors.white : Colors.black),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 4),
          child: selected
              ? const Icon(
                  Icons.check,
                  size: 18,
                  color: Colors.white,
                )
              : const SizedBox.shrink(),
        )
      ],
    ),
  );
}
