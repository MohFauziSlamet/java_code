import 'package:json_annotation/json_annotation.dart';

part 'topping.g.dart';

@JsonSerializable()
class Topping {
  @JsonKey(name: 'id_detail')
  int? idDetail;
  @JsonKey(name: 'id_menu')
  int? idMenu;
  String? keterangan;
  String? type;
  int? harga;
  bool isSelected;

  Topping({
    this.idDetail,
    this.idMenu,
    this.keterangan,
    this.type,
    this.harga,
    this.isSelected = false,
  });

  factory Topping.fromJson(Map<String, dynamic> json) =>
      _$ToppingFromJson(json);

  Map<String, dynamic> toJson() => _$ToppingToJson(this);
}
