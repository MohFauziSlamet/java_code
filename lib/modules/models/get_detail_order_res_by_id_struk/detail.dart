import 'package:json_annotation/json_annotation.dart';

part 'detail.g.dart';

@JsonSerializable()
class Detail {
  @JsonKey(name: 'id_menu')
  int? idMenu;
  String? kategori;
  String? topping;
  String? nama;
  String? foto;
  int? jumlah;
  String? harga;
  int? total;
  String? catatan;

  Detail({
    this.idMenu,
    this.kategori,
    this.topping,
    this.nama,
    this.foto,
    this.jumlah,
    this.harga,
    this.total,
    this.catatan,
  });

  factory Detail.fromJson(Map<String, dynamic> json) {
    return _$DetailFromJson(json);
  }

  Map<String, dynamic> toJson() => _$DetailToJson(this);
}
