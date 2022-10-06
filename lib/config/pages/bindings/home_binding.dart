import 'package:get/get.dart';
import 'package:java_code/modules/features/home/controllers/home_controller.dart';

// untuk mengambil data dari controller
class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(
      HomeController(),
      // agar data tidak dihapus ketika kita keluar dari page tsb
      // permanent: true,
    );
  }
}
