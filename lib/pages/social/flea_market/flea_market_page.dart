import 'package:data_plugin/bmob/bmob_query.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/entity/goods_entity.dart';
import 'package:flutter_app/pages/common_web_page.dart';
import 'package:flutter_app/utils/constant.dart';
import 'package:flutter_app/widgets/load_more_widget.dart';
import 'package:flutter_app/widgets/no_more_data_widget.dart';

class FleaMarketPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PageState();
}

class PageState extends State<FleaMarketPage> {
  List<GoodsEntity> dataList;
  var _loadItemCount = 10;
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
    BmobQuery<GoodsEntity> query = BmobQuery();
    query.setInclude("goodsOwner");
    query.setOrder("-updatedAt");
    query.setLimit(_loadItemCount);
    query.queryObjects().then((List<dynamic> data) {
      this.setState(() {
        dataList = data.map((item) => GoodsEntity.fromJson(item)).toList();
      });
    });
  }

  Future<Null> _loadMoreData() async {
    if (!_isLoadData) {
      _isLoadData = true;
      _itemTotalSize += _loadItemCount;

      BmobQuery<GoodsEntity> query = BmobQuery();
      query.setInclude("author");
      query.setOrder("-updatedAt");
      query.setLimit(_loadItemCount);
      query.setSkip(_itemTotalSize);
      query.queryObjects().then((List<dynamic> data) {
        _isLoadData = false;
        var newList = data.map((item) => GoodsEntity.fromJson(item)).toList();
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
      backgroundColor: Color(0xffF5F5F5),
      appBar: AppBar(
        title: Text("跳蚤集市"),
        centerTitle: true,
        elevation: 1,
        actions: <Widget>[
          InkWell(
            onTap: () {},
            child: SizedBox(
              height: 30,
              width: 60,
              child: Center(
                child: Text(
                  "发布",
                  style: TextStyle(fontSize: 17, color: Colors.black),
                ),
              ),
            ),
          )
        ],
      ),
      body: dataList == null
          ? Center(
              child: Text("数据加载中..."),
            )
          : RefreshIndicator(
              child: ListView.builder(
                  itemCount: dataList.length + 1,
                  controller: _scrollController,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == dataList.length) {
                      return _hasMoreData
                          ? LoadMoreWidget()
                          : NoMoreDataWidget();
                    } else {
                      return _goodsItemWidget(goodsEntity: dataList[index]);
                    }
                  }),
              onRefresh: _handleRefreshEvent),
    );
  }
}

class _goodsItemWidget extends StatelessWidget {
  GoodsEntity goodsEntity;

  _goodsItemWidget({this.goodsEntity});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_){
            return CommonWebPage(
                url: Constant.FLEA_MARKET + goodsEntity.objectId,
                title: "跳蚤市场");
          }));
        },
        child: Column(
          children: <Widget>[
            SizedBox(height: 8),
            Stack(
              children: <Widget>[
                Container(
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ClipOval(
                          child: SizedBox(
                            width: 40,
                            height: 40,
                            child: goodsEntity.goodsOwner.headImgUrl == null
                                ? Image.asset(
                                    'lib/img/ic_default_header_img.png',
                                    fit: BoxFit.cover)
                                : Image.network(
                                    goodsEntity.goodsOwner.headImgUrl,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(height: 5),
                              Text(
                                  "${goodsEntity.goodsOwner.realName == null ? "未知" : goodsEntity.goodsOwner.realName}.${goodsEntity.goodsOwnerLocal == null ? "未知" : goodsEntity.goodsOwnerLocal}",
                                  style: TextStyle(
                                      fontSize: 14, color: Color(0xff999999))),
                              SizedBox(height: 5),
                              Text(goodsEntity.createdAt,
                                  style: TextStyle(
                                      fontSize: 12, color: Color(0xff999999))),
                              SizedBox(height: 10),
                              Text(
                                goodsEntity.goodsContent,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 16, color: Color(0xff333333)),
                              ),
                              SizedBox(height: 3),
                              SizedBox(
                                height: 120,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: goodsEntity.goodsUrl.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: <Widget>[
                                          SizedBox(
                                            width: 140,
                                            height: 100,
                                            child: Image.network(
                                                goodsEntity.goodsUrl[index],
                                                fit: BoxFit.cover),
                                          ),
                                          SizedBox(
                                            width: 8,
                                          )
                                        ],
                                      );
                                    }),
                              ),
                              SizedBox(height: 8),
                              Text("￥${goodsEntity.goodsPrice}",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.red))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                goodsEntity.tradeType == 1
                    ? Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          height: 30,
                          width: 65,
                          decoration: BoxDecoration(
                              color: Colors.teal,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  bottomRight: Radius.circular(15))),
                          child: Center(
                              child: Text(
                            '可议价',
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          )),
                        ),
                      )
                    : Text("")
              ],
            )
          ],
        ));
  }
}
