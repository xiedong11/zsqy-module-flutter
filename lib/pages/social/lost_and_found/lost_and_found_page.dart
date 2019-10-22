import 'package:data_plugin/bmob/bmob_query.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/entity/lost_and_found_entity.dart';
import 'package:flutter_app/widgets/load_more_widget.dart';
import 'package:flutter_app/widgets/no_more_data_widget.dart';

class LostAndFoundPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PageState();
}

class PageState extends State<LostAndFoundPage> {
  List<LostAndFoundEntity> _dataList;
  var _loadItemCount = 10;
  var _itemTotalSize = 0;
  ScrollController _scrollController = ScrollController();
  bool _isLoadData = false;
  bool _hasMoreData = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadMoreData();
      }
    });
    _initData();
  }

  _initData() {
    BmobQuery<LostAndFoundEntity> query = BmobQuery();
    query.setInclude("userEntity");
    query.setOrder("-updatedAt");
    query.setLimit(_loadItemCount);
    query.setSkip(_itemTotalSize);
    query.queryObjects().then((List<dynamic> data) {
      this.setState(() {
        _dataList =
            data.map((item) => LostAndFoundEntity.fromJson(item)).toList();
      });
    });
  }

  _loadMoreData() async {
    if (!_isLoadData) {
      _isLoadData = true;
      _itemTotalSize += _loadItemCount;

      BmobQuery<LostAndFoundEntity> query = BmobQuery();
      query.setInclude("userEntity");
      query.setOrder("-updatedAt");
      query.setLimit(_loadItemCount);
      query.setSkip(_itemTotalSize);
      query.queryObjects().then((List<dynamic> data) {
        this.setState(() {
          _isLoadData = false;
          var newList =
              data.map((item) => LostAndFoundEntity.fromJson(item)).toList();
          _hasMoreData = newList.length > 0 ? true : false;
          _dataList.addAll(newList);
        });
      });
    }
  }

  Future<Null> _handleRefreshEvent() async {
    setState(() {
      _dataList.clear();
      _hasMoreData = true;
    });
    _itemTotalSize = 0;
    _initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("失物招领"),
        centerTitle: true,
        elevation: 0,
        actions: <Widget>[
          InkWell(
            onTap: () {},
            child: Padding(
              child: Icon(Icons.add),
              padding: EdgeInsets.only(right: 10),
            ),
          )
        ],
      ),
      body: RefreshIndicator(
          child: ListView(
            controller: _scrollController,
            children: <Widget>[
              Image.asset("lib/img/ic_lost_and_found_barrage_bg.png",
                  fit: BoxFit.cover),
              _dataList == null || _dataList.length == 0
                  ? Center(
                      child: Text('数据加载中...'),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _dataList.length + 1,
                      itemBuilder: (BuildContext context, int index) {
                        if (index == _dataList.length) {
                          return _hasMoreData
                              ? LoadMoreWidget()
                              : NoMoreDataWidget();
                        } else {
                          return _listItemWidget(
                              lostAndFoundEntity: _dataList[index]);
                        }
                      })
            ],
          ),
          onRefresh: _handleRefreshEvent),
    );
  }
}

class _listItemWidget extends StatelessWidget {
  LostAndFoundEntity lostAndFoundEntity;

  _listItemWidget({this.lostAndFoundEntity});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      child: Stack(
        children: <Widget>[
          Row(
            children: <Widget>[
              ClipOval(
                child: Container(
                  height: 55,
                  width: 55,
                  color:
                      lostAndFoundEntity.type == 1 ? Colors.grey : Colors.teal,
                  child: Center(
                    child: Text(
                      lostAndFoundEntity.type == 1 ? "丢" : "捡",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 25),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      lostAndFoundEntity.title,
                      style: TextStyle(fontSize: 17, color: Colors.black87),
                    ),
                    SizedBox(height: 8),
                    Text(
                      lostAndFoundEntity.content,
                      style: TextStyle(fontSize: 15, color: Colors.black54),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              lostAndFoundEntity.goodsUrl != null &&
                      lostAndFoundEntity.goodsUrl.isNotEmpty
                  ? Padding(
                      padding: EdgeInsets.only(top: 25, left: 10),
                      child: SizedBox(
                        child: Image.network(
                          lostAndFoundEntity.goodsUrl[0],
                          fit: BoxFit.cover,
                        ),
                        width: 40,
                        height: 40,
                      ),
                    )
                  : Text("")
            ],
          ),
          Positioned(
            child: Text(
              lostAndFoundEntity.createdAt,
              style: TextStyle(fontSize: 13, color: Colors.black54),
            ),
            right: 10,
          )
        ],
      ),
    );
  }
}
