// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_promo_res.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DetailPromoRes _$DetailPromoResFromJson(Map<String, dynamic> json) =>
    DetailPromoRes(
      statusCode: json['status_code'] as int?,
      data: json['data'] == null
          ? null
          : DataDetailPromo.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DetailPromoResToJson(DetailPromoRes instance) =>
    <String, dynamic>{
      'status_code': instance.statusCode,
      'data': instance.data,
    };
