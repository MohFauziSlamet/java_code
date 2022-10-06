// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_diskon_by_user_id_res.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetDiskonByUserIdRes _$GetDiskonByUserIdResFromJson(
        Map<String, dynamic> json) =>
    GetDiskonByUserIdRes(
      statusCode: json['status_code'] as int?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => DataDiskon.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetDiskonByUserIdResToJson(
        GetDiskonByUserIdRes instance) =>
    <String, dynamic>{
      'status_code': instance.statusCode,
      'data': instance.data,
    };
