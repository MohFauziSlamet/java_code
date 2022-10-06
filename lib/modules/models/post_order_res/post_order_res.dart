import 'package:json_annotation/json_annotation.dart';

import 'data.dart';

part 'post_order_res.g.dart';

@JsonSerializable()
class PostOrderRes {
  @JsonKey(name: 'status_code')
  int? statusCode;
  Data? data;

  PostOrderRes({this.statusCode, this.data});

  factory PostOrderRes.fromJson(Map<String, dynamic> json) {
    return _$PostOrderResFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PostOrderResToJson(this);
}
