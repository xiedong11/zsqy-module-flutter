import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/entity/home_config_entity.dart';
import 'package:flutter_app/pages/common_web_page.dart';
import 'package:flutter_app/utils/constant.dart';
import 'package:flutter_app/utils/dio_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class SingleDayPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PageState();
}

class PageState extends State<SingleDayPage> {
  List<HomeConfigBanner> _bannerList = [];
  String _weekDay = "周*";

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
      print('-----------'+_bannerList[0].bannerContentUrl);
      _bannerList = homeConfigEntity.banner;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _weekDay,
          style: TextStyle(color: Colors.black, fontSize: 23),
        ),
        elevation: 0,
      ),
      body: Container(
        color: Colors.white,
        child: RefreshIndicator(
          displacement: 40,
            child: ListView(
              children: <Widget>[
                Container(
                  color: Colors.white,
                  width: double.infinity,
                  height: 150,
                  child: Swiper(
                    itemCount: _bannerList.length > 0 ? _bannerList.length : 0,
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
                        _bannerList.length > 0
                            ? _bannerList[index].bannerImgUrl
                            : "",
                        fit: BoxFit.cover,
                      );
                    },
                    onTap: (index) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => CommonWebPage(
                              url: _bannerList[index].bannerContentUrl,
                              title: "")));
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
              ],
            ),
            onRefresh: _onRefresh),
      ),
    );
  }
}
