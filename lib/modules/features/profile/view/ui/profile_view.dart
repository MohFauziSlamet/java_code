import 'dart:developer';
import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:java_code/modules/features/no_connecntion/view/ui/no_connection_view.dart';
import 'package:java_code/modules/features/profile/controller/profile_controller.dart';
import 'package:java_code/modules/global_controllers/check_connection_controller.dart';
import '/modules/features/profile/view/component/garis_batas.dart';
import '/config/themes/colours.dart';
import '/constant/core/assets_const.dart';
import '/modules/features/profile/view/component/item_info_profile.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ProfileController());

    return Scaffold(
      backgroundColor: Colours.bgColors,
      body: Obx(
        () => ConnectionManagerController.to.connectionType.value != 0
            ? GetBuilder<ProfileController>(
                init: ProfileController(),
                builder: (value) => SafeArea(
                  child: Column(
                    children: [
                      // APPBAR PROFILE
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
                          child: Column(
                            children: [
                              SizedBox(height: 15.h),
                              SizedBox(
                                height: 40.h,
                                width: ScreenUtil().screenWidth,
                                child: Column(
                                  children: [
                                    Text(
                                      "profil".tr,
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20.sp,
                                        color: Colours.green2,
                                      ),
                                    ),
                                    SizedBox(height: 8.h),
                                    Visibility(
                                      child: Container(
                                        height: 5.h,
                                        width: 65.w,
                                        decoration: const BoxDecoration(color: Colours.green2),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // CONTENT
                      Expanded(
                        child: Stack(
                          children: [
                            // BG
                            Center(
                              child: Container(
                                width: ScreenUtil().screenWidth,
                                height: ScreenUtil().screenHeight * 0.8,
                                margin: EdgeInsets.symmetric(horizontal: 25.sp, vertical: 17.sp),
                                child: Image.asset(AssetConts.backgroundLoadingLokasi),
                              ),
                            ),
                            // MAIN CONTENT
                            ListView(
                              children: [
                                SizedBox(height: 33.h),
                                // PROFILE
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    _buildProfilePicture(context: context, controller: controller),
                                  ],
                                ),

                                // JARAK
                                SizedBox(height: 21.h),
                                // VERIFIKASI
                                SizedBox(
                                  height: 21.h,
                                  width: ScreenUtil().screenWidth,
                                  child: InkWell(
                                    onTap: () {
                                      log("UPLOAD KTP");
                                      value.uploadImageKTP(ImageSource.camera);
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        // ICON KTP
                                        SizedBox(
                                          height: 16.h,
                                          width: 20.w,
                                          child: Image.asset(
                                            AssetConts.iconKTP,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        SizedBox(width: 7.w),
                                        // TEXT VERIFIKASI
                                        SizedBox(
                                          height: 21.h,
                                          width: 198.w,
                                          child: Text(
                                            "verif_id".tr,
                                            style: GoogleFonts.montserrat(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14.sp,
                                              color: Colours.green2,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                // INFO AKUN
                                SizedBox(height: 18.h),
                                Container(
                                  height: 21.h,
                                  width: 173.w,
                                  margin: EdgeInsets.only(left: 36.sp),
                                  child: Text(
                                    "acc_info".tr,
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20.sp,
                                      color: Colours.green2,
                                    ),
                                  ),
                                ),
                                // DETAIL INFORMASI
                                SizedBox(height: 14.h),
                                Container(
                                  height: 306.h,
                                  width: 396.w,
                                  margin: EdgeInsets.symmetric(horizontal: 16.sp),
                                  padding: EdgeInsets.only(left: 20.sp, right: 20.sp, top: 31.sp),
                                  decoration: BoxDecoration(
                                    color: Colours.whiteItem,
                                    borderRadius: BorderRadius.circular(30),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 1,
                                        spreadRadius: 1,
                                        color: Colors.grey.withAlpha(70),
                                      )
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      // ITEM INFO NAME PROFILE
                                      ItemInfoProfile(
                                        nameInfo: 'name'.tr,
                                        textInfo: value.userDetail?.data?.nama ?? "",
                                        onTap: () {
                                          showBottomSheet(
                                            elevation: 24,
                                            context: context,
                                            builder: (context) {
                                              return _showBottomSheetUpdateProfile(
                                                context,
                                                'nama',
                                                "name".tr,
                                                value.userDetail?.data?.nama ?? "",
                                                value,
                                              );
                                            },
                                          );
                                          // Get.bottomSheet(
                                          //   BottomSheetDialog(
                                          //       onTap: () {
                                          //         Get.back();
                                          //       },
                                          //       namaBottomSheet: 'Nama'),
                                          //   barrierColor: Colours.whiteGrey.withOpacity(0.5),
                                          // );
                                        },
                                      ),
                                      const GarisBatas(),
                                      // ITEM INFO TGL PROFILE
                                      ItemInfoProfile(
                                          nameInfo: 'date_of_birth'.tr,
                                          textInfo: value.userDetail?.data?.tglLahir ?? "",
                                          onTap: () {
                                            showBottomSheet(
                                              elevation: 24,
                                              context: context,
                                              builder: (context) {
                                                return _showBottomSheetUpdateProfile(
                                                  context,
                                                  'tgl_lahir',
                                                  "date_of_birth".tr,
                                                  value.userDetail?.data?.tglLahir ?? "",
                                                  value,
                                                  datePicker: true,
                                                );
                                              },
                                            );
                                            // Get.bottomSheet(
                                            //   BottomSheetDialog(
                                            //     onTap: () {
                                            //       Get.back();
                                            //     },
                                            //     namaBottomSheet: 'Ubah Nomor',
                                            //     keyboardType: TextInputType.number,
                                            //     widget: SizedBox(
                                            //       height: 19.w,
                                            //       width: 19.w,
                                            //       child: InkWell(
                                            //         onTap: () {},
                                            //         child: Image.asset(
                                            //           AssetConts.iconKalender,
                                            //           color: Colours.green2,
                                            //         ),
                                            //       ),
                                            //     ),
                                            //   ),
                                            //   barrierColor: Colours.whiteGrey.withOpacity(0.5),
                                            // );
                                          }),
                                      const GarisBatas(),
                                      // ITEM INFO NO TLP PROFILE
                                      ItemInfoProfile(
                                          nameInfo: 'phone_number'.tr,
                                          textInfo: value.userDetail?.data?.telepon ?? "",
                                          onTap: () {
                                            showBottomSheet(
                                              elevation: 24,
                                              context: context,
                                              builder: (context) {
                                                return _showBottomSheetUpdateProfile(
                                                  context,
                                                  'telepon',
                                                  "phone_number".tr,
                                                  value.userDetail?.data?.telepon ?? "",
                                                  value,
                                                  keyboardType: TextInputType.phone,
                                                );
                                              },
                                            );
                                            // Get.bottomSheet(
                                            //   BottomSheetDialog(
                                            //     onTap: () {
                                            //       Get.back();
                                            //     },
                                            //     namaBottomSheet: 'Ubah Nomor',
                                            //     keyboardType: TextInputType.number,
                                            //   ),
                                            //   barrierColor: Colours.whiteGrey.withOpacity(0.5),
                                            // );
                                          }),
                                      const GarisBatas(),
                                      // ITEM INFO EMAIL PROFILE
                                      ItemInfoProfile(
                                          nameInfo: 'email_address'.tr,
                                          textInfo: value.userDetail?.data?.email ?? "",
                                          onTap: () {
                                            controller.userData!.isGoogle == 1
                                                ? Get.snackbar("cant_edit_email_title".tr, "cant_edit_email_message".tr)
                                                : showBottomSheet(
                                                    elevation: 24,
                                                    context: context,
                                                    builder: (context) {
                                                      return _showBottomSheetUpdateProfile(context, 'email', 'Email', value.userDetail?.data?.email ?? "", value, keyboardType: TextInputType.emailAddress);
                                                    },
                                                  );
                                            // Get.bottomSheet(
                                            //   BottomSheetDialog(
                                            //       onTap: () {
                                            //         Get.back();
                                            //       },
                                            //       namaBottomSheet: 'Ubah Email'),
                                            //   barrierColor: Colours.whiteGrey.withOpacity(0.5),
                                            // );
                                          }),
                                      const GarisBatas(),
                                      // ITEM INFO UBAH PIN PROFILE
                                      ItemInfoProfile(
                                          nameInfo: 'change_pin'.tr,
                                          textInfo: '**********',
                                          onTap: () {
                                            showBottomSheet(
                                              elevation: 24,
                                              context: context,
                                              builder: (context) {
                                                return _showBottomSheetUpdateProfile(context, 'pin', 'Pin', "", value, keyboardType: TextInputType.number, maxLength: 6);
                                              },
                                            );
                                            // Get.bottomSheet(
                                            //   BottomSheetDialog(
                                            //       onTap: () {
                                            //         Get.back();
                                            //       },
                                            //       namaBottomSheet: 'Ubah PIN'),
                                            //   barrierColor: Colours.whiteGrey.withOpacity(0.5),
                                            // );
                                          }),
                                      const GarisBatas(),
                                      ItemInfoProfile(
                                        nameInfo: "change_lang".tr,
                                        textInfo: controller.selectedLanguage?.toUpperCase() ?? "EN",
                                        onTap: () {
                                          showBottomSheet(
                                            elevation: 24,
                                            context: context,
                                            builder: (context) {
                                              return _showBottomSheetChangeLanguage(
                                                context,
                                                controller,
                                              );
                                            },
                                          );
                                          // Get.bottomSheet(
                                          //   Container(
                                          //     width: ScreenUtil().screenWidth,
                                          //     height: 200.h,
                                          //     decoration: BoxDecoration(
                                          //       color: Colours.white,
                                          //       borderRadius: BorderRadius.only(
                                          //         topLeft: Radius.circular(30.r),
                                          //         topRight: Radius.circular(30.r),
                                          //       ),
                                          //     ),
                                          //     child: Column(
                                          //       children: [
                                          //         SizedBox(height: 18.h),
                                          //         // GARIS STRIP
                                          //         Container(
                                          //           height: 4.h,
                                          //           width: 104.w,
                                          //           decoration: BoxDecoration(
                                          //             borderRadius: BorderRadius.circular(30),
                                          //             color: const Color(0xffc4c4c4).withOpacity(0.5),
                                          //           ),
                                          //         ),
                                          //         SizedBox(height: 13.h),
                                          //         // GANTI BAHASA DAN LOGO BENDERA
                                          //         Expanded(
                                          //           child: Container(
                                          //             width: ScreenUtil().screenWidth,
                                          //             margin: EdgeInsets.symmetric(
                                          //               horizontal: 17.sp,
                                          //             ),
                                          //             child: SizedBox(
                                          //               height: 165,
                                          //               child: Column(
                                          //                 crossAxisAlignment: CrossAxisAlignment.start,
                                          //                 mainAxisAlignment: MainAxisAlignment.start,
                                          //                 children: [
                                          //                   // GANTI BAHASA
                                          //                   SizedBox(
                                          //                     height: 20.h,
                                          //                     width: 150.w,
                                          //                     child: Text(
                                          //                       'Ganti Bahasa',
                                          //                       style: GoogleFonts.montserrat(
                                          //                         fontWeight: FontWeight.w700,
                                          //                         fontSize: 18,
                                          //                         color: Colours.darkGrey,
                                          //                       ),
                                          //                     ),
                                          //                   ),
                                          //                   SizedBox(height: 13.h),
                                          //                   // LOGO BENDERA
                                          //                   SizedBox(
                                          //                     width: ScreenUtil().screenWidth,
                                          //                     height: 57.h,
                                          //                     child: Row(
                                          //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          //                       children: [
                                          //                         Material(
                                          //                           borderRadius: BorderRadius.circular(10.r),
                                          //                           elevation: 2,
                                          //                           child: Container(
                                          //                             height: 57.h,
                                          //                             width: 189.w,
                                          //                             decoration: BoxDecoration(
                                          //                               color: Colours.green2,
                                          //                               borderRadius: BorderRadius.circular(10.r),
                                          //                             ),
                                          //                             child: Row(
                                          //                               children: [
                                          //                                 SizedBox(width: 11.w),
                                          //                                 SizedBox(
                                          //                                   width: 56.w,
                                          //                                   height: 38.5.h,
                                          //                                   child: Image.asset(AssetConts.iconIndFlag),
                                          //                                 ),
                                          //                                 SizedBox(width: 9.w),
                                          //                                 SizedBox(
                                          //                                   height: 20.h,
                                          //                                   width: 76.w,
                                          //                                   child: Text(
                                          //                                     'Indonesia',
                                          //                                     style: GoogleFonts.montserrat(
                                          //                                       fontWeight: FontWeight.w500,
                                          //                                       fontSize: 15,
                                          //                                       color: Colours.white,
                                          //                                     ),
                                          //                                   ),
                                          //                                 ),
                                          //                                 SizedBox(width: 6.13.w),
                                          //                                 SizedBox(
                                          //                                   height: 12.h,
                                          //                                   width: 15.w,
                                          //                                   child: Image.asset(
                                          //                                     AssetConts.iconCeklis,
                                          //                                     color: Colours.white,
                                          //                                   ),
                                          //                                 )
                                          //                               ],
                                          //                             ),
                                          //                           ),
                                          //                         ),
                                          //                         Material(
                                          //                           borderRadius: BorderRadius.circular(10.r),
                                          //                           elevation: 4,
                                          //                           child: Container(
                                          //                             height: 57.h,
                                          //                             width: 189.w,
                                          //                             decoration: BoxDecoration(
                                          //                               color: Colours.white,
                                          //                               borderRadius: BorderRadius.circular(10.r),
                                          //                             ),
                                          //                             child: Row(
                                          //                               children: [
                                          //                                 SizedBox(width: 11.w),
                                          //                                 SizedBox(
                                          //                                   width: 56.w,
                                          //                                   height: 38.5.h,
                                          //                                   child: Image.asset(AssetConts.iconEngFlag),
                                          //                                 ),
                                          //                                 SizedBox(width: 5.w),
                                          //                                 SizedBox(
                                          //                                   height: 20.h,
                                          //                                   width: 76.w,
                                          //                                   child: Text(
                                          //                                     'Inggris',
                                          //                                     style: GoogleFonts.montserrat(
                                          //                                       fontWeight: FontWeight.w500,
                                          //                                       fontSize: 15,
                                          //                                       color: Colours.darkGrey,
                                          //                                     ),
                                          //                                   ),
                                          //                                 ),
                                          //                                 SizedBox(width: 6.13.w),
                                          //                                 SizedBox(
                                          //                                   height: 12.h,
                                          //                                   width: 15.w,
                                          //                                   child: Image.asset(
                                          //                                     AssetConts.iconCeklis,
                                          //                                     color: Colors.transparent,
                                          //                                   ),
                                          //                                 )
                                          //                               ],
                                          //                             ),
                                          //                           ),
                                          //                         ),
                                          //                       ],
                                          //                     ),
                                          //                   ),
                                          //                 ],
                                          //               ),
                                          //             ),
                                          //           ),
                                          //         ),
                                          //       ],
                                          //     ),
                                          //   ),
                                          //   barrierColor: Colours.whiteGrey.withOpacity(0.5),
                                          // );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                // BUTTON PENILAIAN
                                SizedBox(height: 18.h),
                                Container(
                                  height: 47.h,
                                  margin: EdgeInsets.symmetric(horizontal: 16.sp),
                                  decoration: BoxDecoration(
                                    color: Colours.whiteItem,
                                    borderRadius: BorderRadius.circular(16.r),
                                    // color: const Color.fromRGBO(246, 246, 246, 1),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 1,
                                        spreadRadius: 1,
                                        color: Colors.grey.withAlpha(70),
                                      )
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      SizedBox(width: 22.w),
                                      // ICON
                                      SizedBox(
                                        height: 18.86.h,
                                        width: 20.31.w,
                                        child: Image.asset(AssetConts.iconPenilaian),
                                      ),
                                      SizedBox(width: 8.69.w),
                                      SizedBox(
                                        height: 20.h,
                                        width: 77.w,
                                        child: Text(
                                          'rating'.tr,
                                          style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16.sp,
                                            color: Colours.darkGrey,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 114.w),
                                      SizedBox(
                                        height: 35.h,
                                        width: 134.w,
                                        child: ElevatedButton(
                                          onPressed: () {},
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
                                          child: Text(
                                            'give_rating'.tr,
                                            style: GoogleFonts.montserrat(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14.sp,
                                              color: Colours.white,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                // INFO LAINNYA
                                SizedBox(height: 18.h),
                                Container(
                                  height: 21.h,
                                  width: 201.w,
                                  margin: EdgeInsets.only(left: 36.sp),
                                  child: Text(
                                    'other_info'.tr,
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20.sp,
                                      color: Colours.green2,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 14.h),
                                // DETAIL DEVICE
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 16.sp),
                                  child: _builtOtherInfo(context, value),
                                ),
                                // Container(
                                //   height: 114.h,
                                //   width: ScreenUtil().screenWidth,
                                //   margin: EdgeInsets.symmetric(horizontal: 16.sp),
                                //   padding: EdgeInsets.only(left: 20.sp, right: 20.sp, top: 25.sp),
                                //   decoration: BoxDecoration(
                                //     borderRadius: BorderRadius.circular(30.r),
                                //     color: Colours.whiteItem,
                                //   ),
                                //   child: Column(
                                //     children: [

                                //       // ItemInfoProfile(
                                //       //   nameInfo: 'Device Info',
                                //       //   textInfo: 'Iphone 13',
                                //       //   onTap: () {},
                                //       // ),
                                //       // const GarisBatas(),
                                //       // ItemInfoProfile(
                                //       //   nameInfo: 'Version',
                                //       //   textInfo: '1.3',
                                //       //   onTap: () {},
                                //       // ),
                                //     ],
                                //   ),
                                // ),
                                // BUTTON LOGOUT
                                SizedBox(height: 30.h),
                                Obx(
                                  () => Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 35.h,
                                        width: 205,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Get.defaultDialog(
                                              title: 'HALO',
                                              middleText: 'Apakah kamu ingin keluar ?',
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
                                                    if (ProfileController.to.isLoading.isFalse) {
                                                      ProfileController.to.keluar();
                                                    }
                                                  },
                                                  child: Text(
                                                    ProfileController.to.isLoading.isFalse ? "Iya" : 'Loading...',
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
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
                                          child: Text(
                                            ProfileController.to.isLoading.isFalse ? 'LOGOUT' : 'Loading...',
                                            style: GoogleFonts.montserrat(
                                              fontWeight: FontWeight.w800,
                                              fontSize: 14.sp,
                                              color: Colours.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 30.h),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : const NoConnectionView(),
      ),
    );
  }

  ///
  Widget _buildProfilePicture({required BuildContext context, required ProfileController controller}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 16),
              decoration: const BoxDecoration(
                color: Colours.green2,
                shape: BoxShape.circle,
              ),
              child: ClipOval(
                child: SizedBox.fromSize(
                  size: const Size.fromRadius(80),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 200,
                        height: 200,
                        child: controller.userDetail?.data!.foto != null
                            ? controller.croppedFile != null
                                ? Image.file(
                                    File(
                                      controller.croppedFile!.path,
                                    ),
                                    fit: BoxFit.cover,
                                  )
                                : Image.network(
                                    controller.userDetail?.data?.foto ?? '',
                                    fit: BoxFit.cover,
                                  )
                            : controller.croppedFile != null
                                ? Image.file(
                                    File(
                                      controller.croppedFile!.path,
                                    ),
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    AssetConts.drawEmptyProfile,
                                  ),
                      ),
                      InkWell(
                        onTap: () {
                          // changeProfilePicture();
                          showBottomSheet(
                            elevation: 24,
                            context: context,
                            builder: (context) {
                              return _showBottomSheetImagePicker(context);
                            },
                          );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 6,
                                    ),
                                    color: Colours.green2,
                                    child: Text(
                                      'edit'.tr,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            controller.croppedFile != null
                ? Column(
                    children: [
                      const SizedBox(
                        height: 12,
                      ),
                      InkWell(
                        onTap: () {
                          controller.updateProfile();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(
                            12,
                          ),
                          decoration: BoxDecoration(color: Colours.green2, borderRadius: BorderRadius.circular(12)),
                          child: Text(
                            'save'.tr,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  )
                : Container(),
          ],
        ),
      ],
    );
  }

  ///
  Wrap _showBottomSheetImagePicker(BuildContext context) {
    return Wrap(
      children: [
        Container(
          margin: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 8),
                child: Divider(
                  indent: MediaQuery.of(context).size.width * 1 / 5,
                  endIndent: MediaQuery.of(context).size.width * 1 / 5,
                  height: 2,
                  thickness: 3,
                  color: Colors.grey.withAlpha(70),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 12),
                child: Text(
                  "choose_image".tr,
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          controller.uploadImage(ImageSource.camera);
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 8),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(12),
                            ),
                            color: Colours.green2,
                            boxShadow: [
                              BoxShadow(
                                spreadRadius: 1,
                                blurRadius: 1,
                                color: Colors.grey.withAlpha(70),
                              )
                            ],
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.camera_alt_outlined,
                                size: 36,
                                color: Colors.white,
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 8),
                                child: Text(
                                  'camera'.tr,
                                  style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, fontSize: 14, color: Colors.white
                                      // : Colors.black,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          controller.uploadImage(ImageSource.gallery);
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 8),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(12),
                            ),
                            color: Colours.green2,
                            // : Colors.white,
                            boxShadow: [
                              BoxShadow(
                                spreadRadius: 1,
                                blurRadius: 1,
                                color: Colors.grey.withAlpha(70),
                              )
                            ],
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.image,
                                size: 36,
                                color: Colors.white,
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 8),
                                child: Text(
                                  'gallery'.tr,
                                  style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, fontSize: 14, color: Colors.white
                                      // : Colors.black,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Wrap _showBottomSheetUpdateProfile(BuildContext context, String key, String label, String initialValue, ProfileController controller, {TextInputType? keyboardType, bool datePicker = false, int maxLength = -1}) {
    String savedValue = initialValue;
    TextEditingController textEditingController = TextEditingController()
      ..text = savedValue
      ..selection = TextSelection.fromPosition(TextPosition(offset: savedValue.length));

    return Wrap(
      children: [
        Container(
          margin: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 8),
                child: Divider(
                  indent: MediaQuery.of(context).size.width * 1 / 5,
                  endIndent: MediaQuery.of(context).size.width * 1 / 5,
                  height: 2,
                  thickness: 3,
                  color: Colors.grey.withAlpha(70),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 12),
                child: Text(
                  'Update $label',
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      keyboardType: keyboardType ?? TextInputType.text,
                      readOnly: datePicker,
                      controller: textEditingController,
                      onChanged: (value) {
                        savedValue = value;
                        // controller.updateValueData(key, value);
                      },
                      onTap: () {
                        datePicker
                            ? showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1970, 1),
                                lastDate: DateTime.now(),
                                builder: (context, picker) {
                                  return Theme(
                                    data: ThemeData.light().copyWith(),
                                    child: picker!,
                                  );
                                }).then((selectedDate) {
                                if (selectedDate != null) {
                                  textEditingController.text = controller.formatter.format(selectedDate).toString();
                                  savedValue = controller.formatter.format(selectedDate).toString();
                                  // controller.update();
                                }
                              })
                            : null;
                      },
                      maxLength: maxLength == -1 ? 100 : maxLength,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 1,
                          spreadRadius: 1,
                          color: Colors.grey.withAlpha(100),
                        )
                      ],
                    ),
                    child: CircleAvatar(
                      backgroundColor: Colours.green2,
                      child: IconButton(
                        color: Colors.white,
                        onPressed: () {
                          controller.updateData(key, savedValue);
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.check),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  Wrap _showBottomSheetChangeLanguage(BuildContext context, ProfileController controller) {
    return Wrap(
      children: [
        Container(
          margin: EdgeInsets.all(16.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 8.sp),
                child: Divider(
                  indent: MediaQuery.of(context).size.width * 1 / 5,
                  endIndent: MediaQuery.of(context).size.width * 1 / 5,
                  height: 2,
                  thickness: 3,
                  color: Colors.grey.withAlpha(70),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 12.sp),
                child: Text(
                  "change_lang".tr,
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w700,
                    fontSize: 18.sp,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 8.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          controller.updateLanguage('id');
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 8.sp),
                          padding: EdgeInsets.symmetric(horizontal: 8.sp, vertical: 8.sp),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(12),
                            ),
                            color: controller.selectedLanguage == 'id' ? Colours.green2 : Colors.white,
                            boxShadow: [
                              BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 2,
                                color: Colors.grey.withAlpha(70),
                              )
                            ],
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 56.w,
                                height: 38.h,
                                child: Image.asset(
                                  AssetConts.iconIndFlag,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 8.sp),
                                child: Text(
                                  'Indonesia',
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.sp,
                                    color: controller.selectedLanguage == 'id' ? Colors.white : Colors.black,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 4.sp),
                                child: Icon(Icons.check, size: 24.sp, color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          controller.updateLanguage('en');
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 8.sp),
                          padding: EdgeInsets.symmetric(horizontal: 8.sp, vertical: 8.sp),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(12.r)),
                            color: controller.selectedLanguage == 'en' ? Colours.green2 : Colors.white,
                            boxShadow: [
                              BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 2,
                                color: Colors.grey.withAlpha(70),
                              )
                            ],
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 56.w,
                                height: 38.h,
                                child: Image.asset(
                                  AssetConts.iconEngFlag,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 8.sp),
                                child: Text(
                                  'Inggris',
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.sp,
                                    color: controller.selectedLanguage == 'en' ? Colors.white : Colors.black,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 4.sp),
                                child: Icon(Icons.check, size: 24.sp, color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Container _builtOtherInfo(BuildContext context, ProfileController controller) {
    return Container(
        margin: EdgeInsets.only(top: 8.sp),
        padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 16.sp),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(20.r),
          ),
          color: const Color.fromRGBO(246, 246, 246, 1),
          boxShadow: [
            BoxShadow(
              blurRadius: 1,
              spreadRadius: 1,
              color: Colors.grey.withAlpha(70),
            )
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "device_info".tr,
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      Platform.isAndroid
                          ? controller.androidDeviceInfo?.model ?? ""
                          : Platform.isIOS
                              ? controller.iosDeviceInfo?.model ?? ""
                              : "",
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 4.sp),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: 16.sp,
                        color: Colors.grey,
                      ),
                    )
                  ],
                )
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "version".tr,
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      controller.packageInfo.version,
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 4.r),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: 16.sp,
                        color: Colors.grey,
                      ),
                    )
                  ],
                )
              ],
            ),
          ],
        ));
  }
}
