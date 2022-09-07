import 'package:json_annotation/json_annotation.dart';
part 'datum.g.dart';

@JsonSerializable()
class Datum {
  @JsonKey(name: 'id_menu')
  int? idMenu;
  String? nama;
  String? kategori;
  int? harga;
  String? deskripsi;
  String? foto;
  int? status;
  int? count;
  // @JsonKey(count: '0')
  // RxInt count = 0.obs;

  Datum({
    this.idMenu,
    this.nama,
    this.kategori,
    this.harga,
    this.deskripsi,
    this.foto,
    this.status,
    this.count = 0,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);

  Map<String, dynamic> toJson() => _$DatumToJson(this);
}
