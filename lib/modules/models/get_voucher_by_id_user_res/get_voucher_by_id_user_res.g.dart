// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_voucher_by_id_user_res.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetVoucherByIdUserRes _$GetVoucherByIdUserResFromJson(
        Map<String, dynamic> json) =>
    GetVoucherByIdUserRes(
      statusCode: json['status_code'] as int?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => DataVoucher.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetVoucherByIdUserResToJson(
        GetVoucherByIdUserRes instance) =>
    <String, dynamic>{
      'status_code': instance.statusCode,
      'data': instance.data,
    };
