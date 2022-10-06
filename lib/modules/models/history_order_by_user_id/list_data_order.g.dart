// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_data_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListDataOrder _$ListDataOrderFromJson(Map<String, dynamic> json) =>
    ListDataOrder(
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

Map<String, dynamic> _$ListDataOrderToJson(ListDataOrder instance) =>
    <String, dynamic>{
      'id_order': instance.idOrder,
      'no_struk': instance.noStruk,
      'nama': instance.nama,
      'total_bayar': instance.totalBayar,
      'tanggal': instance.tanggal,
      'status': instance.status,
      'menu': instance.menu,
    };
