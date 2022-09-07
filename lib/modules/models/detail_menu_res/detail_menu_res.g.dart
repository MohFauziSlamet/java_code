// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_menu_res.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DetailMenuRes _$DetailMenuResFromJson(Map<String, dynamic> json) =>
    DetailMenuRes(
      statusCode: json['status_code'] as int?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DetailMenuResToJson(DetailMenuRes instance) =>
    <String, dynamic>{
      'status_code': instance.statusCode,
      'data': instance.data,
    };
