import 'package:json_annotation/json_annotation.dart';

import 'menu.dart';

part 'data_order.g.dart';

@JsonSerializable()
class DataOrder {
  @JsonKey(name: 'id_order')
  int? idOrder;
  @JsonKey(name: 'no_struk')
  String? noStruk;
  String? nama;
  @JsonKey(name: 'total_bayar')
  int? totalBayar;
  String? tanggal;
  int? status;
  List<Menu>? menu;

  DataOrder({
    this.idOrder,
    this.noStruk,
    this.nama,
    this.totalBayar,
    this.tanggal,
    this.status,
    this.menu,
  });

  factory DataOrder.fromJson(Map<String, dynamic> json) =>
      _$DataOrderFromJson(json);

  Map<String, dynamic> toJson() => _$DataOrderToJson(this);
}
