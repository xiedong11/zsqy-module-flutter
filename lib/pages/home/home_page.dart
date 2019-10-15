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
  static const int PAGE_HOME = 0;
  static const int PAGE_SYLLABUS = 1;
  static const int PAGE_SOCIAL = 2;
  static const int PAGE_EDUCATION = 3;
  static const int PAGE_MINE = 4;
  Widget _widget = SingleDayPage();

  void _onBottomTabChange(int index) {
    setState(() {
      _currentBottomIndex = index;
      switch (index) {
        case PAGE_HOME:
          _widget = SingleDayPage();
          break;
        case PAGE_SYLLABUS:
          _widget = SyllabusPage();
          break;
        case PAGE_SOCIAL:
          _widget = SocialPage();
          break;
        case PAGE_EDUCATION:
          _widget = EducationPage();
          break;
        case PAGE_MINE:
          _widget = MinePage();
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widget,
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
