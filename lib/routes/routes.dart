import 'package:flutter/material.dart';

//导入页面/////////////////////////////////////////////////////////////////
import '../pages/home.dart';
import '../pages/new_demand.dart';
import '../pages/publish/new_trend.dart';

//配置路由
final routes = {
  '/': (context) => HomePage(),
  '/new_trend': (context) => NewTrendPage(),
  '/new_demand': (context,{arguments}) => NewDemandPage(arguments:arguments),

  //'/page1': (context) => FormPage(),//无参数
  //'/page2':(context,{arguments})=>ProductInfoPage(arguments:arguments),//带参数
};
//固定写法/////////////////////////////////////////////////////////////////
var onGenerateRoute = (RouteSettings settings) {
  // 统一处理
  final String name = settings.name;
  final Function pageContentBuilder = routes[name];
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      final Route route =
          MaterialPageRoute(builder: (context) => pageContentBuilder(context));
      return route;
    }
  }
};
