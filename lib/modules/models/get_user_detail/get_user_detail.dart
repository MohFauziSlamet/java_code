import 'package:json_annotation/json_annotation.dart';

import 'user_detail_data.dart';

part 'get_user_detail.g.dart';

@JsonSerializable()
class GetUserDetail {
  @JsonKey(name: 'status_code')
  int? statusCode;
  UserDetailData? data;

  GetUserDetail({this.statusCode, this.data});

  factory GetUserDetail.fromJson(Map<String, dynamic> json) {
    return _$GetUserDetailFromJson(json);
  }

  Map<String, dynamic> toJson() => _$GetUserDetailToJson(this);
}
