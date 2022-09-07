import 'package:json_annotation/json_annotation.dart';

import 'datum.dart';

part 'kategori_menu_res.g.dart';

@JsonSerializable()
class KategoriMenuRes {
  @JsonKey(name: 'status_code')
  int? statusCode;
  List<Datum>? data;

  KategoriMenuRes({this.statusCode, this.data});

  factory KategoriMenuRes.fromJson(Map<String, dynamic> json) {
    return _$KategoriMenuResFromJson(json);
  }

  Map<String, dynamic> toJson() => _$KategoriMenuResToJson(this);
}
