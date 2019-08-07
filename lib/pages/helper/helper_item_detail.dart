import 'package:flutter/material.dart';
import 'package:flutter_app/entity/helper_entity.dart';
import 'package:flutter_app/utils/plat_form_util.dart';
import 'package:flutter_app/widgets/color_label.dart';

class HelperItemDetail extends StatefulWidget {
  HelperEntity helperEntity;

  HelperItemDetail({this.helperEntity});

  @override
  State<StatefulWidget> createState() => PageState(this.helperEntity);
}

class PageState extends State<HelperItemDetail> {
  HelperEntity _helperEntity;

  PageState(this._helperEntity);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('任务详情'),
          centerTitle: true,
        ),
        body: Column(children: <Widget>[
          //头部信息
          Container(
            child: Stack(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    //头像
                    Padding(
                      padding: EdgeInsets.only(left: 20, top: 10),
                      child: Row(
                        children: <Widget>[
                          ClipOval(
                              child: Image.network(
                            _helperEntity.user.headImgUrl,
                            width: 50,
                            height: 50,
                          )),
                          SizedBox(width: 10),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(_helperEntity.user.nickName == null
                                  ? _helperEntity.user.realName
                                  : _helperEntity.user.nickName),
                              Text(_helperEntity.user.major,
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 12)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    //个人信息
                    Padding(
                      padding: EdgeInsets.only(left: 70),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(_helperEntity.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16)),
                        ],
                      ),
                    ),
                  ],
                ),
                //时间
                Positioned(
                  child: Text(_helperEntity.createdAt),
                  right: 10,
                  top: 10,
                ),
                //价格标签
                Positioned(
                  child: Row(
                    children: <Widget>[
                      ColorLabel('# ${_helperEntity.where}', Color(0xFFFFC600)),
                      SizedBox(width: 10),
                      Text(
                        '￥ ${_helperEntity.price}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                      SizedBox(width: 10),
                    ],
                  ),
                  right: 10,
                  bottom: 0,
                )
              ],
            ),
            width: double.infinity,
            height: 150,
            padding: EdgeInsets.only(bottom: 10, top: 5),
            decoration: BoxDecoration(color: Colors.white),
          ),
          SizedBox(height: 20,),
          //body具体信息
          Container(
            width: double.infinity,
            // height: 140,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(color: Colors.white),
              child: Column(
            children: <Widget>[
              //联系地址
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(width: 2.0),
                    Icon(
                      Icons.label,
                      color: Colors.orangeAccent,
                      size: 20.0,
                    ),
                    SizedBox(width: 10.0),
                    Text("联系地址",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.orangeAccent)),
                  ]),
              SizedBox(height: 20,),
              //出发地址
              Padding(
                padding: EdgeInsets.all(2.0),
                child: Row(children: <Widget>[
                  Icon(
                    Icons.fiber_manual_record,
                    color: Colors.lightBlue,
                    size: 20.0,
                  ),
                  SizedBox(width: 20),
                  Container(
                    width: 260.0,
                    child: Text(_helperEntity.start ==''
                                      ? '无'
                                      : '起：'+_helperEntity.start,
                        style: TextStyle(fontSize: 16)),
                  )
                ]),
              ),
              SizedBox(height: 10,),
              //到达地址
              Padding(
                padding: EdgeInsets.all(2.0),
                child: Row(children: <Widget>[
                  Icon(
                    Icons.fiber_manual_record,
                    color: Colors.redAccent,
                    size: 20.0,
                  ),
                  SizedBox(width: 20),
                  Container(
                    width: 260.0,
                    child: Text(_helperEntity.end ==''
                                      ? '无'
                                      : '止：'+_helperEntity.end,
                        style: TextStyle(fontSize: 16)),
                  )
                ]),
              ),
              SizedBox(height: 20.0),
              //联系方式
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(width: 2.0),
                    Icon(
                      Icons.label,
                      color: Colors.orangeAccent,
                      size: 20.0,
                    ),
                    SizedBox(width: 10.0),
                    Text("联系方式",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.orangeAccent)),
                  ]),
              SizedBox(height: 20,),
              //联系方式
              Padding(
                padding: EdgeInsets.all(2.0),
                child: Row(children: <Widget>[
                  Icon(
                    Icons.call,
                    color: Colors.blue,
                    size: 20.0,
                  ),
                  SizedBox(width: 20),
                  Container(
                    width: 260.0,
                    child: Text(_helperEntity.phoneNumber ==''
                                      ? '无'
                                      : _helperEntity.phoneNumber,
                        style: TextStyle(fontSize: 16)),
                  )
                ]),
              ),
              SizedBox(height: 10.0),
              //备注
              Padding(
                padding: EdgeInsets.only(top: 10.0, left: 2.0),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Icon(
                        Icons.details,
                        color: Colors.green,
                        size: 20.0,
                      ),
                      SizedBox(width: 20),
                      Container(
                        width: 260.0,
                        child: Text(_helperEntity.detail ==''
                                      ? '无'
                                      : _helperEntity.detail,
                        style: TextStyle(fontSize: 16)),
                      )
                    ]),
              ),
            ],
          ))
        ]),
        bottomNavigationBar: _BottomToolBar(_helperEntity));
  }
}

class _BottomToolBar extends StatelessWidget {
  HelperEntity _helperEntity;

  _BottomToolBar(this._helperEntity);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      height: 50,
      child: Row(children: <Widget>[
        Expanded(
          flex: 2,
          child: GestureDetector(
            onTap: () {
              PlatFormUtil.callNativeAppWithParams(
                  PlatFormUtil.VIEW_USER_INFO, {
                PlatFormUtil.KEY_RELREASE_USER_ID: _helperEntity.user.objectId
              });
            },
            child: Center(
              child: Text(
                '看TA资料',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              PlatFormUtil.callNativeAppWithParams(PlatFormUtil.OPEN_CHAT, {
                PlatFormUtil.KEY_RELREASE_USER_ID: _helperEntity.user.objectId
              });
            },
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.lightBlue,
              ),
              child: Center(
                child: Text(
                  '私聊',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
