import 'package:json_annotation/json_annotation.dart';
part 'data_detail_promo.g.dart';

@JsonSerializable()
class DataDetailPromo {
  @JsonKey(name: 'id_promo')
  int? idPromo;
  String? nama;
  String? type;
  int? diskon;
  int? nominal;
  dynamic kadaluarsa;
  @JsonKey(name: 'syarat_ketentuan')
  String? syaratKetentuan;
  dynamic foto;
  @JsonKey(name: 'created_at')
  int? createdAt;
  @JsonKey(name: 'created_by')
  int? createdBy;
  @JsonKey(name: 'is_deleted')
  int? isDeleted;

  DataDetailPromo({
    this.idPromo,
    this.nama,
    this.type,
    this.diskon,
    this.nominal,
    this.kadaluarsa,
    this.syaratKetentuan,
    this.foto,
    this.createdAt,
    this.createdBy,
    this.isDeleted,
  });

  factory DataDetailPromo.fromJson(Map<String, dynamic> json) =>
      _$DataDetailPromoFromJson(json);

  Map<String, dynamic> toJson() => _$DataDetailPromoToJson(this);
}
