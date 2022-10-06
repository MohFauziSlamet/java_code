// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_order_res.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostOrderRes _$PostOrderResFromJson(Map<String, dynamic> json) => PostOrderRes(
      statusCode: json['status_code'] as int?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PostOrderResToJson(PostOrderRes instance) =>
    <String, dynamic>{
      'status_code': instance.statusCode,
      'data': instance.data,
    };
