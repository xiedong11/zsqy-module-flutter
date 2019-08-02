import 'package:data_plugin/bmob/table/bmob_object.dart';
import 'package:json_annotation/json_annotation.dart';

//此处与类名一致，由指令自动生成代码
//flutter packages pub run build_runner build
part 'OrderEntity.g.dart';

@JsonSerializable()
class OrderEntity extends BmobObject {
  String title;
  int type;

  OrderEntity();

  @override
  Map getParams() {
    return null;
  }

  //此处与类名一致，由指令自动生成代码
  factory OrderEntity.fromJson(Map<String, dynamic> json) => _$OrderEntityFromJson(json);

  //此处与类名一致，由指令自动生成代码
  Map<String, dynamic> toJson() => _$OrderEntityToJson(this);


}
