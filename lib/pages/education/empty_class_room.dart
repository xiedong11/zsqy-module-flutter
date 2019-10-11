import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/entity/empty_class_room_entity.dart';
import 'package:flutter_app/entity/qfnu_user_entity.dart';
import 'package:flutter_app/utils/dio_utils.dart';

class EmptyClassRoom extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PageState();
}

class PageState extends State<EmptyClassRoom> {
  EmptyClassRoomEntity _mptyClassRoomEntity;

  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() async {
    var params = {"method": "authUser", "xh": "2017411881", "pwd": "a12345678"};
    var result = await DioUtils.getInstance().get(data: params);
    QfnuUserEntity qfnuUserEntity = QfnuUserEntity.fromJson(result);

    var emptyClassRoomParams = {"method": "getKxJscx"};
    RequestOptions requestOptions =
        RequestOptions(headers: {"token": qfnuUserEntity.token});
    var emptyClassRoomResult = await DioUtils.getInstance()
        .get(data: emptyClassRoomParams, options: requestOptions);
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
            SystemChannels.platform.invokeMethod('SystemNavigator.pop');
          },
        ),
      ),
      body: Center(
        child: _mptyClassRoomEntity == null
            ? Text("加载中...")
            : ListView.builder(
                itemCount: _mptyClassRoomEntity.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(_mptyClassRoomEntity.data[index].jxl),
                  );
                },
              ),
      ),
    );
  }
}
