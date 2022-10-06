// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      idOrder: json['id_order'] as int?,
      noStruk: json['no_struk'] as String?,
      nama: json['nama'] as String?,
      idVoucher: json['id_voucher'] as int?,
      namaVoucher: json['nama_voucher'],
      diskon: json['diskon'] as int?,
      potongan: json['potongan'] as int?,
      totalBayar: json['total_bayar'] as int?,
      tanggal: json['tanggal'] as String?,
      status: json['status'] as int?,
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'id_order': instance.idOrder,
      'no_struk': instance.noStruk,
      'nama': instance.nama,
      'id_voucher': instance.idVoucher,
      'nama_voucher': instance.namaVoucher,
      'diskon': instance.diskon,
      'potongan': instance.potongan,
      'total_bayar': instance.totalBayar,
      'tanggal': instance.tanggal,
      'status': instance.status,
    };
