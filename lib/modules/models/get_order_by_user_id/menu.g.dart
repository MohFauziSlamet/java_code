// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Menu _$MenuFromJson(Map<String, dynamic> json) => Menu(
      idMenu: json['id_menu'] as int?,
      kategori: json['kategori'] as String?,
      topping: json['topping'] as String?,
      nama: json['nama'] as String?,
      foto: json['foto'] as String?,
      jumlah: json['jumlah'] as int?,
      harga: json['harga'] as String?,
      total: json['total'] as int?,
      catatan: json['catatan'] as String?,
    );

Map<String, dynamic> _$MenuToJson(Menu instance) => <String, dynamic>{
      'id_menu': instance.idMenu,
      'kategori': instance.kategori,
      'topping': instance.topping,
      'nama': instance.nama,
      'foto': instance.foto,
      'jumlah': instance.jumlah,
      'harga': instance.harga,
      'total': instance.total,
      'catatan': instance.catatan,
    };
