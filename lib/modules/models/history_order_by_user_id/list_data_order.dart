import 'package:json_annotation/json_annotation.dart';

import 'menu.dart';

part 'list_data_order.g.dart';

@JsonSerializable()
class ListDataOrder {
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

  ListDataOrder({
    this.idOrder,
    this.noStruk,
    this.nama,
    this.totalBayar,
    this.tanggal,
    this.status,
    this.menu,
  });

  factory ListDataOrder.fromJson(Map<String, dynamic> json) {
    return _$ListDataOrderFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ListDataOrderToJson(this);
}
