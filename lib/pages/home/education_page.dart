import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class EducationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PageState();
}

class PageState extends State<EducationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("教务管理"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: <Widget>[
            SizedBox(height: 10),
            Row(
              children: <Widget>[
                Container(
                  color: Colors.deepOrange,
                  height: 20,
                  width: 5,
                ),
                SizedBox(width: 5),
                Text(
                  "教务功能",
                  style: TextStyle(fontSize: 17, color: Colors.black),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
