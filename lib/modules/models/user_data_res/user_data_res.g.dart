// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data_res.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataUserRes _$DataUserResFromJson(Map<String, dynamic> json) => DataUserRes(
      statusCode: json['status_code'] as int?,
      data: json['data'] == null
          ? null
          : DataUser.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DataUserResToJson(DataUserRes instance) =>
    <String, dynamic>{
      'status_code': instance.statusCode,
      'data': instance.data,
    };
