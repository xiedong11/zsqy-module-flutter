import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/utils/dio_utils.dart';

class EmptyClassRoom extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PageState();
}

class PageState extends State<EmptyClassRoom> {

  @override
  void initState() {
    super.initState();
    var params = {"method": "authUser", "xh": "2017411881", "pwd": "a12345678"};
    DioUtils.getInstance().get(data: params);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("无课自习室"),
        centerTitle: true,
        leading: GestureDetector(
          child: Icon(Icons.arrow_back),
          onTap: () {
            SystemChannels.platform.invokeMethod('SystemNavigator.pop');
          },
        ),
      ),
      body: Center(
        child: Text("fdasfdasfdas"),
      ),
    );
  }
}
