import 'package:data_plugin/bmob/bmob.dart';
import 'package:data_plugin/bmob/bmob_query.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/entity/user_entity.dart';
import 'package:flutter_app/utils/plat_form_util.dart';

class UserCache {
  static User user;

  static Future<Null> initAppConfigId() async {
    try {
      List result =
          await PlatFormUtil.callNativeApp(PlatFormUtil.GET_APP_CONFIG);
      Bmob.initMasterKey(result[0], result[1], "");
      String userObjectId =
          await PlatFormUtil.callNativeApp(PlatFormUtil.GET_USER_OBJECT_ID);
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
