import 'package:flutter/material.dart';

class SocialListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PageState();
}

class PageState extends State<SocialListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("校友动态"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Stack(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        ClipOval(
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: Image.network(
                              "https://avatar.csdn.net/6/0/6/3_xieluoxixi.jpg",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "姓名",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                            ),
                            Text(
                              "08/20 15:33 数学科学学院",
                              style: TextStyle(
                                  fontSize: 12, color: Colors.black54),
                            )
                          ],
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10, top: 10, right: 10),
                      child: Text(
                        "fsdfsda范德萨范水电费大丰收的法师打发点是范德萨范德萨法师第三方收到打发斯蒂芬都是法师打发点是第三方收到发法师打发斯蒂芬法师打发点是发送到德萨发的发大水发大水发大发斯蒂芬打算大是发斯蒂芬手动阀所发生的发大水发的三的范德萨的飞洒发多少地方撒地方萨芬的三的范德萨撒的发生的定时发送定时发送",
                        style: TextStyle(fontSize: 14, color: Colors.black87),
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      height: 120,
                      child: Padding(
                        padding: EdgeInsets.only(left: 10, top: 5, right: 10),
                        child: ListView(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: SizedBox(
                                  height: 110,
                                  width: 140,
                                  child: Image.network(
                                    "https://www.qq745.com/uploads/allimg/170416/17-1F4161H131Y9-lp.png",
                                    fit: BoxFit.cover,
                                  ),
                                )),
                            Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: SizedBox(
                                  height: 110,
                                  width: 140,
                                  child: Image.network(
                                    "https://www.qq745.com/uploads/allimg/170416/17-1F4161H131Y9-lp.png",
                                    fit: BoxFit.cover,
                                  ),
                                )),
                            Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: SizedBox(
                                  height: 110,
                                  width: 140,
                                  child: Image.network(
                                    "https://www.qq745.com/uploads/allimg/170416/17-1F4161H131Y9-lp.png",
                                    fit: BoxFit.cover,
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20, top: 10),
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: 25,
                            height: 25,
                            child: Image.asset(
                              "lib/img/share_likes.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text("9"),
                          SizedBox(
                            width: 20,
                          ),
                          SizedBox(
                            width: 25,
                            height: 25,
                            child: Image.asset("lib/img/share_reply.png",
                                fit: BoxFit.cover),
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Text("0"),
                        ],
                      ),
                    )
                  ],
                ),
                Positioned(
                  top: 5,
                  right: 5,
                  child: Container(
                    height: 20,
                    width: 80,
                    child: Center(child: Text("#我要吐槽#",style: TextStyle(fontSize: 12,color: Colors.black87),)),
                  decoration: BoxDecoration(color: Color(0xffeeeeee),borderRadius:  BorderRadius.circular(20),),),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
