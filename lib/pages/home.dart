import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            Container(
              child: GestureDetector(
                child: Icon(Icons.add),
                onTap: _plusPopMenu(context),
                //TODO 让popmenu右侧贴边显示,目测可以通过widgets里面的popwindowbutton来写一个弹窗的布局，实现tim那种弹窗遮罩页面变暗的效果
              ),
              margin: EdgeInsets.only(right: 10.0),
            )
          ],
        ),
        body: new Center(child: new Text('000000')));
  }

  _plusPopMenu(context) {
    return () async {
      int selected = await showMenu<int>(
          context: context,
          position: RelativeRect.fromLTRB(200.0, 80.0, 0, 0),
          items: [
            _popMenuItem(0, '动态', icon: Icons.tag_faces),
            _popMenuItem(1, '发布任务', icon: Icons.flash_on),
            _popMenuItem(2, '我要跑腿', icon: Icons.directions_run)
          ]);
      switch (selected) {
        case 0:
          Navigator.pushNamed(context, '/new_trend');
          break;
        case 1:
          Navigator.pushNamed(context, '/new_demand', arguments: {"index": 1});
          break;
        case 2:
          Navigator.pushNamed(context, '/new_demand', arguments: {"index": 2});
          break;
        default:
      }
    };
  }

  _popMenuItem(int value, String title, {IconData icon = Icons.add}) {
    return PopupMenuItem<int>(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Icon(icon),
          Text(title),
        ],
      ),
      value: value,
    );
  }
}
