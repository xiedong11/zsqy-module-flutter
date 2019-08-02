import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:data_plugin/bmob/bmob.dart';
import 'routes/routes.dart';

void main() async {
  runApp(MaterialApp(
    initialRoute: '/',//初始化的时候加载的路由
    onGenerateRoute: onGenerateRoute,
    theme: ThemeData(primaryColor: Colors.white),
    debugShowCheckedModeBanner: false,
  ));
  FlutterStatusbarcolor.setStatusBarColor(Colors.white);
  Bmob.initMasterKey("94e8ff45d51ab0b2656846473fe7c5fb",
      "5970018c7fd8bef874258398a1f44e03", null);
}
