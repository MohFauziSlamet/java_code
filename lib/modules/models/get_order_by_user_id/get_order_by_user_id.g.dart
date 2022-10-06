// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_order_by_user_id.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetOrderByUserId _$GetOrderByUserIdFromJson(Map<String, dynamic> json) =>
    GetOrderByUserId(
      statusCode: json['status_code'] as int?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => DataOrder.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetOrderByUserIdToJson(GetOrderByUserId instance) =>
    <String, dynamic>{
      'status_code': instance.statusCode,
      'data': instance.data,
    };
