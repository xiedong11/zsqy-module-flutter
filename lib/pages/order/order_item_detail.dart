import 'package:flutter/material.dart';
import 'package:flutter_app/entity/order_entity.dart';
import 'package:flutter_app/utils/plat_form_util.dart';
import 'package:flutter_app/widgets/color_label.dart';

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
        body: Container(
          child: Stack(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 20, top: 10),
                    child: Row(
                      children: <Widget>[
                        ClipOval(
                            child: Image.network(
                          _orderEntity.user.headImgUrl,
                          width: 50,
                          height: 50,
                        )),
                        SizedBox(width: 10),
                        Text(_orderEntity.user.nickName == null
                            ? _orderEntity.user.realName
                            : _orderEntity.user.nickName)
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 70),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(_orderEntity.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style:
                                TextStyle(color: Colors.black, fontSize: 16)),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                child: Text(_orderEntity.createdAt),
                right: 10,
                top: 10,
              ),
              Positioned(
                child: Row(
                  children: <Widget>[
                    Text(
                      '￥ 15',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    SizedBox(width: 10),
                    ColorLabel('# ${_orderEntity.type}', Color(0xFFFFC600)),
                    SizedBox(width: 10),
                  ],
                ),
                right: 10,
                bottom: 0,
              )
            ],
          ),
          width: double.infinity,
          height: 140,
          padding: EdgeInsets.only(bottom: 5, top: 5),
          decoration: BoxDecoration(color: Colors.white),
        ),
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
