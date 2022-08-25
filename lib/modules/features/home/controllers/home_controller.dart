import 'package:get/get.dart';

class HomeController extends GetxController {
  int selectedNavbar = 0;
  void changeSelectedNavBar(int index) {
    selectedNavbar = index;

    update();
  }
}
