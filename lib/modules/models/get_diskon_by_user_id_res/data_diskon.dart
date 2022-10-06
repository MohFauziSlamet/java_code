import 'package:json_annotation/json_annotation.dart';

part 'data_diskon.g.dart';

@JsonSerializable()
class DataDiskon {
  @JsonKey(name: 'id_diskon')
  int? idDiskon;
  @JsonKey(name: 'id_user')
  int? idUser;
  @JsonKey(name: 'nama_user')
  String? namaUser;
  String? nama;
  int? diskon;

  DataDiskon({
    this.idDiskon,
    this.idUser,
    this.namaUser,
    this.nama,
    this.diskon,
  });

  factory DataDiskon.fromJson(Map<String, dynamic> json) =>
      _$DataDiskonFromJson(json);

  Map<String, dynamic> toJson() => _$DataDiskonToJson(this);
}
