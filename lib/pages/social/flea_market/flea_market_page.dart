import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FleaMarketPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PageState();
}

class PageState extends State<FleaMarketPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      appBar: AppBar(
        title: Text("跳蚤集市"),
        centerTitle: true,
        elevation: 1,
        actions: <Widget>[
          InkWell(
            onTap: () {},
            child: SizedBox(
              height: 30,
              width: 60,
              child: Center(
                child: Text(
                  "发布",
                  style: TextStyle(fontSize: 17, color: Colors.black),
                ),
              ),
            ),
          )
        ],
      ),
      body: Center(
        child: Stack(
          children: <Widget>[
            Container(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ClipOval(
                      child: SizedBox(
                        width: 40,
                        height: 40,
                        child: Image.asset('lib/img/ic_default_header_img.png',
                            fit: BoxFit.cover),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 5),
                          Text("姓名.地点",
                              style: TextStyle(
                                  fontSize: 14, color: Color(0xff999999))),
                          SizedBox(height: 5),
                          Text("2019/12/12 09:55",
                              style: TextStyle(
                                  fontSize: 12, color: Color(0xff999999))),
                          SizedBox(height: 10),
                          Text(
                            '好就是大家发撒的尽快发货速度加咖啡和数据库的房价开始打防控建设大飞机可撒地方就开始打话费即可',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 16, color: Color(0xff333333)),
                          ),
                          SizedBox(height: 3),
                          SizedBox(
                            height: 120,
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: 3,
                                itemBuilder: (BuildContext context, int index) {
                                  return Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: <Widget>[
                                      SizedBox(
                                        width: 140,
                                        height: 100,
                                        child: Image.asset(
                                            'lib/img/ic_lost_and_found_barrage_bg.png',
                                            fit: BoxFit.cover),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      )
                                    ],
                                  );
                                }),
                          ),
                          SizedBox(height: 8),
                          Text("￥400",
                              style: TextStyle(fontSize: 18, color: Colors.red))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                height: 30,
                width: 65,
                decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        bottomRight: Radius.circular(15))),
                child: Center(
                    child: Text(
                  '可议价',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
