// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_detail_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDetailData _$UserDetailDataFromJson(Map<String, dynamic> json) =>
    UserDetailData(
      idUser: json['id_user'] as int?,
      nama: json['nama'] as String?,
      email: json['email'] as String?,
      tglLahir: json['tgl_lahir'] as String?,
      alamat: json['alamat'],
      telepon: json['telepon'] as String?,
      foto: json['foto'] as String?,
      ktp: json['ktp'],
      pin: json['pin'] as String?,
      status: json['status'] as int?,
      isCustomer: json['is_customer'] as int?,
      rolesId: json['roles_id'] as int?,
      roles: json['roles'] as String?,
    );

Map<String, dynamic> _$UserDetailDataToJson(UserDetailData instance) =>
    <String, dynamic>{
      'id_user': instance.idUser,
      'nama': instance.nama,
      'email': instance.email,
      'tgl_lahir': instance.tglLahir,
      'alamat': instance.alamat,
      'telepon': instance.telepon,
      'foto': instance.foto,
      'ktp': instance.ktp,
      'pin': instance.pin,
      'status': instance.status,
      'is_customer': instance.isCustomer,
      'roles_id': instance.rolesId,
      'roles': instance.roles,
    };
