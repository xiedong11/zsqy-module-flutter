import 'package:flutter/material.dart';
import 'package:flutter_app/entity/order_entity.dart';
import 'package:flutter_app/widgets/mywidgets.dart';

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
          child: ListView(
            children: <Widget>[InfoCard(this._orderEntity)],
          ),
        ),
        bottomNavigationBar: _BottomToolBar());
  }
}

class InfoCard extends StatelessWidget {
  OrderEntity _orderEntity;
  String name;
  InfoCard(this._orderEntity);

  Widget renderUserInfo() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              CircleAvatar(
                radius: 20,
                backgroundColor: Color(0xFFCCCCCC),
                backgroundImage: NetworkImage(_orderEntity.user.headImgUrl),
              ),
              Padding(padding: EdgeInsets.only(left: 8)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 2)),
                  Text(
                    _orderEntity.title, //TODO _orderEntity.content
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF999999),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                _orderEntity.createdAt,
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF999999),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 2)),
              Text(
                '￥ 15', //TODO _orderEntity.price
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget renderPublishContent() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            _orderEntity.title, //TODO _orderEntity.content
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Color(0xFF333333),
            ),
          ),
          SizedBox(height: 14),
          ColorLabel('# ${_orderEntity.type}', Color(0xFFFFC600)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    name = _orderEntity.user.nickName == null
        ? _orderEntity.user.realName
        : _orderEntity.user.nickName;
    return Container(
      margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            blurRadius: 6,
            spreadRadius: 4,
            color: Color.fromARGB(20, 0, 0, 0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          this.renderUserInfo(),
          this.renderPublishContent(),
        ],
      ),
    );
  }
}

class _BottomToolBar extends StatelessWidget {
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
              // TODO 跳转到原生个人主页
            },
            child: Center(
              child: Text(
                '看TA资料',
                style: TextStyle(fontSize: 16, color: Colors.blue),
              ),
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              // TODO 跳转到原生消息聊天页
            },
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.blue,
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
