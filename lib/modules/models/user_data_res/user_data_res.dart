import 'package:java_code/modules/models/user_data_res/data_user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_data_res.g.dart';

@JsonSerializable()
class DataUserRes {
  @JsonKey(name: 'status_code')
  int? statusCode;

  DataUser? data;

  DataUserRes({this.statusCode, this.data});

  factory DataUserRes.fromJson(Map<String, dynamic> json) {
    return _$DataUserResFromJson(json);
  }

  Map<String, dynamic> toJson() => _$DataUserResToJson(this);
}
