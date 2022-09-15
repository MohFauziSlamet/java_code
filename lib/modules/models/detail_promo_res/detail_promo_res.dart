import 'package:json_annotation/json_annotation.dart';

import 'data_detail_promo.dart';

part 'detail_promo_res.g.dart';

@JsonSerializable()
class DetailPromoRes {
  @JsonKey(name: 'status_code')
  int? statusCode;
  DataDetailPromo? data;

  DetailPromoRes({this.statusCode, this.data});

  factory DetailPromoRes.fromJson(Map<String, dynamic> json) {
    return _$DetailPromoResFromJson(json);
  }

  Map<String, dynamic> toJson() => _$DetailPromoResToJson(this);
}
