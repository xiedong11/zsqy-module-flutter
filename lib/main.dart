import 'package:data_plugin/bmob/bmob_query.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/pages/find_helper.dart';
import 'package:flutter_app/pages/make_order.dart';
import 'package:flutter_app/utils/user_cache.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:flutter/services.dart';
import 'package:data_plugin/bmob/bmob.dart';
import 'package:data_plugin/bmob/table/bmob_user.dart';
import 'entity/user_entity.dart';

void main() async {
  runApp(MaterialApp(
    home: MainPage(),
    theme: ThemeData(primaryColor: Colors.white),
    debugShowCheckedModeBanner: false,
  ));
  FlutterStatusbarcolor.setStatusBarColor(Colors.white);
}

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PageState();
  }
}

class PageState extends State<MainPage> {
  static const platform = const MethodChannel("zhuandian.flutter");

  static int FIND_HELPER = 1, MARK_ORDER = 2;
  var titleStyleSelected =
      TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold);

  var titleStyleNormal = TextStyle(
      color: Colors.black54, fontSize: 15, fontWeight: FontWeight.bold);

  var currentIndex = MARK_ORDER;

  @override
  void initState() {
    super.initState();
    initAppConfigId();
  }

  Future<Null> initAppConfigId() async {
    try {
      List result = await platform.invokeMethod("getAppConfig");
      Bmob.initMasterKey(result[0], result[1], "");
      String userObjectId = await platform.invokeMethod("getUserObjectId");
      BmobQuery<User> query = BmobQuery();
      query.queryUser(userObjectId).then((data) {
        User userEntity = User.fromJson(data);
        UserCache.user = userEntity;
      }).catchError((e) {
        debugPrint(e.toString() + '---------------');
      });
    } on PlatformException catch (e) {
      print(e.toString() + "-------------------------");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                child: Text('找帮手',
                    style: currentIndex == FIND_HELPER
                        ? titleStyleSelected
                        : titleStyleNormal),
                onTap: () {
                  this.setState(() {
                    currentIndex = FIND_HELPER;
                  });
                },
              ),
              SizedBox(width: 7),
              GestureDetector(
                child: Text('下任务',
                    style: currentIndex == MARK_ORDER
                        ? titleStyleSelected
                        : titleStyleNormal),
                onTap: () {
                  this.setState(() {
                    currentIndex = MARK_ORDER;
                  });
                },
              ),
            ],
          ),
          actions: <Widget>[
            Icon(
              Icons.arrow_back,
              color: Colors.white,
            )
          ],
          centerTitle: true,
          leading: GestureDetector(
            child: Icon(Icons.arrow_back),
            onTap: () {
              SystemChannels.platform.invokeMethod('SystemNavigator.pop');
            },
          ),
        ),
        body: currentIndex == FIND_HELPER ? FindHelper() : MakeOrder());
  }
}
