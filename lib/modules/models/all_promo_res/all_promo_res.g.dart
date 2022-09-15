// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_promo_res.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllPromoRes _$AllPromoResFromJson(Map<String, dynamic> json) => AllPromoRes(
      statusCode: json['status_code'] as int?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => DataPromo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AllPromoResToJson(AllPromoRes instance) =>
    <String, dynamic>{
      'status_code': instance.statusCode,
      'data': instance.data,
    };
