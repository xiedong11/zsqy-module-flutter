import 'package:flutter/material.dart';
import 'package:flutter_app/pages/social/flea_market/flea_market_page.dart';
import 'package:flutter_app/pages/social/helper/helper_home.dart';
import 'package:flutter_app/pages/social/lost_and_found/lost_and_found_page.dart';
import 'package:flutter_app/pages/social/picture/picture_list_page.dart';
import 'package:flutter_app/pages/social/social/social_list_page.dart';

class SocialPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PageState();
}

class PageState extends State<SocialPage> {
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
              )
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
