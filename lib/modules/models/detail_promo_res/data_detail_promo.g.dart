// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_detail_promo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataDetailPromo _$DataDetailPromoFromJson(Map<String, dynamic> json) =>
    DataDetailPromo(
      idPromo: json['id_promo'] as int?,
      nama: json['nama'] as String?,
      type: json['type'] as String?,
      diskon: json['diskon'] as int?,
      nominal: json['nominal'] as int?,
      kadaluarsa: json['kadaluarsa'],
      syaratKetentuan: json['syarat_ketentuan'] as String?,
      foto: json['foto'],
      createdAt: json['created_at'] as int?,
      createdBy: json['created_by'] as int?,
      isDeleted: json['is_deleted'] as int?,
    );

Map<String, dynamic> _$DataDetailPromoToJson(DataDetailPromo instance) =>
    <String, dynamic>{
      'id_promo': instance.idPromo,
      'nama': instance.nama,
      'type': instance.type,
      'diskon': instance.diskon,
      'nominal': instance.nominal,
      'kadaluarsa': instance.kadaluarsa,
      'syarat_ketentuan': instance.syaratKetentuan,
      'foto': instance.foto,
      'created_at': instance.createdAt,
      'created_by': instance.createdBy,
      'is_deleted': instance.isDeleted,
    };
