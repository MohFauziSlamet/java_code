import 'package:json_annotation/json_annotation.dart';

part 'user_detail_data.g.dart';

@JsonSerializable()
class UserDetailData {
  @JsonKey(name: 'id_user')
  int? idUser;
  String? nama;
  String? email;
  @JsonKey(name: 'tgl_lahir')
  String? tglLahir;
  dynamic alamat;
  String? telepon;
  String? foto;
  dynamic ktp;
  String? pin;
  int? status;
  @JsonKey(name: 'is_customer')
  int? isCustomer;
  @JsonKey(name: 'roles_id')
  int? rolesId;
  String? roles;

  UserDetailData({
    this.idUser,
    this.nama,
    this.email,
    this.tglLahir,
    this.alamat,
    this.telepon,
    this.foto,
    this.ktp,
    this.pin,
    this.status,
    this.isCustomer,
    this.rolesId,
    this.roles,
  });

  factory UserDetailData.fromJson(Map<String, dynamic> json) => _$UserDetailDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserDetailDataToJson(this);
}
