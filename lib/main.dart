import 'package:flutter/material.dart';
import 'package:flutter_app/pages/education/empty_class_room/empty_class_room_list.dart';
import 'package:flutter_app/pages/login_page.dart';
import 'package:flutter_app/pages/social/helper/helper_home.dart';
import 'package:flutter_app/utils/page_route_for_native.dart';
import 'package:flutter_app/utils/plat_form_util.dart';
import 'package:flutter_app/utils/user_cache.dart';
import 'package:flutter_app/widgets/empty_view.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

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
    return FutureBuilder(
        future: getPageIndex(),
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
            case ConnectionState.active:
              return EmptyView();
            case ConnectionState.done:
              switch (snapshot.data) {
                case PageRoute4Native.FLUTTER_ROUTE_MAIN:
                  return LoginPage();
                case PageRoute4Native.FLUTTER_ROUTE_HEPLIER:
                  return HelperHome();
                case PageRoute4Native.FLUTTER_ROUTE_EMPTY_CLASS_ROOM:
                  return EmptyClassRoomList();
              }
          }
        });
  }

  getPageIndex() {
    return platform.invokeMethod<int>(PlatFormUtil.FLUTTER_PAGE_ROUTE);
  }
}
