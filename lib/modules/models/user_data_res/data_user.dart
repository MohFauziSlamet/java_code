import 'package:java_code/constant/core/hive_const.dart';
import 'package:java_code/modules/models/user_data_res/user.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'data_user.g.dart';

@JsonSerializable()
@HiveType(typeId: 1)
class DataUser extends HiveObject {
  @HiveField(0)
  User? user;
  @HiveField(1)
  String? token;

  DataUser({this.user, this.token});

  factory DataUser.fromJson(Map<String, dynamic> json) =>
      _$DataUserFromJson(json);

  Map<String, dynamic> toJson() => _$DataUserToJson(this);
}

class DataUserManager {
  static Box<DataUser> getAllNotes() =>
      Hive.box<DataUser>(HiveConst.dataUserTokenHiveBox);
}
