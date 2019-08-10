import 'package:flutter/material.dart';
import 'package:flutter_app/entity/order_entity.dart';
import 'package:flutter_app/utils/plat_form_util.dart';

class OrderItemDetail extends StatefulWidget {
  OrderEntity orderEntity;

  OrderItemDetail({this.orderEntity});

  @override
  State<StatefulWidget> createState() => PageState(this.orderEntity);
}

class PageState extends State<OrderItemDetail> {
  OrderEntity _orderEntity;

  PageState(this._orderEntity);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('任务详情'),
          centerTitle: true,
        ),
        body: ListView(children: <Widget>[
          //头部信息
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(bottom: 10, top: 5),
            decoration: BoxDecoration(color: Colors.white),
            child: Stack(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    //头像
                    Padding(
                      padding: EdgeInsets.only(left: 20, top: 10),
                      child: Row(
                        children: <Widget>[
                          ClipOval(
                            child: SizedBox(
                                width: 40.0,
                                height: 40.0,
                                child: new Image.network(
                                  _orderEntity.user.headImgUrl,
                                  fit: BoxFit.cover,
                                )),
                          ),
                          SizedBox(width: 10),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                  (_orderEntity.user.nickName != null &&
                                          _orderEntity.user.nickName.length > 0)
                                      ? _orderEntity.user.nickName
                                      : _orderEntity.user.realName,
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  )),
                              Text(_orderEntity.user.major,
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 12)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    //个人信息
                    Padding(
                      padding: EdgeInsets.only(
                          left: 25, right: 10, top: 15, bottom: 35),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(_orderEntity.title,
                              maxLines: 5,
                              overflow: TextOverflow.ellipsis,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14)),
                        ],
                      ),
                    ),
                  ],
                ),
                //时间
                Positioned(
                  child: Text(_orderEntity.createdAt,
                      style: TextStyle(fontSize: 13)),
                  right: 10,
                  top: 10,
                ),
                //价格标签
                Positioned(
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.tag_faces,
                        color: Colors.black45,
                        size: 14,
                      ),
                      SizedBox(width: 2),
                      Text(_orderEntity.type,
                          style: TextStyle(
                            fontSize: 12,
                          )),
                    ],
                  ),
                  bottom: 0,
                  left: 20,
                ),
                Positioned(
                  child: Row(
                    children: <Widget>[
                      Text(
                        '￥ ${_orderEntity.price == null ? '0' : _orderEntity.price}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                      SizedBox(width: 10),
                    ],
                  ),
                  right: 10,
                  bottom: 0,
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          //body具体信息
          Container(
              width: double.infinity,
              // height: 140,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(color: Colors.white),
              child: Column(
                children: <Widget>[
                  //联系地址
                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(width: 2.0),
                        Text("▌",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.orangeAccent)),
                        SizedBox(width: 10.0),
                        Text("联系地址",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 13)),
                      ]),
                  SizedBox(
                    height: 20,
                  ),
                  //出发地址
                  Padding(
                    padding: EdgeInsets.all(2.0),
                    child: Row(children: <Widget>[
                      Icon(
                        Icons.fiber_manual_record,
                        color: Colors.lightBlue,
                        size: 14.0,
                      ),
                      SizedBox(width: 10),
                      Container(
                        width: 260.0,
                        child: Text(
                            _orderEntity.from == ''
                                ? '无'
                                : '起：' + _orderEntity.from,
                            style: TextStyle(fontSize: 14)),
                      )
                    ]),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  //到达地址
                  Padding(
                    padding: EdgeInsets.all(2.0),
                    child: Row(children: <Widget>[
                      Icon(
                        Icons.fiber_manual_record,
                        color: Colors.redAccent,
                        size: 14.0,
                      ),
                      SizedBox(width: 10),
                      Container(
                        width: 260.0,
                        child: Text(
                            _orderEntity.destination == ''
                                ? '无'
                                : '止：' + _orderEntity.destination,
                            style: TextStyle(fontSize: 14)),
                      )
                    ]),
                  ),
                  SizedBox(height: 20.0),
                  //联系方式
                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(width: 2.0),
                        Text("▌",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.orangeAccent)),
                        SizedBox(width: 10.0),
                        Text("联系方式",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 13)),
                      ]),
                  SizedBox(
                    height: 20,
                  ),
                  //联系方式
                  Padding(
                    padding: EdgeInsets.all(2.0),
                    child: Row(children: <Widget>[
                      Icon(
                        Icons.call,
                        color: Colors.blue,
                        size: 16.0,
                      ),
                      SizedBox(width: 10),
                      Container(
                        width: 260.0,
                        child: Text(
                            _orderEntity.phoneNumber == ''
                                ? '无'
                                : _orderEntity.phoneNumber,
                            style: TextStyle(fontSize: 14)),
                      )
                    ]),
                  ),
                  SizedBox(height: 10.0),
                  //备注
                  Padding(
                    padding: EdgeInsets.only(top: 10.0, left: 2.0),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Icon(
                            Icons.details,
                            color: Colors.green,
                            size: 16.0,
                          ),
                          SizedBox(width: 10),
                          Container(
                            child: Expanded(
                                child: Text(
                                    _orderEntity.detail == ''
                                        ? '无'
                                        : _orderEntity.detail,
                                    style: TextStyle(fontSize: 14))),
                          )
                        ]),
                  ),
                ],
              ))
        ]),
        bottomNavigationBar: _BottomToolBar(_orderEntity));
  }
}

class _BottomToolBar extends StatelessWidget {
  OrderEntity _orderEntity;

  _BottomToolBar(this._orderEntity);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      height: 50,
      child: Row(children: <Widget>[
        Expanded(
          flex: 2,
          child: GestureDetector(
            onTap: () {
              PlatFormUtil.callNativeAppWithParams(
                  PlatFormUtil.VIEW_USER_INFO, {
                PlatFormUtil.KEY_RELREASE_USER_ID: _orderEntity.user.objectId
              });
            },
            child: Center(
              child: Text(
                '看TA资料',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              PlatFormUtil.callNativeAppWithParams(PlatFormUtil.OPEN_CHAT, {
                PlatFormUtil.KEY_RELREASE_USER_ID: _orderEntity.user.objectId
              });
            },
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.orangeAccent,
              ),
              child: Center(
                child: Text(
                  '私聊',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
