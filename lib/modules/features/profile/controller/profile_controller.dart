// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:java_code/config/routes/app_routes.dart';
// import 'package:java_code/config/themes/colours.dart';
import 'package:java_code/constant/core/hive_const.dart';
import 'package:java_code/modules/features/profile/repositories/profile_repository.dart';
import 'package:java_code/modules/models/get_user_detail/get_user_detail.dart';
import 'package:java_code/modules/models/get_user_detail/user_detail_data.dart';
import 'package:java_code/modules/models/user_data_res/user.dart';
// import 'package:java_code/modules/models/user_data_res/akses.dart';
// import 'package:java_code/modules/models/user_data_res/data_user.dart';
// import 'package:java_code/modules/models/user_data_res/user.dart';

import 'package:java_code/utils/services/hive_services.dart';
import 'package:package_info_plus/package_info_plus.dart';

class ProfileController extends GetxController {
  static ProfileController get to => Get.find();
  var box = Hive.box<User>(HiveConst.userHiveBox);
  RxBool isLoading = false.obs;
  User? userData;
  XFile? pickedFile;
  CroppedFile? croppedFile;
  GetUserDetail? userDetail;
  UserDetailData? userDetailDataTemp;
  XFile? pickedFileKTP;
  CroppedFile? croppedFileKTP;
  ProfileRepository repository = ProfileRepository();
  DateFormat formatter = DateFormat('dd/MM/yyyy');
  var languageBox = Hive.box(HiveConst.languageHiveBox);
  String? selectedLanguage;

  PackageInfo packageInfo = PackageInfo(
    appName: '',
    packageName: '',
    version: '',
    buildNumber: '',
    buildSignature: '',
  );

  DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  Map<String, dynamic> deviceData = <String, dynamic>{};
  AndroidDeviceInfo? androidDeviceInfo;
  IosDeviceInfo? iosDeviceInfo;

  Future<void> initPlatformState() async {
    if (Platform.isAndroid) {
      androidDeviceInfo = await deviceInfoPlugin.androidInfo;
    } else if (Platform.isIOS) {
      iosDeviceInfo = await deviceInfoPlugin.iosInfo;
    }
  }

  Future<void> initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();

    packageInfo = info;
    update();
  }

  setUserData() async {
    isLoading = true.obs;
    update();

    GetUserDetail? getUserDetail = await repository.getUserDetail();
    userData = box.values.first;

    userDetail = getUserDetail;
    userDetailDataTemp = getUserDetail.data!;

    isLoading = false.obs;
    update();
  }

  Future<void> keluar() async {
    await HiveServices.deleteAkses(HiveConst.aksesHiveKey, HiveConst.aksesHiveBox);
    await HiveServices.deleteToken(HiveConst.dataUserTokenHiveKey, HiveConst.dataUserTokenHiveBox);
    await HiveServices.deleteUserData(HiveConst.userHiveKey, HiveConst.userHiveBox);

    await HiveServices.deleteMenu(HiveConst.orderHiveKey);

    print('DEBUG PROFILE CONTROLLER');
    // print(AksesManager.getAllNotes().toMap());
    // print(DataUserManager.getAllNotes().toMap());
    // print(UserManager.getAllNotes().toMap()[HiveConst.userHiveKey]?.email);

    Get.offAllNamed(AppRoutes.login);
  }

  /// ================== LOGOUT ==================
  // FirebaseAuth auth = FirebaseAuth.instance;
  // FirebaseFirestore firestore = FirebaseFirestore.instance;
  // Future<void> logout() async {
  //   try {
  //     await auth.signOut();
  //     Get.offAllNamed(AppRoutes.login);
  //     Get.snackbar(
  //       "Berhasil",
  //       "Anda Berhasil Logout",
  //       backgroundColor: Colours.green2,
  //       overlayBlur: 1,
  //       duration: const Duration(seconds: 1),
  //     );
  //   } catch (e) {
  //     print(e.toString());
  //     Get.snackbar(
  //       "Terjadi Kesalahan",
  //       "Tidak Berhasil Logout. Hubungi Admin",
  //       backgroundColor: Colours.green2,
  //       overlayBlur: 1,
  //       duration: const Duration(seconds: 1),
  //     );
  //   }
  // }

  ///
  Future<void> uploadImage(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().pickImage(
      source: imageSource,
      imageQuality: 60,
      maxHeight: 1920,
      maxWidth: 1080,
    );
    if (pickedFile != null) {
      log(pickedFile.name);
      this.pickedFile = pickedFile;
      await cropImage();
    }
  }

  ///
  Future<void> cropImage() async {
    if (pickedFile != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile!.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 50,
      );
      if (croppedFile != null) {
        this.croppedFile = croppedFile;
        update();
      }
    }
  }

  ///
  updateProfile() async {
    isLoading = true.obs;
    update();

    File file = File(croppedFile!.path);

    final bytes = file.readAsBytesSync();
    String base64Image = base64Encode(bytes);

    GetUserDetail? getUserDetail = await repository.updateProfile(key: "image", value: base64Image);

    userDetail = getUserDetail;
    userDetailDataTemp = getUserDetail.data!;
    updateUserBox(userDetailDataTemp!);

    pickedFile = null;
    croppedFile = null;

    isLoading = false.obs;
    update();
  }

  updateUserBox(UserDetailData newUserData) async {
    User user = box.values.first;

    user.nama = newUserData.nama;
    user.nama = newUserData.nama;
    user.foto = newUserData.foto;
    user.pin = newUserData.pin;

    box.put(box.keys.first, user);
  }

  Future<void> uploadImageKTP(ImageSource imageSource) async {
    final pickedFileKTP = await ImagePicker().pickImage(
      source: imageSource,
      imageQuality: 60,
      maxHeight: 1920,
      maxWidth: 1080,
    );
    if (pickedFileKTP != null) {
      this.pickedFileKTP = pickedFileKTP;
      await cropImageKTP();
    }
  }

  Future<void> cropImageKTP() async {
    if (pickedFileKTP != null) {
      final croppedFileKTP = await ImageCropper().cropImage(
        sourcePath: pickedFileKTP!.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 50,
        // aspectRatioPresets: [
        //   CropAspectRatioPreset.ratio16x9
        // ],
      );
      if (croppedFileKTP != null) {
        this.croppedFileKTP = croppedFileKTP;
        update();
      }
    }
  }

  ///
  updateData(String key, String newValue) async {
    isLoading = true.obs;
    update();

    GetUserDetail? getUserDetail = await repository.updateUserDetailByKey(key: key, value: newValue);

    userDetail = getUserDetail;
    userDetailDataTemp = getUserDetail.data;
    updateUserBox(userDetailDataTemp!);
    isLoading = false.obs;
    update();
  }

  setSelectedLanguage() {
    selectedLanguage = languageBox.get("country_id");
    if (selectedLanguage == null) {
      languageBox.put("country_id", Get.deviceLocale?.languageCode ?? "en");
    }
  }

  updateLanguage(String countryId) {
    languageBox.put("country_id", countryId);
    selectedLanguage = countryId;
    Get.updateLocale(Locale(countryId));
    update();
  }

  @override
  void onInit() {
    super.onInit();
    setUserData();
    initPackageInfo();
    initPlatformState();
    setSelectedLanguage();
  }
}
