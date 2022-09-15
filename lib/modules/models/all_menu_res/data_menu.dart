import 'package:json_annotation/json_annotation.dart';

part 'data_menu.g.dart';

@JsonSerializable()
class DataMenu {
  @JsonKey(name: 'id_menu')
  int? idMenu;
  String? nama;
  String? kategori;
  int? harga;
  String? deskripsi;
  String? foto;
  int? status;
  int? count;

  DataMenu({
    this.idMenu,
    this.nama,
    this.kategori,
    this.harga,
    this.deskripsi,
    this.foto,
    this.status,
    this.count = 0,
  });

  factory DataMenu.fromJson(Map<String, dynamic> json) =>
      _$DataMenuFromJson(json);

  Map<String, dynamic> toJson() => _$DataMenuToJson(this);

  int get kategoriWeight {
    switch (kategori) {
      case 'makanan':
        return 1;

      case 'snack':
        return 2;

      default:
        return 3;
    }
  }
}
