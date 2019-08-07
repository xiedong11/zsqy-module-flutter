import 'package:data_plugin/bmob/bmob_query.dart';
import 'package:data_plugin/bmob/response/bmob_handled.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/entity/helper_entity.dart';
import 'package:flutter_app/pages/helper/new_helper.dart';
import 'package:flutter_app/pages/helper/helper_item_detail.dart';
import 'package:flutter_app/utils/plat_form_util.dart';
import 'package:flutter_app/utils/user_cache.dart';
import 'package:flutter_app/widgets/color_label.dart';
import 'package:flutter_app/widgets/load_more_widget.dart';
import 'package:flutter_app/widgets/no_more_data_widget.dart';

class HelperList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PageState();
}

class PageState extends State<HelperList> {
  List<HelperEntity> dataList;
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
    BmobQuery<HelperEntity> query = BmobQuery();
    query.setInclude("user");
    query.setOrder("-createdAt");
    query.setLimit(_loadItemCount);
    query.queryObjects().then((List<dynamic> data) {
      this.setState(() {
        dataList = data.map((i) => HelperEntity.fromJson(i)).toList();
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
      BmobQuery<HelperEntity> query = BmobQuery();
      query.setInclude("user");
      query.setOrder("-createdAt");
      query.setSkip(_itemTotalSize);
      query.setLimit(_loadItemCount);
      query.queryObjects().then((List<dynamic> data) {
        _isLoadData = false;
        var newList = data.map((i) => HelperEntity.fromJson(i)).toList();
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
              decoration: BoxDecoration(color: Colors.white12),
            )
          : Center(
              child: Text('数据加载中...'),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
                  context, MaterialPageRoute(builder: (_) => NewHelper()))
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
        backgroundColor: Colors.lightBlue,
      ),
    );
  }
}

class ItemWidget extends StatelessWidget {
  HelperEntity _helperEntity;
  PageState _pageState;

  ItemWidget(this._helperEntity, this._pageState);

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
                            _helperEntity.user.headImgUrl,
                            width: 50,
                            height: 50,
                          )),
                          SizedBox(width: 10),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(_helperEntity.user.nickName == null
                                  ? _helperEntity.user.realName
                                  : _helperEntity.user.nickName),
                              Text(_helperEntity.user.major,
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 12)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 70, right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(_helperEntity.title,
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
                  child: Text(_helperEntity.createdAt),
                  right: 10,
                  top: 10,
                ),
                Positioned(
                  child: Row(
                    children: <Widget>[
                      Text(
                        '￥ ${_helperEntity.price == null ? '0' : _helperEntity.price}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                      SizedBox(width: 10),
                      _SwitchColor(_helperEntity.where),
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
        //长按删除任务
        onLongPress: () {
          _showItemDelDialog(context, _helperEntity);
        },
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => HelperItemDetail(helperEntity: _helperEntity)));
        });
  }

  void _showItemDelDialog(BuildContext context, HelperEntity helperEntity) {
    showDialog(
        context: context,
        child: new AlertDialog(
          title: Text(
            "确定要删除吗",
            style: TextStyle(color: Colors.red),
          ),
          content: Text("消息删除后不可恢复，若任务已完成或不想再展示，请放心删除..."),
          actions: <Widget>[
            FlatButton(
                onPressed: () {
                  _onDelItemEvent(context, helperEntity);
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

  void _onDelItemEvent(BuildContext context, HelperEntity helperEntity) async {
    var currentUserId = UserCache.user.objectId;

    if (currentUserId == null) {
      currentUserId =
          await PlatFormUtil.callNativeApp(PlatFormUtil.GET_USER_OBJECT_ID);
    }

    if (helperEntity.user.objectId == currentUserId) {
      helperEntity.delete().then((BmobHandled bmobHandled) {
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
          "无权删除其他用户的信息...",
          style: TextStyle(color: Colors.redAccent),
        ),
      ));
    }
  }
}

class _SwitchColor extends StatelessWidget {
  String where;

  _SwitchColor(this.where);

  @override
  Widget build(BuildContext context) {
    switch (where) {
      // case '取快递':
      //   return ColorLabel('# ${where}', Colors.green);
      // case '送礼物':
      //   return ColorLabel('# ${where}', Colors.pink);
      // case '陪聊天':
      //   return ColorLabel('# ${where}', Colors.lightBlue);
      // case '替上课':
      //   return ColorLabel('# ${where}', Colors.yellow[600]);
      // case '帮买饭':
      //   return ColorLabel('# ${where}', Colors.orange);
      // case '其他':
      //   return ColorLabel('# ${where}', Color(0xFFFFC600));
      default:
        return ColorLabel(
            where.length > 6 ? '${where.substring(0, 6)}...' : '${where}',
            Colors.lightBlue);
    }
  }
}
