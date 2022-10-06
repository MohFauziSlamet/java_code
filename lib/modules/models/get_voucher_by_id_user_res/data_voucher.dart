import 'package:json_annotation/json_annotation.dart';

part 'data_voucher.g.dart';

@JsonSerializable()
class DataVoucher {
  @JsonKey(name: 'id_voucher')
  int? idVoucher;
  String? nama;
  @JsonKey(name: 'id_user')
  int? idUser;
  int? nominal;
  @JsonKey(name: 'info_voucher')
  String? infoVoucher;
  @JsonKey(name: 'periode_mulai')
  int? periodeMulai;
  @JsonKey(name: 'periode_selesai')
  int? periodeSelesai;
  int? type;
  int? status;
  dynamic catatan;

  DataVoucher({
    this.idVoucher,
    this.nama,
    this.idUser,
    this.nominal,
    this.infoVoucher,
    this.periodeMulai,
    this.periodeSelesai,
    this.type,
    this.status,
    this.catatan,
  });

  factory DataVoucher.fromJson(Map<String, dynamic> json) =>
      _$DataVoucherFromJson(json);

  Map<String, dynamic> toJson() => _$DataVoucherToJson(this);
}
