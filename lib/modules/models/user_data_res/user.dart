import 'package:java_code/constant/core/hive_const.dart';
import 'package:java_code/modules/models/user_data_res/akses.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'user.g.dart';

@JsonSerializable()
@HiveType(typeId: 2)
class User extends HiveObject {
  @JsonKey(name: 'id_user')
  @HiveField(1)
  int? idUser;
  @HiveField(2)
  String? email;
  @HiveField(3)
  String? nama;
  @HiveField(4)
  String? pin;
  @HiveField(5)
  String? foto;
  @JsonKey(name: 'm_roles_id')
  @HiveField(6)
  int? mRolesId;
  @JsonKey(name: 'is_google')
  @HiveField(7)
  int? isGoogle;
  @JsonKey(name: 'is_customer')
  @HiveField(8)
  int? isCustomer;
  @HiveField(9)
  String? roles;
  @HiveField(10)
  Akses? akses;

  User({
    this.idUser,
    this.email,
    this.nama,
    this.pin,
    this.foto,
    this.mRolesId,
    this.isGoogle,
    this.isCustomer,
    this.roles,
    this.akses,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

class UserManager {
  static Box<User> getAllNotes() => Hive.box<User>(HiveConst.userHiveBox);
}
