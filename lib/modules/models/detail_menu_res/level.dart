import 'package:json_annotation/json_annotation.dart';

part 'level.g.dart';

@JsonSerializable()
class Level {
  @JsonKey(name: 'id_detail')
  int? idDetail;
  @JsonKey(name: 'id_menu')
  int? idMenu;
  String? keterangan;
  String? type;
  int? harga;
  bool? isSelected;

  Level(
      {this.idDetail,
      this.idMenu,
      this.keterangan,
      this.type,
      this.harga,
      this.isSelected = false});

  factory Level.fromJson(Map<String, dynamic> json) => _$LevelFromJson(json);

  Map<String, dynamic> toJson() => _$LevelToJson(this);
}
