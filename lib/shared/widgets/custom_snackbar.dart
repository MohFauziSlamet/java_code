import 'package:get/get.dart';
import 'package:java_code/config/themes/colours.dart';

class CustomSnackbar {
  // CustomSnackbar._();

  snackBar({required String title, required String message}) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colours.green2,
      duration: const Duration(seconds: 1),
    );
  }
}
