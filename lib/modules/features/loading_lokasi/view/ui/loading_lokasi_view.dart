import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:java_code/config/themes/colours.dart';
import 'package:java_code/constant/core/assets_const.dart';
import 'package:java_code/modules/features/loading_lokasi/controllers/lokasi_controller.dart';
import 'package:java_code/modules/features/no_connecntion/view/ui/no_connection_view.dart';
import 'package:java_code/modules/global_controllers/check_connection_controller.dart';

class LoadingLokasi extends StatelessWidget {
  const LoadingLokasi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(LoadingController());

    return Obx(
      () => ConnectionManagerController.to.connectionType.value != 0
          ? Scaffold(
              body: SafeArea(
                child: Stack(
                  children: [
                    /// BACKGROUND
                    Center(
                      child: Container(
                        width: 359.w,
                        height: 799.h,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image:
                                AssetImage(AssetConts.backgroundLoadingLokasi),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Column(
                        children: [
                          SizedBox(height: 208.h),

                          /// MENCARI LOKASI
                          Text(
                            "Mencari Lokasimu",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w400,
                                fontSize: 22.sp,
                                color: Colours.darkBlack.withOpacity(0.5)),
                          ),

                          /// ICON MENCARI LOKASI
                          Container(
                            width: 190.w,
                            height: 190.w,
                            margin: EdgeInsets.symmetric(vertical: 49.sp),
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(AssetConts.drawLoadingLokasi),
                              ),
                            ),
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Image.asset(AssetConts.iconMap),
                            ),
                          ),

                          /// ALAMAT LOKASI
                          FutureBuilder(
                            future: LoadingController.to.initLocation(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              return Obx(
                                () => SizedBox(
                                  width: 245.w,
                                  height: 170.h,
                                  child: Text(
                                    LoadingController.to.address.value,
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 22.sp,
                                      color: Colours.darkBlack,
                                    ),
                                    textAlign: TextAlign.center,
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
            )
          : const NoConnectionView(),
    );
  }
}
