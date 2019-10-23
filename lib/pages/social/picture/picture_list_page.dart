import 'package:data_plugin/bmob/bmob_query.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/entity/qy_picture_entity.dart';
import 'package:flutter_app/widgets/load_more_widget.dart';
import 'package:flutter_app/widgets/no_more_data_widget.dart';

class PictureListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PageState();
}

class PageState extends State<PictureListPage> {
  List<QyPictureEntity> _dataList;
  var _loadItemCount = 6;
  var _itemTotalCount = 0;
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

  _loadMoreData() {
    if (!_isLoadData) {
      _isLoadData = true;
      _itemTotalCount += _loadItemCount;
      BmobQuery<QyPictureEntity> query = BmobQuery();
      query.setInclude("userEntity");
      query.setOrder("-updatedAt");
      query.setLimit(_loadItemCount);
      query.setSkip(_itemTotalCount);
      query.queryObjects().then((List<dynamic> data) {
        _isLoadData = false;
        this.setState(() {
          var newList =
              data.map((item) => QyPictureEntity.fromJson(item)).toList();
          _hasMoreData = newList.length > 0 ? true : false;
          _dataList.addAll(newList);
        });
      });
    }
  }

  _initData() {
    BmobQuery<QyPictureEntity> query = BmobQuery();
    query.setInclude("userEntity");
    query.setOrder("-updatedAt");
    query.setLimit(_loadItemCount);
    query.setSkip(_itemTotalCount);
    query.queryObjects().then((List<dynamic> data) {
      this.setState(() {
        _dataList = data.map((item) => QyPictureEntity.fromJson(item)).toList();
      });
    });
  }

  Future<Null> _handleRefreshEvent() async {
    setState(() {
      _dataList.clear();
      _hasMoreData = true;
    });
    _itemTotalCount = 0;
    _initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("一闪●最美曲园"),
        centerTitle: true,
        elevation: 0,
      ),
      body: _dataList == null
          ? Center(
              child: Text("数据加载中..."),
            )
          : RefreshIndicator(
              child: ListView.builder(
                controller: _scrollController,
                itemBuilder: (BuildContext context, int index) {
                  if (index == _dataList.length) {
                    return _hasMoreData ? LoadMoreWidget() : NoMoreDataWidget();
                  } else {
                    return _itemWidget(qyPictureEntity: _dataList[index]);
                  }
                },
                itemCount: _dataList.length + 1,
              ),
              onRefresh: _handleRefreshEvent),
    );
  }
}

class _itemWidget extends StatelessWidget {
  QyPictureEntity qyPictureEntity;

  _itemWidget({this.qyPictureEntity});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(
        20.0,
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              ClipOval(
                child: SizedBox(
                  height: 40,
                  width: 40,
                  child: qyPictureEntity.userEntity.headImgUrl == null
                      ? Image.asset(
                          "lib/img/ic_default_header_img.png",
                          fit: BoxFit.cover,
                        )
                      : Image.network(
                          qyPictureEntity.userEntity.headImgUrl,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              SizedBox(width: 10),
              Text(
                  "# ${qyPictureEntity.location == null ? "未知" : qyPictureEntity.location}",
                  style: TextStyle(fontSize: 15, color: Colors.grey)),
              SizedBox(width: 5),
              Text(qyPictureEntity.createdAt,
                  style: TextStyle(fontSize: 14, color: Colors.grey)),
            ],
          ),
          SizedBox(height: 20),
          SizedBox(
            height: 350,
            width: double.infinity,
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                ClipRRect(
                  child: Image.network(
                    qyPictureEntity.pictureUrl,
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                Align(
                  alignment: FractionalOffset(0.5, 0.96),
                  child: Text(
                    qyPictureEntity.pictureDesc,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.white),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 20),
          Container(
            height: 35,
            width: 35,
            child: Image.asset(
              "lib/img/ic_share.png",
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
