import 'package:json_annotation/json_annotation.dart';

import 'level.dart';
import 'menu.dart';

part 'data.g.dart';

@JsonSerializable()
class Data {
  Menu? menu;
  List<dynamic>? topping;
  List<Level>? level;

  Data({this.menu, this.topping, this.level});

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
