import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/entity/home_config_entity.dart';
import 'package:flutter_app/utils/constant.dart';
import 'package:flutter_app/utils/dio_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class SingleDayPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PageState();
}

class PageState extends State<SingleDayPage> {
  List<HomeConfigBanner> _bannerList = [];

  @override
  void initState() {
    super.initState();
    getBannerEntity();
  }

  void getBannerEntity() async {
    Response result = await Dio().get(Constant.HOME_BANNER_URL);
    HomeConfigEntity homeConfigEntity =
        HomeConfigEntity.fromJson(jsonDecode(result.data));
    this.setState(() {
      _bannerList = homeConfigEntity.banner;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            color: Colors.white,
            width: double.infinity,
            height: 150,
            child: Swiper(
              itemCount: _bannerList.length > 0 ? _bannerList.length : 0,
              scale: 1,
              viewportFraction: 0.8,
              autoplay: true,
              duration: 2000,
              pagination: new SwiperPagination(),
              controller: new SwiperController(),
              itemBuilder: (BuildContext context, int index) {
                return Image.network(_bannerList.length > 0
                    ? _bannerList[index].bannerImgUrl
                    : "");
              },
            ),
          )
        ],
      ),
    );
  }
}
