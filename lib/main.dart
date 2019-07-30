import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: MainPage(),
    theme: ThemeData(primaryColor: Colors.white),
    debugShowCheckedModeBanner: false,
  ));
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("帮"),
        centerTitle: true,
      ),
      body: Center(
        child: Text("项目主页"),
      ),
    );
  }
}
