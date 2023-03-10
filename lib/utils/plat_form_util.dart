import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const platform = const MethodChannel("zhuandian.flutter");

class PlatFormUtil {
  static final String GET_APP_CONFIG = "getAppConfig";
  static final String GET_USER_OBJECT_ID = "getUserObjectId";
  static final String OPEN_CHAT = "openChat";
  static final String VIEW_USER_INFO = "viewUserInfo";
  static final String IS_VISITOR = "isVisitor";
  static final String FLUTTER_PAGE_ROUTE = "flutterPageRoute";

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
