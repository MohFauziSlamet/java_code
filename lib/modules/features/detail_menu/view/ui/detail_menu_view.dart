import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:java_code/config/routes/app_routes.dart';
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
import 'package:java_code/utils/extensions/currency_format_to_idr.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class DetailMenuView extends StatelessWidget {
  const DetailMenuView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(DetailMenuController());

    return Scaffold(
      backgroundColor: Colours.bgColors,
      body: Obx(
        () => ConnectionManagerController.to.connectionType.value != 0
            ? GetBuilder<DetailMenuController>(
                builder: (_) => Conditional.single(
                  context: context,
                  conditionBuilder: (context) => DetailMenuController.to.detailMenuResult.data != null,
                  widgetBuilder: (context) => const DetailMenuSukses(),
                  fallbackBuilder: (context) => Center(
                    child: LoadingAnimationWidget.prograssiveDots(color: Colours.green2, size: 100),
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
                      // if (HomeController.to
                      //         .getMenuByIdMenu(
                      //             idMenu: result.data?.menu?.idMenu ?? 0)[0]
                      //         .count !=
                      //     0) {
                      //   Get.defaultDialog(
                      //     title: 'HALO',
                      //     middleText:
                      //         'Kamu belum menambahkan menu pada keranjang !',
                      //     actions: [
                      //       TextButton(
                      //         style: TextButton.styleFrom(
                      //           shape: RoundedRectangleBorder(
                      //             borderRadius: BorderRadius.circular(30.r),
                      //             side: const BorderSide(
                      //               color: Colours.green2,
                      //               width: 1,
                      //             ),
                      //           ),
                      //         ),
                      //         onPressed: () {
                      //           Get.back();
                      //         },
                      //         child: const Text('Batal'),
                      //       ),
                      //       ElevatedButton(
                      //         style: ElevatedButton.styleFrom(
                      //           primary: Colours.green2,
                      //           shape: RoundedRectangleBorder(
                      //             borderRadius: BorderRadius.circular(30.r),
                      //             side: const BorderSide(
                      //               color: Colours.white,
                      //               width: 1,
                      //             ),
                      //           ),
                      //         ),
                      //         onPressed: () {
                      //           // HomeController.to.insetMenuToBucketMenu(
                      //           //     idMenu: result.data?.menu?.idMenu ?? 0);
                      //           HomeController.to.listMenuBucket;
                      //         },
                      //         child: const Text('Tambahkan'),
                      //       ),
                      //     ],
                      //   );
                      // } else {
                      //   Get.back();
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
                      "detail_menu".tr,
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
                    image: NetworkImage("${result.data?.menu?.foto}"),
                    imageErrorBuilder: (context, error, stackTrace) => Image.asset(AssetConts.iconEmptyMenu, fit: BoxFit.contain),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 25.h),

          /// BOX DETAIL MENU
          Container(
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
                            result.data?.menu?.nama ?? "Title of Menu",
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
                                        conditionBuilder: (context) => DetailMenuController.to.menuHive.jumlah != 1,
                                        widgetBuilder: (context) => InkWell(
                                          splashColor: Colors.grey,
                                          onTap: () {
                                            if (DetailMenuController.to.menuHive.jumlah != 1) {
                                              if (DetailMenuController.to.menuHive.jumlah == 2) {
                                                Get.defaultDialog(
                                                  title: '',
                                                  content: DialogNotifDeleteCountOrderIfOne(result: result),
                                                );
                                              } else {
                                                DetailMenuController.to.subtractAmount();
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
                              GetBuilder<DetailMenuController>(
                                builder: (_) => Text(
                                  '${DetailMenuController.to.menuHive.jumlah}',
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
                                    HomeController.to.incrementOrder(idMenu: result.data?.menu?.idMenu ?? 0);

                                    DetailMenuController.to.addAmount();
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
                          result.data?.menu?.deskripsi ?? 'Menu enak sehat dan bergizi',
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
                        nama: 'price'.tr,
                        child: GetBuilder<DetailMenuController>(
                          builder: (_) {
                            return Text(
                              CurrencyFormat.convertToIdr(DetailMenuController.to.menuHive.harga ?? 0, 2),
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
                      Conditional.single(
                        context: context,
                        conditionBuilder: (context) => result.data!.level!.isNotEmpty,
                        widgetBuilder: (context) => ButtonCard(
                          stringIcon: AssetConts.iconLevel,
                          widthIcon: 20.w,
                          heightIcon: 20.w,
                          nama: 'choose_level'.tr,
                          child: GetBuilder<DetailMenuController>(
                            builder: (controller) => customTextButton(
                              nama: DetailMenuController.to.menuHive.keteranganLevel,
                              ontap: () {
                                Get.bottomSheet(
                                  barrierColor: Colours.grey.withOpacity(0.5),
                                  ShowLevelBottomSheet(result: result),
                                );
                              },
                            ),
                          ),
                        ),
                        fallbackBuilder: (context) => const SizedBox(),
                      ),

                      /// BUTTON TOPPING
                      Conditional.single(
                        context: context,
                        conditionBuilder: (context) => result.data!.topping!.isNotEmpty,
                        widgetBuilder: (context) => ButtonCard(
                          stringIcon: AssetConts.iconTopping,
                          widthIcon: 18.w,
                          heightIcon: 18.w,
                          nama: 'choose_topping'.tr,
                          child: GetBuilder<DetailMenuController>(
                            builder: (controller) => customTextButton(
                                nama: DetailMenuController.to.getToppingName(DetailMenuController.to.menuHive.toppingDetail!.map((e) => e.keterangan).toList()),
                                ontap: () {
                                  Get.bottomSheet(
                                    barrierColor: Colours.grey.withOpacity(0.5),
                                    ShowTopingBottomSheet(result: result),
                                  );
                                }),
                          ),
                        ),
                        fallbackBuilder: (context) => const SizedBox(),
                      ),

                      /// CATATAN
                      GetBuilder<DetailMenuController>(
                        builder: (controller) => ButtonCard(
                          stringIcon: AssetConts.iconCatatan,
                          widthIcon: 20.w,
                          heightIcon: 22.w,
                          nama: 'note'.tr,
                          child: customTextButton(
                            nama: DetailMenuController.to.menuHive.catatan.isEmpty ? 'make_note'.tr : DetailMenuController.to.menuHive.catatan,
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
                                            color: const Color(0xffC4C4C4).withOpacity(0.5),
                                            borderRadius: BorderRadius.circular(30),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 13.h),
                                      Container(
                                        margin: EdgeInsets.only(left: 17.sp),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "make_note".tr,
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
                                                    controller: DetailMenuController.to.catatanController,
                                                    onChanged: (value) {
                                                      DetailMenuController.to.onChangedCatatan(value);
                                                    },
                                                    autofocus: true,
                                                    autocorrect: false,
                                                    textInputAction: TextInputAction.done,
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
                                                      borderRadius: BorderRadius.circular(24),
                                                      color: Colours.green2,
                                                      image: const DecorationImage(
                                                        image: AssetImage(AssetConts.iconCeklis),
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
                      GetBuilder<DetailMenuController>(
                        builder: (_) {
                          return Container(
                            height: 44.h,
                            width: ScreenUtil().screenWidth,
                            margin: EdgeInsets.only(right: 23.sp),
                            child: ElevatedButton(
                              onPressed: () async {
                                await DetailMenuController.to.addOrderMenu();
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 5.sp,
                                primary: Colours.green2,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.r),
                                ),
                              ),
                              child: Text(
                                "add_to_cart".tr,
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
                  "choose_topping".tr,
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
                    itemCount: DetailMenuController.to.detailMenuResult.data?.topping?.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          DetailMenuController.to.addTopping(DetailMenuController.to.detailMenuResult.data!.topping![index], index);
                          Get.back();
                        },
                        child: levelItem(text: DetailMenuController.to.detailMenuResult.data?.topping?[index].keterangan ?? "none", selected: DetailMenuController.to.detailMenuResult.data?.topping?[index].isSelected ?? false),
                      );
                    },
                  ),
                )
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
                  "choose_level".tr,
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
                      // MENGAMBL LIST INDEX LEVEL
                      // var listIndex = DetailMenuController.to.listIndexLevel;
                      return InkWell(
                        onTap: () {
                          DetailMenuController.to.chooseLevel(
                            DetailMenuController.to.detailMenuResult.data!.level![index],
                          );
                          Get.back();
                        },
                        child: levelItem(text: DetailMenuController.to.detailMenuResult.data?.level?[index].keterangan ?? "none", selected: DetailMenuController.to.detailMenuResult.data?.level?[index].idDetail == DetailMenuController.to.menuHive.level),
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

class DialogNotifDeleteCountOrderIfOne extends StatelessWidget {
  const DialogNotifDeleteCountOrderIfOne({
    Key? key,
    required this.result,
  }) : super(key: key);

  final DetailMenuRes result;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 338.w,
      height: 418.h,
      decoration: BoxDecoration(
        color: Colours.white,
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          iconNotifcation(),
          SizedBox(height: 30.h),
          Text(
            'Hapus item ?',
            style: GoogleFonts.montserrat(
              fontSize: 20.sp,
              color: Colours.darkGrey,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 15.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.sp),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  text: 'Kamu akan mengeluarkan menu ini dari',
                  style: GoogleFonts.montserrat(
                    fontSize: 16.sp,
                    color: Colours.darkGrey.withOpacity(0.5),
                    fontWeight: FontWeight.w300,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: ' Pesanan',
                      style: GoogleFonts.montserrat(
                        fontSize: 16.sp,
                        color: Colours.grey,
                        fontWeight: FontWeight.w700,
                      ),
                    )
                  ]),
            ),
          ),
          SizedBox(height: 15.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 40.h,
                  width: 100.w,
                  child: TextButton(
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
                      DetailMenuController.to.subtractAmount();
                      Get.back();
                      Get.back();
                    },
                    child: const Text('Oke'),
                  ),
                ),
                SizedBox(
                  height: 40.h,
                  width: 100.w,
                  child: ElevatedButton(
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
                      Get.back();
                    },
                    child: const Text('Kembali'),
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
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12, color: selected ? Colors.white : Colors.black),
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
