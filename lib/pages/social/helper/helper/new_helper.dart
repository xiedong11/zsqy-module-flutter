import 'package:data_plugin/bmob/response/bmob_saved.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/entity/helper_entity.dart';
import 'package:flutter_app/utils/plat_form_util.dart';
import 'package:flutter_app/utils/user_cache.dart';

int type = 0;

class NewHelper extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PageState();
}

class PageState extends State<NewHelper> {
  TextEditingController _titleEditingController = TextEditingController();
  TextEditingController _phoneNumberEditingController = TextEditingController();
  TextEditingController _priceEditingController = TextEditingController();
  TextEditingController _detailEditingController = TextEditingController();
  TextEditingController _whereEditingController = TextEditingController();

  String _price = '0';
  String _start = '00:00AM';
  String _end = '12:00PM';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("成为帮手"),
          centerTitle: true,
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          children: <Widget>[
            Column(
              children: <Widget>[
                //标题
                Padding(
                  padding: EdgeInsets.all(2.0),
                  child: Row(children: <Widget>[
                    Icon(
                      Icons.flash_on,
                      color: Colors.black45,
                      size: 20.0,
                    ),
                    SizedBox(width: 20),
                    Container(
                      width: 260.0,
                      child: TextField(
                        controller: _titleEditingController,
                        keyboardType: TextInputType.text,
                        decoration: new InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.pinkAccent, width: 2)),
                            contentPadding: const EdgeInsets.all(10.0),
                            labelStyle:
                                TextStyle(color: Colors.grey, fontSize: 14),
                            labelText: "请输入你的标题..."),
                        onChanged: (String str) {
                          if (str.length >= 100) {
                            showDialog(
                                context: context,
                                child: new AlertDialog(
                                  title: Text(
                                    "标题字数已达上限",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  content: Text("建议任务标题控制在100字以内，超出部分首页将不再显示。",
                                      style: TextStyle(color: Colors.black)),
                                  actions: <Widget>[
                                    FlatButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text("确定")),
                                  ],
                                ));
                          }
                        },
                      ),
                    )
                  ]),
                ),
                SizedBox(height: 20.0),
                //当前位置
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(width: 2.0),
                      Text("▌",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.orangeAccent)),
                      SizedBox(width: 10.0),
                      Text("当前位置",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 13)),
                    ]),
                SizedBox(height: 20),
                //当前位置
                Padding(
                  padding: EdgeInsets.all(2.0),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.location_on,
                          color: Colors.black54,
                          size: 20.0,
                        ),
                        SizedBox(width: 20),
                        Container(
                          width: 260.0,
                          child: TextField(
                            controller: _whereEditingController,
                            keyboardType: TextInputType.text,
                            decoration: new InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.blue,
                                  ),
                                ),
                                contentPadding: const EdgeInsets.all(10.0),
                                labelStyle:
                                    TextStyle(color: Colors.grey, fontSize: 14),
                                labelText: "你的位置..."),
                            onChanged: (String str) {
                              if (str.length >= 15) {
                                showDialog(
                                    context: context,
                                    child: new AlertDialog(
                                      title: Text(
                                        "位置字数已达上限",
                                        style: TextStyle(color: Colors.red),
                                      ),
                                      content: Text("请将位置字数控制在15字以内！",
                                          style:
                                              TextStyle(color: Colors.black)),
                                      actions: <Widget>[
                                        FlatButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text("确定")),
                                      ],
                                    ));
                              }
                            },
                          ),
                        )
                      ]),
                ),
                SizedBox(height: 20),
                //空闲时间
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(width: 2.0),
                      Text("▌",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.orangeAccent)),
                      SizedBox(width: 10.0),
                      Text("空闲时间",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 13)),
                    ]),
                //空闲时间
                Padding(
                  padding: EdgeInsets.all(2.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(width: 20),
                        Icon(
                          Icons.fiber_manual_record,
                          color: Colors.blue,
                          size: 16.0,
                        ),
                        SizedBox(width: 0),
                        FlatButton(
                          child: new Text(_start),
                          onPressed: () {
                            showTimePicker(
                              context: context,
                              initialTime: new TimeOfDay.now(),
                            ).then((val) {
                              setState(() {
                                _start = val.format(context);
                              });
                            }).catchError((err) {
                              print(err);
                            });
                          },
                        ),
                        SizedBox(width: 30),
                        Icon(
                          Icons.fiber_manual_record,
                          color: Colors.redAccent,
                          size: 16.0,
                        ),
                        SizedBox(width: 0),
                        FlatButton(
                          child: new Text(_end),
                          onPressed: () {
                            showTimePicker(
                              context: context,
                              initialTime: new TimeOfDay.now(),
                            ).then((val) {
                              setState(() {
                                _end = val.format(context);
                              });
                            }).catchError((err) {
                              print(err);
                            });
                          },
                        ),
                      ]),
                ),
                SizedBox(height: 5.0),
                //联系方式
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(width: 2.0),
                      Text("▌",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.orangeAccent)),
                      SizedBox(width: 10.0),
                      Text("联系方式",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 13)),
                    ]),
                SizedBox(height: 10.0),
                //联系方式
                Padding(
                  padding: EdgeInsets.all(2.0),
                  child: Row(children: <Widget>[
                    Icon(
                      Icons.call,
                      color: Colors.black45,
                      size: 20.0,
                    ),
                    SizedBox(width: 20),
                    Container(
                      width: 260.0,
                      child: TextField(
                        controller: _phoneNumberEditingController,
                        keyboardType: TextInputType.text,
                        decoration: new InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.pinkAccent, width: 2)),
                            labelStyle:
                                TextStyle(color: Colors.grey, fontSize: 14),
                            contentPadding: const EdgeInsets.all(10.0),
                            labelText: "你的手机号、QQ、微信..."),
                      ),
                    )
                  ]),
                ),
                SizedBox(height: 10.0),
                //备注
                Padding(
                  padding: EdgeInsets.only(top: 20.0, left: 2.0),
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
                          child: TextField(
                            maxLines: 3,
                            controller: _detailEditingController,
                            keyboardType: TextInputType.text,
                            decoration: new InputDecoration(
                                contentPadding: const EdgeInsets.all(10.0),
                                hintText: '说点什么吧...',
                                hintStyle:
                                    TextStyle(color: Colors.grey, fontSize: 14),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.blue,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.blue,
                                  ),
                                )),
                          ),
                        )
                      ]),
                ),
              ],
              // ),
            ),
            SizedBox(height: 20),
          ],
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white70,
          ),
          height: 50,
          child: Row(children: <Widget>[
            Expanded(
              flex: 2,
              child: GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      child: new AlertDialog(
                        title: Text(
                          "跑腿费",
                          style: TextStyle(color: Colors.black),
                        ),
                        content: TextField(
                          controller: _priceEditingController,
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
                          decoration: new InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.pinkAccent, width: 2)),
                              labelStyle: TextStyle(color: Colors.grey),
                              contentPadding: const EdgeInsets.all(10.0),
                              icon: new Icon(
                                Icons.payment,
                                color: Colors.orangeAccent,
                                size: 20.0,
                              ),
                              labelText: "请输入你的起步价..."),
                        ),
                        actions: <Widget>[
                          FlatButton(
                              onPressed: () {
                                setState(() {
                                  _price = _priceEditingController.value.text
                                              .toString() ==
                                          ''
                                      ? '0'
                                      : _priceEditingController.value.text
                                          .toString();
                                });
                                Navigator.of(context).pop();
                              },
                              child: Text("确定")),
                        ],
                      ));
                },
                child: Center(
                  child: Text(
                    '起步价：￥${_price}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.red),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Builder(builder: (BuildContext context) {
                return Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.orangeAccent,
                  ),
                  child: RaisedButton(
                    color: Colors.lightBlue,
                    onPressed: () {
                      _addNewHelper(context);
                    },
                    child: Text(
                      "发布信息",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                );
              }),
            ),
          ]),
        ));
  }

  void _addNewHelper(BuildContext context) async {
    HelperEntity helperEntity = HelperEntity();
    if (await PlatFormUtil.callNativeApp(PlatFormUtil.IS_VISITOR)) {
      Scaffold.of(context).showSnackBar(new SnackBar(
        content: new Text(
          "尚未登陆...",
          style: TextStyle(color: Colors.white),
        ),
      ));
      return;
    }
    if (UserCache.user != null) {
      helperEntity.user = UserCache.user;
      String _helperType = _titleEditingController.value.text.toString();
      String _wheret = _whereEditingController.value.text.toString();
      if (_helperType.length <= 0 || _wheret.length <= 0) {
        showDialog(
            context: context,
            child: new AlertDialog(
              title: Text(
                "信息不完善",
                style: TextStyle(color: Colors.red),
              ),
              content: Text("请输入你的标题或位置..."),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("确定")),
              ],
            ));
      } else {
        helperEntity.price = _price;
        helperEntity.start = _start;
        helperEntity.end = _end;
        helperEntity.title = _titleEditingController.value.text.toString();
        helperEntity.detail = _detailEditingController.value.text.toString();
        helperEntity.phoneNumber =
            _phoneNumberEditingController.value.text.toString();
        helperEntity.where = _whereEditingController.value.text.toString();
        helperEntity.save().then((BmobSaved data) {
          if (data.objectId != null) {
            Navigator.of(context).pop("success");
            Scaffold.of(context).showSnackBar(new SnackBar(
              content: new Text("发布成功... "),
            ));
          }
        }).catchError((error) {});
      }
    } else {
      Scaffold.of(context).showSnackBar(new SnackBar(
        content: new Text(
          "获取用户信息失败，请重新登录",
          style: TextStyle(color: Colors.redAccent),
        ),
      ));
    }
  }
}
