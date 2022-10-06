import 'package:json_annotation/json_annotation.dart';

import 'data_voucher.dart';

part 'get_voucher_by_id_user_res.g.dart';

@JsonSerializable()
class GetVoucherByIdUserRes {
  @JsonKey(name: 'status_code')
  int? statusCode;
  List<DataVoucher>? data;

  GetVoucherByIdUserRes({this.statusCode, this.data});

  factory GetVoucherByIdUserRes.fromJson(Map<String, dynamic> json) {
    return _$GetVoucherByIdUserResFromJson(json);
  }

  Map<String, dynamic> toJson() => _$GetVoucherByIdUserResToJson(this);
}
