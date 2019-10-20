import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/entity/empty_class_room_entity.dart';
import 'package:flutter_app/entity/qfnu_user_entity.dart';
import 'package:flutter_app/pages/education/empty_class_room/empty_class_room_detail.dart';
import 'package:flutter_app/utils/dio_utils.dart';

/**
 * 所有无课自习室列表
 */
class EmptyClassRoomList extends StatefulWidget {
  bool isFromNative;

  EmptyClassRoomList({this.isFromNative});

  @override
  State<StatefulWidget> createState() => PageState();
}

class PageState extends State<EmptyClassRoomList> {
  EmptyClassRoomEntity _mptyClassRoomEntity;
  RequestOptions _requestOptions;

  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() async {
    var params = {"method": "authUser", "xh": "2017411881", "pwd": "a12345678"};
    var result = await DioUtils.getInstance().get(data: params);
    QfnuUserEntity qfnuUserEntity = QfnuUserEntity.fromJson(result);

    _requestOptions = RequestOptions(headers: {"token": qfnuUserEntity.token});
    getListData("allday");
  }

  /**
   * allday,am,pm,night四种取值
   */
  getListData(String time) async {
    this.setState(() {
      _mptyClassRoomEntity = null;
    });
    var emptyClassRoomParams = {"method": "getKxJscx", "idleTime": time};
    var emptyClassRoomResult = await DioUtils.getInstance()
        .get(data: emptyClassRoomParams, options: _requestOptions);
    this.setState(() {
      _mptyClassRoomEntity =
          EmptyClassRoomEntity.fromJson(emptyClassRoomResult);
    });
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
            if (widget.isFromNative) {
              SystemChannels.platform.invokeMethod('SystemNavigator.pop');
            } else {
              Navigator.of(context).pop();
            }
          },
        ),
      ),
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                  child: InkWell(
                      onTap: () {
                        getListData("allday");
                      },
                      child: Tab(
                        text: "全天",
                      ))),
              Expanded(
                  child: InkWell(
                      onTap: () {
                        getListData("am");
                      },
                      child: Tab(text: "上午"))),
              Expanded(
                  child: InkWell(
                      onTap: () {
                        getListData("pm");
                      },
                      child: Tab(text: "下午"))),
              Expanded(
                  child: InkWell(
                      onTap: () {
                        getListData("night");
                      },
                      child: Tab(text: "晚上"))),
            ],
          ),
          Flexible(
              child: Center(
            child: _mptyClassRoomEntity == null
                ? Text("加载中...")
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: _mptyClassRoomEntity.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ItemEmptyClassRoomWidget(
                          _mptyClassRoomEntity.data[index]);
                    },
                  ),
          ))
        ],
      ),
    );
  }
}

class ItemEmptyClassRoomWidget extends StatelessWidget {
  EmptyClassRoomData _emptyClassRoomData;

  ItemEmptyClassRoomWidget(this._emptyClassRoomData);

  @override
  Widget build(BuildContext context) {
    List classRoomInfo = _emptyClassRoomData.jxl.split('-');
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => EmptyClassRoomDetail(_emptyClassRoomData)));
        },
        child: Container(
          height: 100,
          child: Stack(
            children: <Widget>[
              Positioned(
                  top: 20,
                  child: Row(
                    children: <Widget>[
                      SizedBox(width: 20),
                      Icon(
                        Icons.business,
                        size: 30,
                        color:
                            classRoomInfo[0] == "日照" ? Colors.red : Colors.cyan,
                      ),
                      SizedBox(width: 10),
                      Text(
                        classRoomInfo[1],
                        style: TextStyle(fontSize: 18),
                      )
                    ],
                  )),
              Positioned(
                  bottom: 10,
                  child: Row(
                    children: <Widget>[
                      SizedBox(width: 20),
                      Icon(Icons.location_on, color: Colors.grey, size: 15),
                      SizedBox(width: 5),
                      Text(
                        classRoomInfo[0],
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      )
                    ],
                  )),
              Positioned(
                bottom: 10,
                right: 20,
                child: RichText(
                    text: TextSpan(
                        text: "无课教室 ",
                        style: TextStyle(color: Colors.grey, fontSize: 13),
                        children: [
                      TextSpan(
                        text: _emptyClassRoomData.jsList.length.toString(),
                        style: TextStyle(color: Colors.red, fontSize: 14),
                      ),
                      TextSpan(
                          text: " 个",
                          style: TextStyle(color: Colors.grey, fontSize: 13))
                    ])),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
