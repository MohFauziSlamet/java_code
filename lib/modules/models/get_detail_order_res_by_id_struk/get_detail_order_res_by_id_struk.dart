import 'package:json_annotation/json_annotation.dart';

import 'data.dart';

part 'get_detail_order_res_by_id_struk.g.dart';

@JsonSerializable()
class GetDetailOrderResByIdStruk {
  @JsonKey(name: 'status_code')
  int? statusCode;
  Data? data;

  GetDetailOrderResByIdStruk({this.statusCode, this.data});

  factory GetDetailOrderResByIdStruk.fromJson(Map<String, dynamic> json) {
    return _$GetDetailOrderResByIdStrukFromJson(json);
  }

  Map<String, dynamic> toJson() => _$GetDetailOrderResByIdStrukToJson(this);
}
