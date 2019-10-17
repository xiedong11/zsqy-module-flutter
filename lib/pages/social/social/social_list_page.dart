import 'package:flutter/material.dart';

class SocialListPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() =>PageState();
}

class PageState extends State<SocialListPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('动态列表'),),);
  }
  
}