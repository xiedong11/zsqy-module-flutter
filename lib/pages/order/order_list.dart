import 'package:data_plugin/bmob/bmob_query.dart';
import 'package:data_plugin/bmob/response/bmob_handled.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/entity/order_entity.dart';
import 'package:flutter_app/pages/order/new_order.dart';
import 'package:flutter_app/pages/order/order_item_detail.dart';
import 'package:flutter_app/utils/plat_form_util.dart';
import 'package:flutter_app/utils/user_cache.dart';
import 'package:flutter_app/widgets/color_label.dart';

class OrderList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PageState();
}

class PageState extends State<OrderList> {
  List<OrderEntity> dataList;
  var _loadItemCount = 6;
  var _itemTotalSize = 0;
  ScrollController _scrollController = ScrollController();
  bool _isLoadData = false;

  @override
  void initState() {
    super.initState();
    initData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadMoreData();
      }
    });
  }

  initData() async {
    if (UserCache.user == null) {
      await UserCache.initAppConfigId();
    }
    BmobQuery<OrderEntity> query = BmobQuery();
    query.setInclude("user");
    query.setOrder("-createdAt");
    query.setLimit(_loadItemCount);
    query.queryObjects().then((List<dynamic> data) {
      this.setState(() {
        dataList = data.map((i) => OrderEntity.fromJson(i)).toList();
      });
    });
  }

  Future<Null> _handleRefreshEvent() async {
    setState(() {
      dataList.clear();
    });
    _itemTotalSize = 0;
    initData();
  }

  Future<Null> _loadMoreData() async {
    if (!_isLoadData) {
      _isLoadData = true;
      _itemTotalSize += _loadItemCount;
      BmobQuery<OrderEntity> query = BmobQuery();
      query.setInclude("user");
      query.setOrder("-createdAt");
      query.setSkip(_itemTotalSize);
      query.setLimit(_loadItemCount);
      query.queryObjects().then((List<dynamic> data) {
        _isLoadData = false;
        var newList = data.map((i) => OrderEntity.fromJson(i)).toList();
        this.setState(() {
          dataList.addAll(newList);
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: this.dataList != null
          ? Container(
              child: RefreshIndicator(
                  displacement: 45,
                  color: Colors.orange,
                  child: ListView.builder(
                    controller: _scrollController,
                    itemBuilder: (BuildContext context, int index) {
                      return ItemWidget(dataList[index], this);
                    },
                    itemCount: dataList.length,
                  ),
                  onRefresh: _handleRefreshEvent),
              decoration: BoxDecoration(color: Colors.white12),
            )
          : Center(
              child: Text('数据加载中...'),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => NewOrder()))
              .then((value) {
            if (value == "success") {
              _handleRefreshEvent();
            }
          });
        },
        child: Icon(Icons.add,size: 36,),
        backgroundColor: Colors.orangeAccent,
      ),
    );
  }
}

class ItemWidget extends StatelessWidget {
  OrderEntity _orderEntity;
  PageState _pageState;

  ItemWidget(this._orderEntity, this._pageState);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Padding(
          padding: EdgeInsets.only(bottom: 4, left: 3, right: 3),
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
                          Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(_orderEntity.user.nickName == null
                                ? _orderEntity.user.realName
                                : _orderEntity.user.nickName),
                            Text(_orderEntity.user.major,style:TextStyle(color: Colors.black54, fontSize: 12)),    
                          ],
                        ),
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
                        '￥ ${_orderEntity.price}',
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
        ),
        onLongPress: () {
          _onDelItemEvent(context, _orderEntity);
        },
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => OrderItemDetail(orderEntity: _orderEntity)));
        });
  }

  void _onDelItemEvent(BuildContext context, OrderEntity orderEntity) async {
    var currentUserId = UserCache.user.objectId;

    if (currentUserId == null) {
      currentUserId =
          await PlatFormUtil.callNativeApp(PlatFormUtil.GET_USER_OBJECT_ID);
    }

    if (orderEntity.user.objectId == currentUserId) {
      orderEntity.delete().then((BmobHandled bmobHandled) {
        _pageState._handleRefreshEvent();
        Scaffold.of(context).showSnackBar(new SnackBar(
          content: new Text(
            "删除成功",
            style: TextStyle(color: Colors.yellowAccent),
          ),
        ));
      });
    } else {
      Scaffold.of(context).showSnackBar(new SnackBar(
        content: new Text(
          "无权删除其他用户的订单...",
          style: TextStyle(color: Colors.redAccent),
        ),
      ));
    }
  }
}

class _SwitchColor extends StatelessWidget {
  String type;

  _SwitchColor(this.type);

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case '取快递':
        return ColorLabel('# ${type}', Colors.green);
      case '送礼物':
        return ColorLabel('# ${type}', Colors.pink);
      case '陪聊天':
        return ColorLabel('# ${type}', Colors.yellow[600]);
      case '替上课':
        return ColorLabel('# ${type}', Colors.lightBlue);
      case '帮买饭':
        return ColorLabel('# ${type}', Colors.orange);
      case '其他':
        return ColorLabel('# ${type}', Color(0xFFFFC600));
      default:
        return ColorLabel('# ${type}', Colors.black);
    }
  }
}
