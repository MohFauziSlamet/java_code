import 'package:intl/intl.dart';
import 'package:java_code/modules/models/detail_menu_res/menu.dart';

class CommonFunctions {
  final formatCurrency = NumberFormat.decimalPattern();

  String convertDate(String date, String format) {
    var dateFormat = DateFormat('yyyy-MM-dd');

    var formattedDate = dateFormat.parse(date);

    var outputFormat = DateFormat(format);
    var outputDate = outputFormat.format(formattedDate);

    return outputDate;
  }

  String getListMenuName(List<Menu> data) {
    List<String> result = data.map((Menu e) {
      return e.nama ?? "";
    }).toList();

    return result.join(", ");
  }
}
