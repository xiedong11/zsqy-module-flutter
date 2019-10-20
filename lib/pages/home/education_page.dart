import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/pages/education/empty_class_room/empty_class_room_list.dart';
import 'package:flutter_app/pages/social/lost_and_found/lost_and_found_page.dart';
import 'package:flutter_app/widgets/module_item/module_item_entity.dart';
import 'package:flutter_app/widgets/module_item/module_item_widget.dart';

class EducationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PageState();
}

class PageState extends State<EducationPage> {
  //教务功能模块
  List<ModuleItemEntity> _educationModuleList = [
    ModuleItemEntity("成绩查询", "lib/img/ic_chengji.png", EmptyClassRoomList()),
    ModuleItemEntity("教室课表", "lib/img/ic_kebiao.png", EmptyClassRoomList()),
    ModuleItemEntity("选课管理", "lib/img/ic_xuanke.png", EmptyClassRoomList()),
    ModuleItemEntity("考试安排", "lib/img/ic_kaoshi.png", EmptyClassRoomList()),
    ModuleItemEntity(
        "学籍管理", "lib/img/ic_xueji_guanli.png", EmptyClassRoomList()),
    ModuleItemEntity("校园卡", "lib/img/ic_school_card.png", EmptyClassRoomList()),
    ModuleItemEntity("评教系统", "lib/img/ic_pingjiao.png", EmptyClassRoomList()),
  ];

  //图书管理模块
  List<ModuleItemEntity> _bookLibraryList = [
    ModuleItemEntity("借阅查询", "lib/img/ic_jieshu.png", EmptyClassRoomList()),
    ModuleItemEntity(
        "我的书架", "lib/img/ic_my_book_desk.png", EmptyClassRoomList()),
  ];

  //生活服务
  List<ModuleItemEntity> _otherModuleList=[
    ModuleItemEntity("失物招领","lib/img/ic_lost_and_found.png",LostAndFoundPage())
  ];

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
        child: ListView(
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
                ),
              ],
            ),
            SizedBox(height: 20),
            Container(
              height: 200,
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                itemCount: _educationModuleList.length,
                itemBuilder: (BuildContext context, int index) {
                  return ModuleItemWidget(_educationModuleList[index]);
                },
              ),
            ),
            Container(
              height: 1,
              color: Color(0xffeeeeee),
            ),
            SizedBox(height: 20),
            Row(
              children: <Widget>[
                Container(
                  color: Colors.deepOrange,
                  height: 20,
                  width: 5,
                ),
                SizedBox(width: 5),
                Text(
                  "图书管理",
                  style: TextStyle(fontSize: 17, color: Colors.black),
                ),
              ],
            ),
            SizedBox(height: 20),
            Container(
              height: 100,
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                itemCount: _bookLibraryList.length,
                itemBuilder: (BuildContext context, int index) {
                  return ModuleItemWidget(_bookLibraryList[index]);
                },
              ),
            ),
            Container(
              height: 1,
              color: Color(0xffeeeeee),
            ),
            SizedBox(height: 20),
            Row(
              children: <Widget>[
                Container(
                  color: Colors.deepOrange,
                  height: 20,
                  width: 5,
                ),
                SizedBox(width: 5),
                Text(
                  "生活服务",
                  style: TextStyle(fontSize: 17, color: Colors.black),
                ),
              ],
            ),
            SizedBox(height: 20),
            Container(
              height: 100,
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                itemCount: _otherModuleList.length,
                itemBuilder: (BuildContext context, int index) {
                  return ModuleItemWidget(_otherModuleList[index]);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
