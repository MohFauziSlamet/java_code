import 'package:json_annotation/json_annotation.dart';

import 'list_data_order.dart';

part 'data.g.dart';

@JsonSerializable()
class Data {
  List<ListDataOrder>? listData;
  int? totalPrice;
  int? totalOrder;

  Data({this.listData, this.totalPrice, this.totalOrder});

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
