// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'level.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Level _$LevelFromJson(Map<String, dynamic> json) => Level(
      idDetail: json['id_detail'] as int?,
      idMenu: json['id_menu'] as int?,
      keterangan: json['keterangan'] as String?,
      type: json['type'] as String?,
      harga: json['harga'] as int?,
      isSelected: json['isSelected'] as bool? ?? false,
    );

Map<String, dynamic> _$LevelToJson(Level instance) => <String, dynamic>{
      'id_detail': instance.idDetail,
      'id_menu': instance.idMenu,
      'keterangan': instance.keterangan,
      'type': instance.type,
      'harga': instance.harga,
      'isSelected': instance.isSelected,
    };
