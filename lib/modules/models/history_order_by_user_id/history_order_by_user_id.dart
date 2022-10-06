import 'package:json_annotation/json_annotation.dart';

import 'data.dart';

part 'history_order_by_user_id.g.dart';

@JsonSerializable()
class HistoryOrderByUserId {
  @JsonKey(name: 'status_code')
  int? statusCode;
  Data? data;

  HistoryOrderByUserId({this.statusCode, this.data});

  factory HistoryOrderByUserId.fromJson(Map<String, dynamic> json) {
    return _$HistoryOrderByUserIdFromJson(json);
  }

  Map<String, dynamic> toJson() => _$HistoryOrderByUserIdToJson(this);
}
