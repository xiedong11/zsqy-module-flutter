import 'package:flutter/material.dart';

class SingleDayPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PageState();
}

class PageState extends State<SingleDayPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('首页'),
      ),
    );
  }
}
