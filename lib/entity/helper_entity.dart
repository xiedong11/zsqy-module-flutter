import 'package:data_plugin/bmob/table/bmob_object.dart';
import 'package:flutter_app/entity/user_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'helper_entity.g.dart';

@JsonSerializable()
class HelperEntity extends BmobObject {
  String title;
  String detail;
  String price;
  String where;
  String start;
  String end;
  String phoneNumber;
  User user;

  HelperEntity();

  @override
  Map getParams() {
    return toJson();
  }

  factory HelperEntity.fromJson(Map<String, dynamic> json) => _$HelperEntityFromJson(json);
  Map<String, dynamic> toJson() => _$HelperEntityToJson(this);
}
