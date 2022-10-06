import 'package:java_code/modules/models/get_diskon_by_user_id_res/data_diskon.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_diskon_by_user_id_res.g.dart';

@JsonSerializable()
class GetDiskonByUserIdRes {
  @JsonKey(name: 'status_code')
  int? statusCode;
  List<DataDiskon>? data;

  GetDiskonByUserIdRes({this.statusCode, this.data});

  factory GetDiskonByUserIdRes.fromJson(Map<String, dynamic> json) {
    return _$GetDiskonByUserIdResFromJson(json);
  }

  Map<String, dynamic> toJson() => _$GetDiskonByUserIdResToJson(this);
}
