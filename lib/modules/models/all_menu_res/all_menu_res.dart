import 'package:json_annotation/json_annotation.dart';

import 'data_menu.dart';

part 'all_menu_res.g.dart';

@JsonSerializable()
class AllMenuRes {
  @JsonKey(name: 'status_code')
  int? statusCode;
  List<DataMenu>? data;

  AllMenuRes({this.statusCode, this.data});

  factory AllMenuRes.fromJson(Map<String, dynamic> json) {
    return _$AllMenuResFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AllMenuResToJson(this);
}
