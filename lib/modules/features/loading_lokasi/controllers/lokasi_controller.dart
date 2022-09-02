import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:get/get.dart';

import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:java_code/config/routes/app_routes.dart';

class LoadingController extends GetxController {
  static LoadingController get to => Get.find();
  RxString address = 'Tidak dapat menemukan lokasi'.obs;
  bool isFindLocation = false;

  /// INISIASI FIREABASE cloud_firestore
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  /// =============== CHANGE PAGE ===============
  Future<void> initLocation() async {
    Map<String, dynamic> data = await determinePosition();

    if (data['error'] != true) {
      Position position = data['position'];
      isFindLocation = true;

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      // print(placemarks[0]);

      address.value =
          "${placemarks[0].street} ${placemarks[0].administrativeArea} ${placemarks[0].subAdministrativeArea} , ${placemarks[0].postalCode} - ${placemarks[0].country} ${placemarks[0].isoCountryCode}";
    }

    if (isFindLocation == true) {
      Future.delayed(const Duration(seconds: 2))
          .then((_) => Get.offAllNamed(AppRoutes.dashboardView));
    }
  }

  /// =============== GET LOCATION ===============
// Determine the current position of the device.
//  When the location services are not enabled or permissions
//  are denied the `Future` will return an error.
  Future<Map<String, dynamic>> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      // return Future.error('Location services are disabled.');
      return {
        "message": "Tidak dapat mengakses GPS pada device ini",
        "error": true,
      };
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        // return Future.error('Location permissions are denied');
        return {
          "message": "Izin mengakses GPS ditolak.",
          "error": true,
        };
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return {
        "message":
            "Settingan hp kamu tidak memperbolehkan mengakses GPS. Ubah settingan hp kamu.",
        "error": true,
      };
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    return {
      "position": position,
      "message": "Berhasil mendapatkan posisi device",
      "error": false,
    };
  }
}
