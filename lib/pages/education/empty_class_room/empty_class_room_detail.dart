import 'package:flutter/material.dart';
import 'package:flutter_app/entity/empty_class_room_entity.dart';

class EmptyClassRoomDetail extends StatelessWidget {
  EmptyClassRoomData _emptyClassRoomData;

  EmptyClassRoomDetail(this._emptyClassRoomData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_emptyClassRoomData.jxl),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: _emptyClassRoomData.jsList.length,
          itemBuilder: (BuildContext context, int index) {
        return EmptyClassRoomDetailItem(_emptyClassRoomData.jsList[index]);
      }),
    );
  }
}

class EmptyClassRoomDetailItem extends StatelessWidget{

  EmptyClassRoomDataJslist _emptyClassRoomDataJslist;

  EmptyClassRoomDetailItem(this._emptyClassRoomDataJslist);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          Positioned(
              top: 20,
              left: 20,
              child:  Text(
                _emptyClassRoomDataJslist.jsmc,
                style: TextStyle(fontSize: 18),
              )),
          Positioned(
              bottom: 10,
              child: Row(
                children: <Widget>[
                  SizedBox(width: 20),
                  Icon(Icons.location_on, color: Colors.grey, size: 15),
                  SizedBox(width: 5),
                  Text(
                    _emptyClassRoomDataJslist.jzwmc,
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  )
                ],
              )),
          Positioned(
            bottom: 10,
            right: 20,
            child: RichText(
                text: TextSpan(

                    children: [

                      TextSpan(
                        text: _emptyClassRoomDataJslist.zws.toString(),
                        style: TextStyle(color: Colors.red, fontSize: 14),
                      ),
                      TextSpan(
                          text: "个可用座位",
                          style: TextStyle(color: Colors.grey, fontSize: 13)),

                    ])),
          ),
          Positioned(
            child: SizedBox(height: 0.2,child: Container(color: Colors.grey,),),
          )
        ],
      ),
    );
  }
}
