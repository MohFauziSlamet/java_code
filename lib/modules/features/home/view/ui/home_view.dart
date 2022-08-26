import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:java_code/config/routes/app_routes.dart';
import '/modules/features/home/view/components/image_promo.dart';
import '/modules/features/home/view/components/item_menu.dart';
import '/config/themes/colours.dart';
import '/constant/core/assets_const.dart';
import '/modules/features/home/controllers/home_controller.dart';
import '/modules/features/home/view/components/judul_menu.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CarouselController _controller = CarouselController();

    List<Widget> imageSliders = [
      ImagePromo(imageUrl: AssetConts.drawDiskonKompetensi),
      ImagePromo(imageUrl: AssetConts.drawDiskonMengaji),
      ImagePromo(imageUrl: AssetConts.drawDiskonMengisiReview),
      ImagePromo(imageUrl: AssetConts.drawDiskonTelatTigaKali),
      ImagePromo(imageUrl: AssetConts.drawDiskonTidakTelat),
      ImagePromo(imageUrl: AssetConts.drawVoucher100),
      ImagePromo(imageUrl: AssetConts.drawVoucher200Bulan),
      ImagePromo(imageUrl: AssetConts.drawVoucher200Karyawan),
    ];

    Get.put(HomeController());

    return Scaffold(
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
                  padding:
                      EdgeInsets.symmetric(horizontal: 25.sp, vertical: 11.sp),
                  child: TextField(
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
            Container(
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

            Container(
              height: 35,
              width: ScreenUtil().screenWidth,
              margin: const EdgeInsets.only(left: 25),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Container(
                    height: 35,
                    padding:
                        EdgeInsets.symmetric(vertical: 5.sp, horizontal: 14.sp),
                    margin: const EdgeInsets.only(right: 13),
                    decoration: BoxDecoration(
                      color: Colours.darkGrey,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        Image.asset(AssetConts.iconSemuaMenu),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(
                          "Semua Menu",
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: Colours.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 35,
                    padding:
                        EdgeInsets.symmetric(vertical: 5.sp, horizontal: 14.sp),
                    margin: const EdgeInsets.only(right: 13),
                    decoration: BoxDecoration(
                      color: Colours.blue,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        Image.asset(AssetConts.iconMakanan),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(
                          "Makanan",
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: Colours.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 35,
                    padding:
                        EdgeInsets.symmetric(vertical: 5.sp, horizontal: 14.sp),
                    margin: const EdgeInsets.only(right: 13),
                    decoration: BoxDecoration(
                      color: Colours.blue,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        Image.asset(AssetConts.iconMakanan),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(
                          "Snack",
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: Colours.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 35,
                    padding:
                        EdgeInsets.symmetric(vertical: 5.sp, horizontal: 14.sp),
                    margin: const EdgeInsets.only(right: 13),
                    decoration: BoxDecoration(
                      color: Colours.blue,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        Image.asset(AssetConts.iconMinuman),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(
                          "Minuman",
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: Colours.white,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),

            /// LIST MENU
            Container(
              margin: EdgeInsets.symmetric(horizontal: 25.sp, vertical: 11.sp),
              child: ListView(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  /// JUDUL ITEM MENU
                  JudulMenu(
                      iconMenu: AssetConts.iconMakanan, judulMenu: "Makanan"),

                  /// ITEM MENU
                  const ItemMenu(),
                  const ItemMenu(),
                  const ItemMenu(),
                  const ItemMenu(),
                  const ItemMenu(),

                  /// JUDUL ITEM MENU
                  JudulMenu(
                      iconMenu: AssetConts.iconMinuman, judulMenu: "Minuman"),

                  /// ITEM MENU
                  const ItemMenu(),
                  const ItemMenu(),
                  const ItemMenu(),
                  const ItemMenu(),
                  const ItemMenu(),
                ],
              ),
            )

            /// BOTTOM NAVIGATION
            // BottomNavigationBar(items: [BottomNavigationBarItem(icon: icon)])
          ],
        ),
      ),
      bottomNavigationBar: GetBuilder<HomeController>(
        builder: (c) {
          return ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.sp),
                topRight: Radius.circular(30.sp)),
            child: BottomNavigationBar(
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Image.asset(AssetConts.iconHome),
                  label: "Beranda",
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(AssetConts.iconPesanan),
                  label: "Pesanan",
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(AssetConts.iconProfile),
                  label: "Profil",
                ),
              ],
              currentIndex: c.selectedNavbar,
              selectedItemColor: Colours.white,
              unselectedItemColor: Colors.grey,
              showUnselectedLabels: true,
              backgroundColor: Colours.darkBlack,

              // onTap: c.changeSelectedNavBar(
              //     c.selectedNavbar),
            ),
          );
        },
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
    );
  }
}
