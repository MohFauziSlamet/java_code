import 'package:json_annotation/json_annotation.dart';

import 'detail.dart';
import 'order.dart';

part 'data.g.dart';

@JsonSerializable()
class Data {
  Order? order;
  List<Detail>? detail;

  Data({this.order, this.detail});

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
