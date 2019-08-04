import 'package:data_plugin/bmob/bmob_query.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/entity/order_entity.dart';
import 'package:flutter_app/pages/order/new_order.dart';
import 'package:flutter_app/pages/order/order_item_detail.dart';
import 'package:flutter_app/utils/user_cache.dart';
import 'package:flutter_app/widgets/mywidgets.dart';

class OrderList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PageState();
}

class PageState extends State<OrderList> {
  List<OrderEntity> dataList;

  @override
  void initState() {
    super.initState();
    initData();
  }

  initData() async {
    if (UserCache.user == null) {
      await UserCache.initAppConfigId();
    }
    BmobQuery<OrderEntity> query = BmobQuery();
    query.setInclude("user");
    query.setOrder("-createdAt");
    query.queryObjects().then((List<dynamic> data) {
      this.setState(() {
        dataList = data.map((i) => OrderEntity.fromJson(i)).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: this.dataList != null
          ? Container(
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return ItemWidget(dataList[index]);
                },
                itemCount: dataList.length,
              ),
              decoration: BoxDecoration(color: Colors.black26),
            )
          : Center(
              child: Text('数据加载中...'),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => NewOrder()));
        },
        child: Icon(Icons.directions_run),
        backgroundColor: Colors.orangeAccent,
      ),
    );
  }
}

class ItemWidget extends StatelessWidget {
  OrderEntity _orderEntity;

  ItemWidget(this._orderEntity);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Container(
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
              // 右上角创建时间
              Positioned(
                child: Text(_orderEntity.createdAt),
                right: 10,
                top: 10,
              ),
              //右下角类型标签
              Positioned(
                child: Row(
                  children: <Widget>[
                    Text(
                      '￥ 15',//TODO _orderEntity.price
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    SizedBox(width: 10),
                    _SwitchColor(_orderEntity.type),
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
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => OrderItemDetail(orderEntity: _orderEntity)));
        });
  }
}

class _SwitchColor extends StatelessWidget {
  String type;
  _SwitchColor(this.type);

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case '取快递':
        return ColorLabel('# ${type}', Color(0xFFFFC600));
      case '送礼物':
        return ColorLabel('# ${type}', Colors.pink);
      case '陪聊天':
        return ColorLabel('# ${type}', Colors.yellow);
      case '求解答':
        return ColorLabel('# ${type}', Colors.lightBlue);
      case '帮买饭':
        return ColorLabel('# ${type}', Colors.orange);
      case '其他':
        return ColorLabel('# ${type}', Color(0xFFFFC600));
      default:
        return ColorLabel('# ${type}', Colors.green);
    }
  }
}
