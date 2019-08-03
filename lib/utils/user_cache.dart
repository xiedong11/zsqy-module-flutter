import 'package:data_plugin/bmob/bmob.dart';
import 'package:data_plugin/bmob/bmob_query.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/entity/user_entity.dart';

const platform = const MethodChannel("zhuandian.flutter");

class UserCache {
  static User user;

  static Future<Null> initAppConfigId() async {
    try {
      List result = await platform.invokeMethod("getAppConfig");
      Bmob.initMasterKey(result[0], result[1], "");
      String userObjectId = await platform.invokeMethod("getUserObjectId");
      BmobQuery<User> query = BmobQuery();
      query.queryUser(userObjectId).then((data) {
        User userEntity = User.fromJson(data);
        user = userEntity;
      }).catchError((e) {
        print(e.toString() + '---------------');
      });
    } on PlatformException catch (e) {
      print(e.toString() + "-------------------------");
    }
  }
}
