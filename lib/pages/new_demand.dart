import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'publish/new_helper.dart';
import 'publish/new_order.dart';

class NewDemandPage extends StatefulWidget {
  final Map arguments;
  NewDemandPage({Key key, this.arguments}) : super(key: key);

  _NewDemandPageState createState() =>
      _NewDemandPageState(arguments: this.arguments);
}

class _NewDemandPageState extends State<NewDemandPage> {
  Map arguments;
  _NewDemandPageState({this.arguments});

  static int MARK_ORDER = 1,FIND_HELPER = 2;

  var titleStyleSelected =
      TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold);

  var titleStyleNormal = TextStyle(
      color: Colors.black54, fontSize: 15, fontWeight: FontWeight.bold);

  var currentIndex = FIND_HELPER;

  @override
  Widget build(BuildContext context) {
    //FIXME-->现在点击切换不了页面了，不晓得为啥子>_</////////////////////////////////////////////////////////////////////
    currentIndex = arguments['index'];
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                child: Text('下任务',
                    style: currentIndex == MARK_ORDER
                        ? titleStyleSelected
                        : titleStyleNormal),
                onTap: () {
                  this.setState(() {
                    currentIndex = MARK_ORDER;
                  });
                },
              ),
              SizedBox(width: 7),
              GestureDetector(
                child: Text('找帮手',
                    style: currentIndex == FIND_HELPER
                        ? titleStyleSelected
                        : titleStyleNormal),
                onTap: () {
                  this.setState(() {
                    currentIndex = FIND_HELPER;
                  });
                },
              ),
            ],
          ),
          actions: <Widget>[
            Icon(
              Icons.arrow_back,
              color: Colors.white,
            )
          ],
          centerTitle: true,
          leading: GestureDetector(
            child: Icon(Icons.arrow_back),
            onTap: () {
              SystemChannels.platform.invokeMethod('SystemNavigator.pop');
            },
          ),
        ),
        body: currentIndex == FIND_HELPER ? NewHelper() : NewOrder());
  }
}
