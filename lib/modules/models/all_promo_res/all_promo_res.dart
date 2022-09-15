import 'package:json_annotation/json_annotation.dart';
import 'data_promo.dart';
part 'all_promo_res.g.dart';

@JsonSerializable()
class AllPromoRes {
  @JsonKey(name: 'status_code')
  int? statusCode;
  List<DataPromo>? data;

  AllPromoRes({this.statusCode, this.data});

  factory AllPromoRes.fromJson(Map<String, dynamic> json) {
    return _$AllPromoResFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AllPromoResToJson(this);
}
