import 'package:flutter/material.dart';

class MakeOrder extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PageState();
}

class PageState extends State<MakeOrder> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      children: <Widget>[
        Card(
          elevation: 5.0,
          margin: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: new InputDecoration(
                      contentPadding: const EdgeInsets.all(10.0),
                      icon: new Icon(Icons.directions_bike,
                          color: Colors.redAccent),
                      labelText: "请输入要帮跑的任务",
                      helperText: "输入你要让帮手帮你完成的任务"),
                  onChanged: (String str) {},
                ),
              ),
              Wrap(
                spacing: 10.0,
                runSpacing: 10.0,
                direction: Axis.horizontal,
                alignment: WrapAlignment.start,
                children: <Widget>[
                  Container(
                    width: 80.0,
                    height: 60.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: Colors.black12),
                    child: GestureDetector(
                      child: Text("取快递"),
                    ),
                  ),
                  Container(
                    width: 80.0,
                    height: 60.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: Colors.black12),
                    child: GestureDetector(
                      child: Text("取快递"),
                    ),
                  ),
                  Container(
                    width: 80.0,
                    height: 60.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: Colors.black12),
                    child: GestureDetector(
                      child: Text("取快递"),
                    ),
                  ),
                  Container(
                    width: 80.0,
                    height: 60.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: Colors.black12),
                    child: GestureDetector(
                      child: Text("取快递"),
                    ),
                  ),
                  Container(
                    width: 80.0,
                    height: 60.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: Colors.black12),
                    child: GestureDetector(
                      child: Text("取快递"),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0)
            ],
          ),
        ),
        SizedBox(height: 20),
        RaisedButton(
          color: Colors.orangeAccent,
          onPressed: () {},
          child: Text(
            "去下单",
            style: TextStyle(color: Colors.white),
          ),
        )
      ],
    );
  }
}
