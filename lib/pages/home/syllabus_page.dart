import 'package:flutter/material.dart';

class SyllabusPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PageState();
}

class PageState extends State<SyllabusPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('课表'),
      ),
    );
  }
}
