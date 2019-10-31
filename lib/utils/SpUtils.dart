import 'package:shared_preferences/shared_preferences.dart';

class SpUtils {
  static const SP_KEY_USER_NAME = "userName";
  static const SP_KEY_PASS_WORD = "passWord";
  static const SOCIAL_HOME_GOODS_IMG_URL = "socialHomeGoodsImgUrl";
  static const SOCIAL_HOME_GOODS_DESC = "socialHomeGoodsDesc";
  static const USER_TOKEN = "userToken";

  static Future saveString(String key, String value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(key, value);
  }

  static Future<String> getString(String key) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.get(key);
  }
}
