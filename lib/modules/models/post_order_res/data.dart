import 'package:json_annotation/json_annotation.dart';

part 'data.g.dart';

@JsonSerializable()
class Data {
  @JsonKey(name: 'id_order')
  int? idOrder;
  @JsonKey(name: 'no_struk')
  String? noStruk;
  String? message;

  Data({this.idOrder, this.noStruk, this.message});

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
