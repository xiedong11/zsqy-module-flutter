import 'package:flutter/services.dart';

const platform = const MethodChannel("zhuandian.flutter");

class PlatFormUtil {
  static final String GET_APP_CONFIG = "getAppConfig";
  static final String GET_USER_OBJECT_ID = "getUserObjectId";
  static final String OPEN_CHAT = "openChat";
  static final String VIEW_USER_INFO = "viewUserInfo";

  //msg key
  static final String KEY_RELREASE_USER_ID = "releaseUserId";

  //唤起原生方法
  static Future callNativeApp(String method) {
    return platform.invokeMethod(method);
  }

  //向原生传递参数
  static Future callNativeAppWithParams(
      String method, Map<String, Object> map) {
    return platform.invokeMethod(method, map);
  }
}
