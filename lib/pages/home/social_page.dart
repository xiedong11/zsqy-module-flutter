import 'package:data_plugin/bmob/bmob_query.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/entity/heart_share_entity.dart';
import 'package:flutter_app/pages/social/flea_market/flea_market_page.dart';
import 'package:flutter_app/pages/social/helper/helper_home.dart';
import 'package:flutter_app/pages/social/lost_and_found/lost_and_found_page.dart';
import 'package:flutter_app/pages/social/picture/picture_list_page.dart';
import 'package:flutter_app/pages/social/social/social_list_item.dart';
import 'package:flutter_app/pages/social/social/social_list_page.dart';

class SocialPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PageState();
}

class PageState extends State<SocialPage> {
  List<HeartShare> dataList;
  List<ModuleItemEntity> _moduleList = [
    ModuleItemEntity("校友圈", 'lib/img/ic_school_social.png', SocialListPage()),
    ModuleItemEntity(
        "跳蚤市场", 'lib/img/ic_social_flea_market.png', FleaMarketPage()),
    ModuleItemEntity(
        "帮跑腿", 'lib/img/ic_social_employ.png', HelperHome(isForNative: false)),
    ModuleItemEntity(
        "失物招领", 'lib/img/ic_school_social.png', LostAndFoundPage()),
    ModuleItemEntity(
        "一闪", 'lib/img/ic_social_lost_and_found.png', PictureListPage())
  ];

  @override
  void initState() {
    super.initState();
    _initData();
  }

  _initData() {
    BmobQuery<HeartShare> query = BmobQuery();
    query.setInclude("author");
    query.setOrder("-updatedAt");
    query.setLimit(5);
    query.queryObjects().then((List<dynamic> data) {
      this.setState(() {
        dataList = data.map((item) => HeartShare.fromJson(item)).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("动态",
              style: TextStyle(
                  color: Colors.deepOrange,
                  fontSize: 26,
                  fontWeight: FontWeight.bold)),
          elevation: 0,
        ),
        body: Container(
          color: Colors.white,
          child: ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 10, top: 2),
                child: Text(
                  "Block",
                  style: TextStyle(fontSize: 24),
                ),
              ),
              GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5),
                itemBuilder: (BuildContext context, int index) {
                  return ModuleItemWidget(_moduleList[index]);
                },
                itemCount: 5,
//                physics: NeverScrollableScrollPhysics(),//禁用滑动事件,
              ),
//              Flexible(
//                child: Text('dd'),
//              ),
              Container(color: Color(0xffeeeeee), height: 10),
              Container(
                  height: 210,
                  width: double.infinity,
                  child: Stack(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(left: 15, top: 10),
                              child: Text("好物推荐",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black87))),
                          Padding(
                              padding: EdgeInsets.only(
                                left: 15,
                              ),
                              child: Text("精选好物推荐",
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.black54))),
                          Padding(
                            padding: EdgeInsets.only(left: 25, top: 10),
                            child: SizedBox(
                              height: 130,
                              width: 130,
                              child: Image.network(
                                "https://avatar.csdn.net/6/0/6/3_xieluoxixi.jpg",
                                fit: BoxFit.cover,
                                scale: 0.8,
                              ),
                            ),
                          )
                        ],
                      ),
                      Align(
                        child: Padding(
                          padding: EdgeInsets.only(top: 20, bottom: 10),
                          child: Container(color: Color(0xffeeeeee), width: 1),
                        ),
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: Row(
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                    padding: EdgeInsets.only(left: 15, top: 10),
                                    child: Text("周边游",
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black87))),
                                Padding(
                                    padding: EdgeInsets.only(
                                      left: 15,
                                    ),
                                    child: Text("精选好物推荐",
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.black54))),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 25, top: 10),
                              child: SizedBox(
                                height: 60,
                                width: 60,
                                child: Image.network(
                                  "https://avatar.csdn.net/6/0/6/3_xieluoxixi.jpg",
                                  fit: BoxFit.cover,
                                  scale: 0.8,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        right: 10,
                        child: Row(
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Padding(
                                    padding: EdgeInsets.only(left: 15, top: 10),
                                    child: Text("新闻资讯",
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black87))),
                                Padding(
                                    padding: EdgeInsets.only(
                                      left: 15,
                                    ),
                                    child: Text("精选好物推荐",
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.black54))),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 25, top: 10),
                              child: SizedBox(
                                height: 60,
                                width: 60,
                                child: Image.network(
                                  "https://avatar.csdn.net/6/0/6/3_xieluoxixi.jpg",
                                  fit: BoxFit.cover,
                                  scale: 0.8,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Positioned(
                        top: 100,
                        right: 20,
                        child: Container(
                          height: 1,
                          width: 180,
                          color: Color(0xffeeeeee),
                        ),
                      ),
                    ],
                  )),


              dataList == null
                  ? Center(child: Text("数据加载中..."))
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: new NeverScrollableScrollPhysics(),
                      itemCount: dataList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return SocialListItem(dataList[index]);
                      })
            ],
          ),
        ));
  }
}

class ModuleItemEntity {
  String title;
  String imgPath;
  Widget _nextPage;

  ModuleItemEntity(this.title, this.imgPath, this._nextPage);
}

class ModuleItemWidget extends StatelessWidget {
  ModuleItemEntity _moduleItemEntity;

  ModuleItemWidget(this._moduleItemEntity);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => _moduleItemEntity._nextPage));
      },
      child: Column(
        children: <Widget>[
          SizedBox(height: 5),
          Image.asset(
            _moduleItemEntity.imgPath,
            width: 40,
            height: 40,
          ),
          SizedBox(height: 5),
          Text(_moduleItemEntity.title)
        ],
      ),
    );
  }
}
