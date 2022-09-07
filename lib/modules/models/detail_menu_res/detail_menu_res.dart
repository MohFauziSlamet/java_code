import 'package:json_annotation/json_annotation.dart';

import 'data.dart';

part 'detail_menu_res.g.dart';

@JsonSerializable()
class DetailMenuRes {
  @JsonKey(name: 'status_code')
  int? statusCode;
  Data? data;

  DetailMenuRes({this.statusCode, this.data});

  factory DetailMenuRes.fromJson(Map<String, dynamic> json) {
    return _$DetailMenuResFromJson(json);
  }

  Map<String, dynamic> toJson() => _$DetailMenuResToJson(this);
}
