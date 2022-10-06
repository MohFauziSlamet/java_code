import 'dart:async';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ConnectionManagerController extends GetxController {
  RxInt connectionType = 0.obs;

  static ConnectionManagerController get to => Get.find();

  final Connectivity _connectivity = Connectivity();

  late StreamSubscription _streamSubscription;

  @override
  void onInit() {
    getConnectivityType();
    _streamSubscription =
        _connectivity.onConnectivityChanged.listen(_updateState);
    super.onInit();
  }

  Future<void> getConnectivityType() async {
    late ConnectivityResult connectivityResult;

    try {
      connectivityResult = await (_connectivity.checkConnectivity());
    } on PlatformException catch (e) {
      if (kDebugMode) {
        log(e.toString());
      }
    }

    return _updateState(connectivityResult);
  }

  _updateState(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.wifi:
        connectionType.value = 1;
        update();
        break;
      case ConnectivityResult.mobile:
        connectionType.value = 2;
        update();
        break;
      case ConnectivityResult.none:
        connectionType.value = 0;
        update();
        break;
      default:
        connectionType.value = 0;
    }
  }

  @override
  void onClose() {
    _streamSubscription.cancel();
  }
}
