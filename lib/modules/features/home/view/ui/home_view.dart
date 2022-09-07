// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:java_code/config/routes/app_routes.dart';
import 'package:java_code/modules/features/home/view/components/menu/menu_makanan.dart';
import 'package:java_code/modules/features/home/view/components/menu/menu_minuman.dart';
import 'package:java_code/modules/features/home/view/components/menu/menu_snack.dart';
import '/modules/features/home/view/components/image_promo.dart';
import '/config/themes/colours.dart';
import '/constant/core/assets_const.dart';
import '/modules/features/home/controllers/home_controller.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        backgroundColor: Colours.bgColors,
        body: SafeArea(
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
                      controller: HomeController.to.controllerPencarian,
                      onChanged: (value) => HomeController.to
                          .pencarianMenu(value, HomeController.to.index.value),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 12.sp),
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
                          borderSide: const BorderSide(color: Colours.green2),
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
              SizedBox(
                height: 161.sp,
                width: ScreenUtil().screenWidth,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    ImagePromo(imageUrl: AssetConts.drawDiskonKompetensi),
                    ImagePromo(imageUrl: AssetConts.drawDiskonMengaji),
                    ImagePromo(imageUrl: AssetConts.drawDiskonMengisiReview),
                    ImagePromo(imageUrl: AssetConts.drawDiskonTelatTigaKali),
                    ImagePromo(imageUrl: AssetConts.drawDiskonTidakTelat),
                    ImagePromo(imageUrl: AssetConts.drawVoucher100),
                    ImagePromo(imageUrl: AssetConts.drawVoucher200Bulan),
                    ImagePromo(imageUrl: AssetConts.drawVoucher200Karyawan),
                  ],
                ),
              ),
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

              /// LIST MENU
              Container(
                margin:
                    EdgeInsets.symmetric(horizontal: 25.sp, vertical: 11.sp),
                child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    /// ITEM MENU
                    Obx(
                      () => Column(
                        children: Conditional.list(
                          context: context,
                          conditionBuilder: (context) =>
                              HomeController.to.listAllMenu.isNotEmpty,
                          widgetBuilder: (context) => ConditionalSwitch.list(
                            context: context,
                            valueBuilder: (context) =>
                                HomeController.to.index.value,
                            caseBuilders: {
                              0: (context) => [
                                    /// JUDUL ITEM MENU MAKANAN
                                    const MenuMakanan(),

                                    /// JUDUL ITEM MENU SNACK
                                    const MenuSnack(),

                                    /// JUDUL ITEM MENU MINUMAN
                                    const MenuMinuman(),
                                  ],
                              1: (context) => [
                                    /// JUDUL ITEM MENU MAKANAN
                                    const MenuMakanan(),
                                  ],
                              2: (context) => [
                                    /// JUDUL ITEM MENU SNACK
                                    const MenuSnack(),
                                  ],
                            },
                            fallbackBuilder: (context) => [
                              /// JUDUL ITEM MENU MINUMAN
                              const MenuMinuman(),
                            ],
                          ),
                          fallbackBuilder: (context) => <Widget>[
                            const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        floatingActionButton: Stack(
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
                    "1",
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
    );
  }
}
