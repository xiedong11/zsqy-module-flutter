import 'dart:math';

import 'package:flutter/material.dart';

class SyllabusPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PageState();
}

class PageState extends State<SyllabusPage> {
  List<CourseEntity> courseList = [];
  var colorsArray = [
    Colors.lightGreen[200],
    Colors.black12,
    Colors.deepOrangeAccent[100],
    Colors.orange[50],
    Colors.lightBlue,
    Colors.deepOrange[100]
  ];

  @override
  void initState() {
    super.initState();
    this.setState(() {
      for (int i = 0; i < 35; i++) {
        courseList.add(CourseEntity(color: Colors.transparent, name: ""));
      }
      //       1------7
      //       8------14
      //       15-----21
      //       22-----28
      //       29-----35
      courseList[1] = CourseEntity(
          color: colorsArray[Random().nextInt(6) % 6], name: "数学理论知识讲解");
      courseList[7] = CourseEntity(
          color: colorsArray[Random().nextInt(6) % 6], name: "大学英语2");
      courseList[10] = CourseEntity(
          color: colorsArray[Random().nextInt(6) % 6], name: "Android开发课程");
      courseList[14] =
          CourseEntity(color: colorsArray[Random().nextInt(6) % 6], name: "篮球");
      courseList[24] = CourseEntity(
          color: colorsArray[Random().nextInt(6) % 6], name: "软件概论");
      courseList[4] = CourseEntity(
          color: colorsArray[Random().nextInt(6) % 6], name: "思想品德");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("我的课表"),
        centerTitle: true,
        elevation: 1,
      ),
      body: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                height: 30,
                child: Center(child: Text("周一")),
              ),
              Container(
                height: 20,
                child: Center(child: Text("周二")),
              ),
              Container(
                height: 20,
                child: Center(child: Text("周三")),
              ),
              Container(
                height: 20,
                child: Center(child: Text("周四")),
              ),
              Container(
                height: 20,
                child: Center(child: Text("周五")),
              ),
              Container(
                height: 20,
                child: Center(child: Text("周六")),
              ),
              Container(
                height: 20,
                child: Center(child: Text("周日")),
              )
            ],
          ),
          Expanded(
            child: Container(
              child: GridView.builder(
                  itemCount: 35,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 1,
                      crossAxisSpacing: 1,
                      childAspectRatio: 0.3,
                      crossAxisCount: 7),
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      color: courseList[index].color,
                      child: Center(
                        child: Text(
                          courseList[index].name,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  }),
            ),
          )
        ],
      ),
    );
  }
}

class CourseEntity {
  String name;
  Color color;

  CourseEntity({this.color, this.name});
}
