import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LostAndFoundPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PageState();
}

class PageState extends State<LostAndFoundPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("失物招领"),
        centerTitle: true,
        elevation: 0,
        actions: <Widget>[
          InkWell(
            onTap: () {},
            child: Padding(
              child: Icon(Icons.add),
              padding: EdgeInsets.only(right: 10),
            ),
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          Image.asset("lib/img/ic_lost_and_found_barrage_bg.png",
              fit: BoxFit.cover),
          ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 8,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  child: Stack(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          ClipOval(
                            child: Container(
                              height: 55,
                              width: 55,
                              color: Colors.grey,
                              child: Center(
                                child: Text(
                                  "丢",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 25),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "丢失学生卡",
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.black87),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  "某某的什么的东西丢了法萨芬洒范德萨范德萨发大是大非丢失第三方撒地方都是落的开发商的积分卡技术大开发了发送到发生大法师发电房",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black54),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 25, left: 10),
                            child: SizedBox(
                              child: Image.network(
                                'https://avatar.csdn.net/6/0/6/3_xieluoxixi.jpg',
                                fit: BoxFit.cover,
                              ),
                              width: 40,
                              height: 40,
                            ),
                          )
                        ],
                      ),
                      Positioned(
                        child: Text(
                          '2019/09/09 09:55',
                          style: TextStyle(fontSize: 13, color: Colors.black54),
                        ),
                        right: 10,
                      )
                    ],
                  ),
                );
              })
        ],
      ),
    );
  }
}
