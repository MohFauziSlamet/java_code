// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_user_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetUserDetail _$GetUserDetailFromJson(Map<String, dynamic> json) =>
    GetUserDetail(
      statusCode: json['status_code'] as int?,
      data: json['data'] == null
          ? null
          : UserDetailData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetUserDetailToJson(GetUserDetail instance) =>
    <String, dynamic>{
      'status_code': instance.statusCode,
      'data': instance.data,
    };
