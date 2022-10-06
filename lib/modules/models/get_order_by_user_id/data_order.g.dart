// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataOrder _$DataOrderFromJson(Map<String, dynamic> json) => DataOrder(
      idOrder: json['id_order'] as int?,
      noStruk: json['no_struk'] as String?,
      nama: json['nama'] as String?,
      totalBayar: json['total_bayar'] as int?,
      tanggal: json['tanggal'] as String?,
      status: json['status'] as int?,
      menu: (json['menu'] as List<dynamic>?)
          ?.map((e) => Menu.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataOrderToJson(DataOrder instance) => <String, dynamic>{
      'id_order': instance.idOrder,
      'no_struk': instance.noStruk,
      'nama': instance.nama,
      'total_bayar': instance.totalBayar,
      'tanggal': instance.tanggal,
      'status': instance.status,
      'menu': instance.menu,
    };
