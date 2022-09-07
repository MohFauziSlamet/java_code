// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Menu _$MenuFromJson(Map<String, dynamic> json) => Menu(
      idMenu: json['id_menu'] as int?,
      nama: json['nama'] as String?,
      kategori: json['kategori'] as String?,
      harga: json['harga'] as int?,
      deskripsi: json['deskripsi'] as String?,
      foto: json['foto'] as String?,
      status: json['status'] as int?,
    );

Map<String, dynamic> _$MenuToJson(Menu instance) => <String, dynamic>{
      'id_menu': instance.idMenu,
      'nama': instance.nama,
      'kategori': instance.kategori,
      'harga': instance.harga,
      'deskripsi': instance.deskripsi,
      'foto': instance.foto,
      'status': instance.status,
    };
