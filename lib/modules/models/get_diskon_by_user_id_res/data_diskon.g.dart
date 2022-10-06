// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_diskon.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataDiskon _$DataDiskonFromJson(Map<String, dynamic> json) => DataDiskon(
      idDiskon: json['id_diskon'] as int?,
      idUser: json['id_user'] as int?,
      namaUser: json['nama_user'] as String?,
      nama: json['nama'] as String?,
      diskon: json['diskon'] as int?,
    );

Map<String, dynamic> _$DataDiskonToJson(DataDiskon instance) =>
    <String, dynamic>{
      'id_diskon': instance.idDiskon,
      'id_user': instance.idUser,
      'nama_user': instance.namaUser,
      'nama': instance.nama,
      'diskon': instance.diskon,
    };
