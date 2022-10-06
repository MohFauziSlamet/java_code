import 'package:json_annotation/json_annotation.dart';

part 'order.g.dart';

@JsonSerializable()
class Order {
  @JsonKey(name: 'id_order')
  int? idOrder;
  @JsonKey(name: 'no_struk')
  String? noStruk;
  String? nama;
  @JsonKey(name: 'id_voucher')
  int? idVoucher;
  @JsonKey(name: 'nama_voucher')
  dynamic namaVoucher;
  int? diskon;
  int? potongan;
  @JsonKey(name: 'total_bayar')
  int? totalBayar;
  String? tanggal;
  int? status;

  Order({
    this.idOrder,
    this.noStruk,
    this.nama,
    this.idVoucher,
    this.namaVoucher,
    this.diskon,
    this.potongan,
    this.totalBayar,
    this.tanggal,
    this.status,
  });

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
