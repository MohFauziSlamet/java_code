import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:java_code/config/routes/app_routes.dart';
import '/config/themes/colours.dart';
import '/constant/core/assets_const.dart';

class ItemMenu extends StatelessWidget {
  const ItemMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () {
        Get.toNamed(AppRoutes.detailMenu);
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
                    image: const DecorationImage(
                      // image: NetworkImage(imageUrl),
                      image: AssetImage(AssetConts.drawChickenKatsu),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                SizedBox(width: 5.sp),

                /// DETAIL DESKRIPSI
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /// NAMA MENU
                      SizedBox(height: 7.sp),

                      FittedBox(
                        child: Text(
                          "Chicken Katsu",
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
                          "Rp 10.000",
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
                          InkWell(
                            onTap: () {
                              Get.defaultDialog(
                                title: "Hallo",
                                actions: [
                                  OutlinedButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: const Text("Batal"),
                                  ),
                                  const SizedBox(width: 10),
                                  ElevatedButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: const Text("Tambahkan"),
                                  ),
                                ],
                                content: Column(
                                  children: [
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: Center(
                                        child: Text(
                                          "Perhatian, Untuk menghapus catatan, kosongkan form dan klik tambahkan. Terimakasih",
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      child: const TextField(
                                        autocorrect: false,
                                        maxLines: 1,
                                        textInputAction: TextInputAction.done,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              width: 2,
                                              color: Colors.lightBlue,
                                            ),
                                          ),
                                          hintText: "Tulis Catatan Kamu",
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: Container(
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

                /// TOMBOL TAMBAH KURANG
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Material(
                      child: InkWell(
                        splashColor: Colors.grey,
                        onTap: () {},
                        child: Container(
                          height: 21.w,
                          width: 21.w,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                AssetConts.iconKurang,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 11),
                    Text(
                      "1",
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w500,
                        fontSize: 18.sp,
                      ),
                    ),
                    const SizedBox(width: 11),
                    Material(
                      child: InkWell(
                        splashColor: Colors.grey,
                        onTap: () {},
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
