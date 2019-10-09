import 'package:data_plugin/bmob/bmob_query.dart';
import 'package:data_plugin/bmob/response/bmob_handled.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/entity/order_entity.dart';
import 'package:flutter_app/pages/helper/order/new_order.dart';
import 'package:flutter_app/pages/helper/order/order_item_detail.dart';
import 'package:flutter_app/utils/plat_form_util.dart';
import 'package:flutter_app/utils/user_cache.dart';
import 'package:flutter_app/widgets/color_label.dart';
import 'package:flutter_app/widgets/load_more_widget.dart';
import 'package:flutter_app/widgets/no_more_data_widget.dart';

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
  bool _hasMoreData = true;

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
      _hasMoreData = true;
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
          _hasMoreData = newList.length > 0 ? true : false;
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
                      if (index == dataList.length) {
                        return _hasMoreData
                            ? LoadMoreWidget()
                            : NoMoreDataWidget();
                      } else {
                        return ItemWidget(dataList[index], this);
                      }
                    },
                    itemCount: dataList.length + 1,
                  ),
                  onRefresh: _handleRefreshEvent),
              //背景颜色
              decoration:
                  BoxDecoration(color: Color.fromRGBO(244, 243, 243, 1)),
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
        child: Icon(
          Icons.add,
          size: 36,
        ),
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
    bool isOverdue = DateTime.now()
            .difference(DateTime.parse(_orderEntity.createdAt))
            .inHours >
        24;
    return GestureDetector(
        child: Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.only(bottom: 15, top: 10),
            decoration: BoxDecoration(color: Colors.white),
            child: Stack(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 20, top: 0),
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
                              SizedBox(height: 4),
                              Text(_orderEntity.createdAt,
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 12)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 25, right: 10, top: 15, bottom: 35),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(_orderEntity.title,
                              maxLines: 5,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 14)),
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned(
                  right: 10,
                  child: isOverdue
                      ? Image.asset(
                          'lib/img/ic_overdue.png',
                          scale: 5,
                          color: Colors.grey,
                        )
                      : Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(244, 243, 243, 1),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Text(
                            '#' + _orderEntity.type,
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ),
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
        ),
        //长按删除任务
        onLongPress: () {
          _showItemDelDialog(context, _orderEntity);
        },
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => OrderItemDetail(orderEntity: _orderEntity)));
        });
  }

  void _showItemDelDialog(BuildContext context, OrderEntity orderEntity) {
    showDialog(
        context: context,
        child: new AlertDialog(
          title: Text(
            "确定要删除吗？",
            style: TextStyle(color: Colors.red),
          ),
          content: Text("任务删除后不可恢复，若任务已完成或者不想再展示，请放心删除..."),
          actions: <Widget>[
            FlatButton(
                onPressed: () {
                  _onDelItemEvent(context, orderEntity);
                  Navigator.of(context).pop();
                },
                child: Text("确定")),
            FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("再想想")),
          ],
        ));
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
