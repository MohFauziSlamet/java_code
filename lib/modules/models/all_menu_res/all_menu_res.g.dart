// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_menu_res.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllMenuRes _$AllMenuResFromJson(Map<String, dynamic> json) => AllMenuRes(
      statusCode: json['status_code'] as int?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AllMenuResToJson(AllMenuRes instance) =>
    <String, dynamic>{
      'status_code': instance.statusCode,
      'data': instance.data,
    };
