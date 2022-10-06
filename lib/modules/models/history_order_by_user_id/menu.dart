import 'package:json_annotation/json_annotation.dart';

part 'menu.g.dart';

@JsonSerializable()
class Menu {
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

  Menu({
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

  factory Menu.fromJson(Map<String, dynamic> json) => _$MenuFromJson(json);

  Map<String, dynamic> toJson() => _$MenuToJson(this);
}
