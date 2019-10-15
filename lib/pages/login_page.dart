import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PageState();
  }
}

class PageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.only(left: 25, right: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(height: 120),
              Text(
                "账号密码登陆",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 30),
              TextField(
                decoration: InputDecoration(
                    hintText: "请输入信息门户账号",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.deepOrangeAccent, width: 2))),
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                    hintText: "请输入信息门户密码",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.deepOrangeAccent, width: 2))),
              ),
              SizedBox(height: 50),
              RaisedButton(
                color: Colors.teal,
                onPressed: () {},
                child: Container(
                  height: 45,
                  child: Center(
                    child: Text(
                      "戳我登陆",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
