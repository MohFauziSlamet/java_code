// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      listData: (json['listData'] as List<dynamic>?)
          ?.map((e) => ListDataOrder.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPrice: json['totalPrice'] as int?,
      totalOrder: json['totalOrder'] as int?,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'listData': instance.listData,
      'totalPrice': instance.totalPrice,
      'totalOrder': instance.totalOrder,
    };
