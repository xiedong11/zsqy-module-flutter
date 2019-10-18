import 'package:data_plugin/bmob/bmob_query.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/entity/heart_share_entity.dart';
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

class SocialListItem extends StatefulWidget {
  HeartShare _heartShare;

  SocialListItem(this._heartShare);

  @override
  State<StatefulWidget> createState() => SocialListItemState();
}

class SocialListItemState extends State<SocialListItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    ClipOval(
                      child: SizedBox(
                        width: 50,
                        height: 50,
                        child: Image.network(
                          widget._heartShare.author.headImgUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget._heartShare.username,
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                        Text(
                          "${widget._heartShare.createdAt} ${widget._heartShare.userFaculty}",
                          style: TextStyle(fontSize: 12, color: Colors.black54),
                        )
                      ],
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10, top: 10, right: 10),
                  child: Text(
                    widget._heartShare.content,
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                (widget._heartShare.dynamicImgUrl.length == 0)
                    ? Text("")
                    : Container(
                        height: 120,
                        child: Padding(
                          padding: EdgeInsets.only(left: 10, top: 5, right: 10),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: widget._heartShare.dynamicImgUrl.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child: SizedBox(
                                    height: 110,
                                    width: 140,
                                    child: Image.network(
                                      widget._heartShare.dynamicImgUrl[index],
                                      fit: BoxFit.cover,
                                    ),
                                  ));
                            },
                          ),
                        ),
                      ),
                Padding(
                  padding: EdgeInsets.only(left: 20, top: 10),
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 25,
                        height: 25,
                        child: Image.asset(
                          "lib/img/share_likes.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text("9"),
                      SizedBox(
                        width: 20,
                      ),
                      SizedBox(
                        width: 25,
                        height: 25,
                        child: Image.asset("lib/img/share_reply.png",
                            fit: BoxFit.cover),
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text("0"),
                    ],
                  ),
                )
              ],
            ),
            Positioned(
              top: 5,
              right: 5,
              child: Container(
                height: 20,
                width: 80,
                child: Center(
                    child: Text(
                  "#${widget._heartShare.contentType}#",
                  style: TextStyle(fontSize: 12, color: Colors.black87),
                )),
                decoration: BoxDecoration(
                  color: Color(0xffeeeeee),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
