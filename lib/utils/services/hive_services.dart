import 'package:hive/hive.dart';
import 'package:java_code/constant/core/hive_const.dart';
import 'package:java_code/modules/models/hive/order_hive_model.dart';
import 'package:java_code/modules/models/user_data_res/akses.dart';
import 'package:java_code/modules/models/user_data_res/data_user.dart';
import 'package:java_code/modules/models/user_data_res/user.dart';

class HiveServices {
  HiveServices._();
  // HiveServices({this.boxName = ''});
  // String boxName;
  static var aksesBox = Hive.box<Akses>(HiveConst.aksesHiveBox);
  static var userTokenBox = Hive.box<DataUser>(HiveConst.dataUserTokenHiveBox);
  static var userDataBox = Hive.box<User>(HiveConst.userHiveBox);
  static var orderMenuBox = Hive.box<OrderHive>(HiveConst.orderHiveBox);

  /// SERVICE AKSES BOX
  static Future<void> putAkses(String key, dynamic data) async {
    await aksesBox.put(key, data);
  }

  static Future<void> deleteAkses(String key, data) async {
    await aksesBox.delete(key);
  }

  /// SERVICE TOKEN BOX
  static Future<void> putToken(String key, dynamic data) async {
    await userTokenBox.put(key, data);
  }

  static Future<void> deleteToken(String key, data) async {
    await userTokenBox.delete(key);
  }

  /// SERVICE TOKEN BOX
  static Future<void> putUserData(String key, data) async {
    await userDataBox.put(key, data);
  }

  static Future<void> deleteUserData(String key, data) async {
    await userDataBox.delete(key);
  }

  /// SERVICE TOKEN BOX

  static Future<void> addOrderMenu(OrderHive data) async {
    await orderMenuBox.put(HiveConst.orderHiveKey, data);
  }

  static Future<void> deleteMenu(String key) async {
    await orderMenuBox.delete(key);
  }
}
