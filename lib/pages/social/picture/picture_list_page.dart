import 'package:flutter/material.dart';

class PictureListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PageState();
}

class PageState extends State<PictureListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("一闪●最美曲园"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(
          20.0,
        ),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                ClipOval(
                  child: SizedBox(
                    height: 40,
                    width: 40,
                    child: Image.network(
                      "https://avatar.csdn.net/6/0/6/3_xieluoxixi.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Text("# 济宁市",
                    style: TextStyle(fontSize: 15, color: Colors.grey)),
                SizedBox(width: 5),
                Text("2019/09/20 09:34",
                    style: TextStyle(fontSize: 14, color: Colors.grey)),
              ],
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 350,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  ClipRRect(
                    child: Image.network(
                      "https://avatar.csdn.net/6/0/6/3_xieluoxixi.jpg",
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  Align(
                    alignment: FractionalOffset(0.5, 0.96),
                    child: Text(
                      "可法撒旦法士大夫撒旦法师打发士大夫士大夫是的范德萨爱！",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.white),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: 35,
              width: 35,
              child: Image.asset(
                "lib/img/ic_share.png",
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
