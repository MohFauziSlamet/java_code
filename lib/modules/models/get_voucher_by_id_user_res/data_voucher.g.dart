// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_voucher.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataVoucher _$DataVoucherFromJson(Map<String, dynamic> json) => DataVoucher(
      idVoucher: json['id_voucher'] as int?,
      nama: json['nama'] as String?,
      idUser: json['id_user'] as int?,
      nominal: json['nominal'] as int?,
      infoVoucher: json['info_voucher'] as String?,
      periodeMulai: json['periode_mulai'] as int?,
      periodeSelesai: json['periode_selesai'] as int?,
      type: json['type'] as int?,
      status: json['status'] as int?,
      catatan: json['catatan'],
    );

Map<String, dynamic> _$DataVoucherToJson(DataVoucher instance) =>
    <String, dynamic>{
      'id_voucher': instance.idVoucher,
      'nama': instance.nama,
      'id_user': instance.idUser,
      'nominal': instance.nominal,
      'info_voucher': instance.infoVoucher,
      'periode_mulai': instance.periodeMulai,
      'periode_selesai': instance.periodeSelesai,
      'type': instance.type,
      'status': instance.status,
      'catatan': instance.catatan,
    };
