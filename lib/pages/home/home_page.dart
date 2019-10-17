import 'package:flutter/material.dart';
import 'package:flutter_app/pages/home/education_page.dart';
import 'package:flutter_app/pages/home/mine_page.dart';
import 'package:flutter_app/pages/home/single_day_page.dart';
import 'package:flutter_app/pages/home/social_page.dart';
import 'package:flutter_app/pages/home/syllabus_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PageState();
}

class PageState extends State<HomePage> {
  int _currentBottomIndex = 0; //底部tab索引

  var _body;
  var pages;

  @override
  void initState() {
    super.initState();
    pages = <Widget>[SingleDayPage(),SyllabusPage(),SocialPage(),EducationPage(),MinePage()];
  }
  void _onBottomTabChange(int index) {
    setState(() {
      _currentBottomIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    _body = IndexedStack(
      children: pages,
      index: _currentBottomIndex,
    );
    return Scaffold(
      body: _body,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentBottomIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          _onBottomTabChange(index);
        },
        fixedColor: Colors.teal,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('首页')),
          BottomNavigationBarItem(
              icon: Icon(Icons.date_range), title: Text('课表')),
          BottomNavigationBarItem(
              icon: Icon(Icons.local_airport), title: Text('社区')),
          BottomNavigationBarItem(
              icon: Icon(Icons.markunread_mailbox), title: Text('教务')),
          BottomNavigationBarItem(icon: Icon(Icons.person), title: Text('我的')),
        ],
      ),
    );
  }
}
