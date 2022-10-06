// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_detail_order_res_by_id_struk.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetDetailOrderResByIdStruk _$GetDetailOrderResByIdStrukFromJson(
        Map<String, dynamic> json) =>
    GetDetailOrderResByIdStruk(
      statusCode: json['status_code'] as int?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetDetailOrderResByIdStrukToJson(
        GetDetailOrderResByIdStruk instance) =>
    <String, dynamic>{
      'status_code': instance.statusCode,
      'data': instance.data,
    };
