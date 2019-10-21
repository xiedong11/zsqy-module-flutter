import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/entity/home_config_entity.dart';
import 'package:flutter_app/pages/common_web_page.dart';
import 'package:flutter_app/utils/constant.dart';
import 'package:flutter_app/utils/dio_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:flutter_app/widgets/marquee_text.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class SingleDayPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PageState();
}

class PageState extends State<SingleDayPage> {
  HomeConfigEntity _homeConfigEntity;
  bool _showNotificationLabel = false;
  String _weekDay = "周*";
  List<SyllabusItemEntity> _syllabusItemList = [
    SyllabusItemEntity(
        title: "", timeLabel: "8:00-10:00", batteryIndex: "ic_battery_100.png"),
    SyllabusItemEntity(
        title: "", timeLabel: "10:00-12:00", batteryIndex: "ic_battery_75.png"),
    SyllabusItemEntity(
        title: "", timeLabel: "14:00-16:00", batteryIndex: "ic_battery_50.png"),
    SyllabusItemEntity(
        title: "", timeLabel: "16:00-18:00", batteryIndex: "ic_battery_25.png"),
    SyllabusItemEntity(
        title: "", timeLabel: "19:00-21:00", batteryIndex: "ic_battery_0.png"),
  ];

  @override
  void initState() {
    super.initState();
    this.setState(() {
      _weekDay = Utils.getTodayWeekDay();
    });
    getBannerEntity();
  }

  Future<void> _onRefresh() async {
    getBannerEntity();
  }

  void getBannerEntity() async {
    Response result = await Dio().get(Constant.HOME_BANNER_URL);
    HomeConfigEntity homeConfigEntity =
        HomeConfigEntity.fromJson(jsonDecode(result.data));
    this.setState(() {
      _homeConfigEntity = homeConfigEntity;
      _showNotificationLabel =
          homeConfigEntity.notificationLabel.length > 2 ? true : false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _weekDay,
          style: TextStyle(
              color: Colors.black, fontSize: 26, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      body: Container(
        color: Colors.white,
        child: RefreshIndicator(
            displacement: 20,
            child: ListView(
              children: <Widget>[
                Container(
                  color: Colors.white,
                  width: double.infinity,
                  height: 150,
                  child: Swiper(
                    itemCount: _homeConfigEntity != null &&
                            _homeConfigEntity.banner.length > 0
                        ? _homeConfigEntity.banner.length
                        : 0,
                    scale: 0.9,
                    viewportFraction: 0.8,
                    autoplay: true,
                    duration: 2000,
                    pagination: new SwiperPagination(
                        builder: DotSwiperPaginationBuilder(
                      color: Colors.white,
                      activeColor: Colors.teal,
                    )),
                    controller: new SwiperController(),
                    itemBuilder: (BuildContext context, int index) {
                      return Image.network(
                        _homeConfigEntity.banner.length > 0
                            ? _homeConfigEntity.banner[index].bannerImgUrl
                            : "",
                        fit: BoxFit.cover,
                      );
                    },
                    onTap: (index) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => CommonWebPage(
                              url: _homeConfigEntity
                                  .banner[index].bannerContentUrl,
                              title: "")));
                    },
                  ),
                ),
                _showNotificationLabel == true
                    ? Container(
                        height: 25,
                        color: Color(0xffffebc7),
                        child: Stack(
                          children: <Widget>[
                            Padding(
                                padding: EdgeInsets.only(left: 10, right: 26),
                                child: Align(
                                  child: MarqueeText(
                                      child: Text(
                                        _homeConfigEntity == null
                                            ? ""
                                            : _homeConfigEntity
                                                .notificationLabel,
                                        maxLines: 1,
                                        style: TextStyle(
                                            color: Color(0xff9fa0a0),
                                            fontSize: 12),
                                      ),
                                      paddingLeft: 200,
                                      duration: Duration(seconds: 5),
                                      stepOffset: 230),
                                  alignment: FractionalOffset(0.0, 0.5),
                                )),
                            Positioned(
                              right: 5,
                              child: GestureDetector(
                                onTap: () {
                                  this.setState(() {
                                    _showNotificationLabel = false;
                                  });
                                },
                                child: SizedBox(
                                  width: 25,
                                  height: 25,
                                  child: Image.asset(
                                    "lib/img/ic_del.png",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    : Text(""),
                Padding(
                  padding: EdgeInsets.only(top: 10, left: 15, bottom: 10),
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                        width: 5,
                        child: Container(
                          color: Colors.teal,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "校园新鲜事",
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                    itemCount: 5,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          SizedBox(width: 10),
                          Card(
                            elevation: 1,
                            color: Colors.white,
                            child: Container(
                              width: 330,
                              child: Stack(
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        color: Colors.teal,
                                        width: 80,
                                        height: 25,
                                        child: Center(
                                            child: Text(
                                          "社区动态",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white),
                                        )),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: 25, top: 10, right: 60),
                                          child: Text(
                                            '发士撒地方撒多法撒旦法撒旦法撒旦法师的胜多负少大放送',
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Color(0xff333333)),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: SizedBox(
                                      child: Image.network(
                                        'https://avatar.csdn.net/6/0/6/3_xieluoxixi.jpg',
                                        fit: BoxFit.cover,
                                      ),
                                      width: 50,
                                      height: 50,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10, left: 15, bottom: 10),
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                        width: 5,
                        child: Container(
                          color: Colors.deepOrangeAccent,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "今日课表",
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 15),
                ListView.builder(
                    itemCount: 5,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return SyllabusItemWidget(_syllabusItemList[index]);
                    }),
              ],
            ),
            onRefresh: _onRefresh),
      ),
    );
  }
}

class SyllabusItemEntity {
  String title;
  String batteryIndex;
  String timeLabel;

  SyllabusItemEntity({this.title, this.batteryIndex, this.timeLabel});
}

class SyllabusItemWidget extends StatelessWidget {
  SyllabusItemEntity _syllabusItemEntity;

  SyllabusItemWidget(this._syllabusItemEntity);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15),
      child: Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              SizedBox(
                height: 5,
                width: 5,
                child: Container(
                  color: Color(0xffcccccc),
                ),
              ),
              Container(
                color: Color(0xffdddddd),
                width: 1,
                height: 65,
              ),
              SizedBox(
                height: 1,
              )
            ],
          ),
          SizedBox(
            width: 15,
          ),
          Column(
            children: <Widget>[
              SizedBox(
                width: 13,
                height: 22,
                child: Image.asset(
                  "lib/img/${_syllabusItemEntity.batteryIndex}",
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                _syllabusItemEntity.timeLabel,
                style: TextStyle(fontSize: 10, color: Color(0xff999999)),
              )
            ],
          )
        ],
      ),
    );
  }
}
