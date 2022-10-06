class OrderMenuRes {
  OrderMenuRes({
    required this.idMenu,
    required this.harga,
    required this.level,
    required this.topping,
    required this.jumlah,
  });
  late final int idMenu;
  late final int harga;
  late final int level;
  late final List<int> topping;
  late final int jumlah;

  OrderMenuRes.fromJson(Map<String, dynamic> json) {
    idMenu = json['id_menu'];
    harga = json['harga'];
    level = json['level'];
    topping = List.castFrom<dynamic, int>(json['topping']);
    jumlah = json['jumlah'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id_menu'] = idMenu;
    data['harga'] = harga;
    data['level'] = level;
    data['topping'] = topping;
    data['jumlah'] = jumlah;
    return data;
  }
}
