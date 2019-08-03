import 'package:data_plugin/bmob/bmob_query.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/pages/helper/new_helper.dart';
import 'package:flutter_app/pages/home.dart';
import 'package:flutter_app/pages/order/new_order.dart';
import 'package:flutter_app/pages/order/order_list.dart';
import 'package:flutter_app/utils/user_cache.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:data_plugin/bmob/bmob.dart';
import 'entity/user_entity.dart';

void main() async {
  runApp(MaterialApp(
    home: MainPage(),
    theme: ThemeData(primaryColor: Colors.white),
    debugShowCheckedModeBanner: false,
  ));
  FlutterStatusbarcolor.setStatusBarColor(Colors.white);
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserCache.initAppConfigId();
    return Home();
  }
}
