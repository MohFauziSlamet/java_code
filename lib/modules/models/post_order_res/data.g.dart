// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      idOrder: json['id_order'] as int?,
      noStruk: json['no_struk'] as String?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'id_order': instance.idOrder,
      'no_struk': instance.noStruk,
      'message': instance.message,
    };
