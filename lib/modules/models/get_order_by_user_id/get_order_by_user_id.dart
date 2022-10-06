import 'package:json_annotation/json_annotation.dart';

import 'data_order.dart';

part 'get_order_by_user_id.g.dart';

@JsonSerializable()
class GetOrderByUserId {
  @JsonKey(name: 'status_code')
  int? statusCode;
  List<DataOrder>? data;

  GetOrderByUserId({this.statusCode, this.data});

  factory GetOrderByUserId.fromJson(Map<String, dynamic> json) {
    return _$GetOrderByUserIdFromJson(json);
  }

  Map<String, dynamic> toJson() => _$GetOrderByUserIdToJson(this);
}
