// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kategori_menu_res.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KategoriMenuRes _$KategoriMenuResFromJson(Map<String, dynamic> json) =>
    KategoriMenuRes(
      statusCode: json['status_code'] as int?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$KategoriMenuResToJson(KategoriMenuRes instance) =>
    <String, dynamic>{
      'status_code': instance.statusCode,
      'data': instance.data,
    };
