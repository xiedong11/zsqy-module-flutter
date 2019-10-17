import 'package:flutter/material.dart';

class LostAndFoundPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() =>PageState();
}

class PageState extends State<LostAndFoundPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('失物招领'),),);
  }

}