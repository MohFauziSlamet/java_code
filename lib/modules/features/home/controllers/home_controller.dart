import 'package:get/get.dart';
import 'package:java_code/config/routes/app_routes.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();

  /// =============== CHANGE PAGE ===============
  RxInt pageIndex = 0.obs;
  void changePage({required int index}) async {
    pageIndex.value = index;
  }
}
