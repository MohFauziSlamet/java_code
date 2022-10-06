// ignore_for_file: no_leading_underscores_for_local_identifiers

class ToppingAndLevelRes {
  ToppingAndLevelRes({
    required this.data,
  });
  late final Data data;

  ToppingAndLevelRes.fromJson(Map<String, dynamic> json) {
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.idMenu,
    required this.topping,
    required this.level,
  });
  late final int idMenu;
  late final List<Topping> topping;
  late final List<Level> level;

  Data.fromJson(Map<String, dynamic> json) {
    idMenu = json['id_menu'];
    topping =
        List.from(json['topping']).map((e) => Topping.fromJson(e)).toList();
    level = List.from(json['level']).map((e) => Level.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id_menu'] = idMenu;
    _data['topping'] = topping.map((e) => e.toJson()).toList();
    _data['level'] = level.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Topping {
  Topping({
    required this.idDetail,
    required this.idMenu,
    required this.keterangan,
    required this.type,
    required this.harga,
  });
  late final int idDetail;
  late final int idMenu;
  late final String keterangan;
  late final String type;
  late final int harga;

  Topping.fromJson(Map<String, dynamic> json) {
    idDetail = json['id_detail'];
    idMenu = json['id_menu'];
    keterangan = json['keterangan'];
    type = json['type'];
    harga = json['harga'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id_detail'] = idDetail;
    _data['id_menu'] = idMenu;
    _data['keterangan'] = keterangan;
    _data['type'] = type;
    _data['harga'] = harga;
    return _data;
  }
}

class Level {
  Level({
    required this.idDetail,
    required this.idMenu,
    required this.keterangan,
    required this.type,
    required this.harga,
  });
  late final int idDetail;
  late final int idMenu;
  late final String keterangan;
  late final String type;
  late final int harga;

  Level.fromJson(Map<String, dynamic> json) {
    idDetail = json['id_detail'];
    idMenu = json['id_menu'];
    keterangan = json['keterangan'];
    type = json['type'];
    harga = json['harga'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id_detail'] = idDetail;
    _data['id_menu'] = idMenu;
    _data['keterangan'] = keterangan;
    _data['type'] = type;
    _data['harga'] = harga;
    return _data;
  }
}
