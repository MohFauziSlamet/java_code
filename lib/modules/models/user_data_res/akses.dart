import 'package:java_code/constant/core/hive_const.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'akses.g.dart';

@JsonSerializable()
@HiveType(typeId: 0)
class Akses extends HiveObject {
  @JsonKey(name: 'auth_user')
  @HiveField(0)
  bool? authUser;
  @JsonKey(name: 'auth_akses')
  @HiveField(1)
  bool? authAkses;
  @JsonKey(name: 'setting_menu')
  @HiveField(2)
  bool? settingMenu;
  @JsonKey(name: 'setting_customer')
  @HiveField(3)
  bool? settingCustomer;
  @JsonKey(name: 'setting_promo')
  @HiveField(4)
  bool? settingPromo;
  @JsonKey(name: 'setting_diskon')
  @HiveField(5)
  bool? settingDiskon;
  @JsonKey(name: 'setting_voucher')
  @HiveField(6)
  bool? settingVoucher;
  @JsonKey(name: 'laporan_menu')
  @HiveField(7)
  bool? laporanMenu;
  @JsonKey(name: 'laporan_customer')
  @HiveField(8)
  bool? laporanCustomer;

  Akses({
    this.authUser,
    this.authAkses,
    this.settingMenu,
    this.settingCustomer,
    this.settingPromo,
    this.settingDiskon,
    this.settingVoucher,
    this.laporanMenu,
    this.laporanCustomer,
  });

  factory Akses.fromJson(Map<String, dynamic> json) => _$AksesFromJson(json);

  Map<String, dynamic> toJson() => _$AksesToJson(this);
}

class AksesManager {
  static Box<Akses> getAllNotes() => Hive.box<Akses>(HiveConst.aksesHiveBox);
}
