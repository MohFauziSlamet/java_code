// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_order_by_user_id.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoryOrderByUserId _$HistoryOrderByUserIdFromJson(
        Map<String, dynamic> json) =>
    HistoryOrderByUserId(
      statusCode: json['status_code'] as int?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$HistoryOrderByUserIdToJson(
        HistoryOrderByUserId instance) =>
    <String, dynamic>{
      'status_code': instance.statusCode,
      'data': instance.data,
    };
