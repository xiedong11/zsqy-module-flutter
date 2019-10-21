import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MinePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PageState();
}

class PageState extends State<MinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
//                title: Text("个人中心"),
                expandedHeight: 300,
                pinned: true,
                floating: true,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
//                  title: Text("个人中心"),
                  background: Container(
                    height: 300,
                    decoration: new BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Color(0xff59dbe0), Color(0xff009688)])),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ClipOval(
                            child: SizedBox(
                              height: 75,
                              width: 75,
                              child: Image.network(
                                "https://avatar.csdn.net/6/0/6/3_xieluoxixi.jpg",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
                          Text(
                            '姓名',
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                          SizedBox(height: 2),
                          Text(
                            '专业专业院系',
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ];
          },
          body: Container(
            color: Color(0xffF5F5F5),
            child: ListView(
              children: <Widget>[
                SizedBox(height: 15),
                SettingItemWidget(leftText: "重置课表"),
                SettingItemWidget(leftText: "课表时间位置"),
                SettingItemWidget(leftText: "清空TA的课表"),
                SettingItemWidget(leftText: "清空自定义课程"),
                SizedBox(height: 25),
                SettingItemWidget(leftText: "应用缓存", rightText: "4.25M"),
                SettingItemWidget(leftText: "启动次数统计", rightText: "26次"),
                SizedBox(height: 25),
                SettingItemWidget(leftText: "建议反馈"),
                SettingItemWidget(leftText: "关于软件"),
                SettingItemWidget(leftText: "检查更新", rightText: "版本 3.5.3"),
                SizedBox(height: 50),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: FlatButton(
                    onPressed: () {},
                    color: Color(0xffff0000),
                    child: Container(
                      height: 50,
                      child: Center(
                        child: Text(
                          "注销登录",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 50),
              ],
            ),
          )),
    );
  }
}

class SettingItemWidget extends StatelessWidget {
  String leftText;
  String rightText;

  SettingItemWidget({this.leftText, this.rightText});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Text(
                    leftText,
                    style: TextStyle(fontSize: 15, color: Color(0xff777777)),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(right: 15),
                    child: rightText != null
                        ? Text(
                            rightText,
                            style: TextStyle(
                                fontSize: 13, color: Color(0xff777777)),
                          )
                        : SizedBox(
                            width: 22,
                            child: Image.asset(
                              "lib/img/ic_setting_more.png",
                              fit: BoxFit.cover,
                            ),
                          ))
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(height: 1, color: Color(0xffeeeeee)),
          )
        ],
      ),
    );
  }
}
