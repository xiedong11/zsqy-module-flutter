import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/pages/social/helper/helper/helper_list.dart';
import 'package:flutter_app/pages/social/helper/order/order_list.dart';

import 'package:flutter_app/utils/dio_utils.dart';

/**
 * 帮跑业务首页
 */
class HelperHome extends StatefulWidget {
  bool isForNative = false;

  HelperHome({this.isForNative});

  @override
  State<StatefulWidget> createState() {
    return PageState();
  }
}

class PageState extends State<HelperHome> {
  static int FIND_HELPER = 0, MARK_ORDER = 1;
  PageController _pageController = PageController();
  var titleStyleSelected =
      TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold);

  var titleStyleNormal = TextStyle(
      color: Colors.black54, fontSize: 15, fontWeight: FontWeight.bold);

  var currentIndex = FIND_HELPER;

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
                    _pageController.jumpToPage(currentIndex);
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
                    _pageController.jumpToPage(currentIndex);
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
              if(widget.isForNative){ //嵌入原生，返回需要直接关闭
                SystemChannels.platform.invokeMethod('SystemNavigator.pop');
              }else{ //在纯flutter中，点击反应仅当前页面出栈
                Navigator.of(context).pop();
              }

            },
          ),
        ),
        body: PageView(
          controller: _pageController,
          onPageChanged: _onPageChanged,
          children: <Widget>[HelperList(), OrderList()],
        ));
  }

  void _onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }
}
