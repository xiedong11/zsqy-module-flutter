import 'package:flutter/material.dart';

import 'dart:async';//StreamSubscription状态变化监听
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';//flutter_webview_plugin

class CancelResult extends StatefulWidget {
  String startUrl;
  String title;
  var user, pass, SERVER,COOKIE;

  CancelResult(this.startUrl, this.title, this.user, this.pass, this.SERVER,this.COOKIE);

  @override
  State<StatefulWidget> createState() =>  CancelResultState(startUrl, title, this.SERVER,this.COOKIE);
}

class CancelResultState extends State<CancelResult> {
  String startUrl;
  String title;
  var COOKIE,SERVER;
  // 标记是否是加载中
  bool loading = true;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  // WebView加载状态变化监听器
  StreamSubscription<WebViewStateChanged> onStateChanged;
  // 插件提供的对象，该对象用于WebView的各种操作
  FlutterWebviewPlugin flutterWebViewPlugin = FlutterWebviewPlugin();

  CancelResultState( this.startUrl, this.title, this.SERVER,this.COOKIE);

  @override
  void initState() {
    super.initState();
    onStateChanged = flutterWebViewPlugin.onStateChanged.listen((WebViewStateChanged state) async {
      switch (state.type) {
        case WebViewState.shouldStart:// 准备加载
          setState(() async { loading = true; }); break;
        case WebViewState.finishLoad:// 加载完成
          setState(() { loading = false; }); break;
        default: break;
      }
    });
  }

  

  @override
  Widget build(BuildContext context) {
    Widget titleContent;
    if (loading) {//加载中
      titleContent=Text( '加载中...', style: TextStyle(color: Colors.white));
    } else {
      titleContent=Text( title, style: TextStyle(color: Colors.white));
    }
    return WebviewScaffold(
      key: scaffoldKey,
      url: SERVER + '/jsxsd/xsxkjg/comeXkjglb', // 登录的URL
      appBar: AppBar(
        centerTitle: true,
        title: titleContent,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      cookieList:cookieToList(COOKIE.toString()),
      withZoom: true, // 允许网页缩放
      withJavascript: true, // 允许执行js代码
      userAgent: "Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36",
    );
  }

  //cookies字符串转List
  List<Map<String, String>> cookieToList(String cookie) {
    var cookieArr = cookie.replaceAll(' ', '').split(";");
    List<Map<String, String>> cookieList = [];
    cookieArr.forEach((i) {
      var arr = i.split("=");
      cookieList.add({'k': arr[0], 'v': arr.length>1?arr[1]:''});
    });
    return cookieList;
  }
}
