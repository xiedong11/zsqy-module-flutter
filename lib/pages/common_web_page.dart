import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class CommonWebPage extends StatefulWidget {
  String url;
  String title;

  CommonWebPage({this.url, this.title});

  @override
  State<StatefulWidget> createState() => PageState();
}

class PageState extends State<CommonWebPage> {
  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      appBar: AppBar(
        title: Text(widget.title.length > 0 ? widget.title : "掌上教务"),
        centerTitle: true,
      ),
      url: widget.url,
      withZoom: true,
      // 允许网页缩放
      withLocalStorage: true,
      // 允许LocalStorage
      withJavascript: true, // 允许执行js代码
    );
  }
}
