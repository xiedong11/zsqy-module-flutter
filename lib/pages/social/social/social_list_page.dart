import 'package:data_plugin/bmob/bmob_query.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/entity/heart_share_entity.dart';
import 'package:flutter_app/pages/social/social/social_list_item.dart';
import 'package:flutter_app/widgets/load_more_widget.dart';
import 'package:flutter_app/widgets/no_more_data_widget.dart';

class SocialListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PageState();
}

class PageState extends State<SocialListPage> {
  List<HeartShare> dataList;
  var _loadItemCount = 6;
  var _itemTotalSize = 0;
  ScrollController _scrollController = ScrollController();
  bool _isLoadData = false;
  bool _hasMoreData = true;

  @override
  void initState() {
    super.initState();
    _initData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadMoreData();
      }
    });
  }

  _initData() {
    BmobQuery<HeartShare> query = BmobQuery();
    query.setInclude("author");
    query.setOrder("-updatedAt");
    query.setLimit(_loadItemCount);
    query.queryObjects().then((List<dynamic> data) {
      this.setState(() {
        dataList = data.map((item) => HeartShare.fromJson(item)).toList();
      });
    });
  }

  Future<Null> _loadMoreData() async {
    if (!_isLoadData) {
      _isLoadData = true;
      _itemTotalSize += _loadItemCount;

      BmobQuery<HeartShare> query = BmobQuery();
      query.setInclude("author");
      query.setOrder("-updatedAt"
          ""
          "");
      query.setLimit(_loadItemCount);
      query.setSkip(_loadItemCount);
      query.queryObjects().then((List<dynamic> data) {
        _isLoadData = false;
        var newList = data.map((item) => HeartShare.fromJson(item)).toList();
        this.setState(() {
          _hasMoreData = newList.length > 0 ? true : false;
          dataList.addAll(newList);
        });
      });
    }
  }

  Future<Null> _handleRefreshEvent() async {
    setState(() {
      dataList.clear();
      _hasMoreData = true;
    });
    _itemTotalSize = 0;
    _initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("校友动态"),
        centerTitle: true,
        elevation: 0,
      ),
      body: dataList == null
          ? Center(child: Text("数据加载中..."))
          : RefreshIndicator(
              onRefresh: _handleRefreshEvent,
              displacement: 45,
              color: Colors.orange,
              child: ListView.builder(
                  controller: _scrollController,
                  itemCount: dataList.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == dataList.length) {
                      return _hasMoreData
                          ? LoadMoreWidget()
                          : NoMoreDataWidget();
                    } else {
                      return SocialListItem(dataList[index]);
                    }
                  })),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.teal,
        child: SizedBox(
          height: 28,
          width: 28,
          child: Image.asset(
            "lib/img/social_write.png",
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
