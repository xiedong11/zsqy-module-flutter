import 'package:data_plugin/bmob/response/bmob_saved.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/entity/order_entity.dart';
import 'package:flutter_app/utils/user_cache.dart';

int type = 0;

class NewOrder extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PageState();
}

class PageState extends State<NewOrder> {
  TextEditingController _titleEditingController = TextEditingController();
  TextEditingController _phoneNumberEditingController = TextEditingController();
  TextEditingController _priceEditingController = TextEditingController();
  TextEditingController _detailEditingController = TextEditingController();
  TextEditingController _fromEditingController = TextEditingController();
  TextEditingController _destinationEditingController = TextEditingController();

  String _price = '0';

  static List<TypeItemEntity> _typeList = [
    TypeItemEntity("取快递", 0),
    TypeItemEntity("送礼物", 1),
    TypeItemEntity("帮买饭", 2),
    TypeItemEntity("替上课", 3),
    TypeItemEntity("陪聊天", 4),
    TypeItemEntity("其他", 5),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("发布新单"),
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
                      color: Colors.orangeAccent,
                      size: 20.0,
                    ),
                    SizedBox(width: 20),
                    Container(
                      width: 260.0,
                      child: TextField(
                        controller: _titleEditingController,
                        keyboardType: TextInputType.text,
                        decoration: new InputDecoration(
                            contentPadding: const EdgeInsets.all(10.0),
                            labelText: "请输入任务标题..."),
                        onChanged: (String str) {
                          if (str.length == 35) {
                            showDialog(
                                context: context,
                                child: new AlertDialog(
                                  title: Text(
                                    "标题字数已达上限",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  content: Text("建议任务标题控制在35字以内，超出部分首页将不再显示。",
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
                //任务类型
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
                      Text("任务类型",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.orangeAccent))
                    ]),
                TypeItemWidget(_typeList),
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
                      child: TextField(
                        controller: _fromEditingController,
                        keyboardType: TextInputType.text,
                        decoration: new InputDecoration(
                            contentPadding: const EdgeInsets.all(10.0),
                            labelText: "任务的起始位置..."),
                      ),
                    )
                  ]),
                ),
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
                      child: TextField(
                        controller: _destinationEditingController,
                        keyboardType: TextInputType.text,
                        decoration: new InputDecoration(
                            contentPadding: const EdgeInsets.all(10.0),
                            labelText: "任务的终止位置..."),
                      ),
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
                      child: TextField(
                        controller: _phoneNumberEditingController,
                        keyboardType: TextInputType.text,
                        decoration: new InputDecoration(
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
                                hintText: '备注：任务详细内容...',
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
                              contentPadding: const EdgeInsets.all(10.0),
                              icon: new Icon(
                                Icons.payment,
                                color: Colors.orangeAccent,
                                size: 20.0,
                              ),
                              labelText: "你要给跑腿员的小费..."),
                        ),
                        actions: <Widget>[
                          FlatButton(
                              onPressed: () {
                                setState(() {
                                  _price = _priceEditingController.value.text.toString() ==''
                                      ? '0'
                                      : _priceEditingController.value.text.toString();
                                });
                                Navigator.of(context).pop();
                              },
                              child: Text("确定")),
                        ],
                      ));
                },
                child: Center(
                  child: Text(
                    '小费：￥${_price}',
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
                    color: Colors.orangeAccent,
                    onPressed: () {
                      _addNewOrder(context);
                    },
                    child: Text(
                      "发布任务",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                );
              }),
            ),
          ]),
        ));
  }

  void _addNewOrder(BuildContext context) {
    OrderEntity orderEntity = OrderEntity();
    if (UserCache.user != null) {
      orderEntity.user = UserCache.user;
      String _orderType = _titleEditingController.value.text.toString();
      if (_orderType.length <= 0) {
        showDialog(
            context: context,
            child: new AlertDialog(
              title: Text(
                "信息不完善",
                style: TextStyle(color: Colors.red),
              ),
              content: Text("请输入要下单的内容..."),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("确定")),
              ],
            ));
      } else {
        orderEntity.title = _titleEditingController.value.text.toString();
        orderEntity.price = _priceEditingController.value.text.toString();
        orderEntity.from = _fromEditingController.value.text.toString();
        orderEntity.detail = _detailEditingController.value.text.toString();
        orderEntity.destination =
            _destinationEditingController.value.text.toString();
        orderEntity.phoneNumber =
            _phoneNumberEditingController.value.text.toString();
        orderEntity.type = _typeList[type].title;
        orderEntity.save().then((BmobSaved data) {
          if (data.objectId != null) {
            print(data.toString() + "-------------------------");
            Navigator.of(context).pop();
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

class TypeItemEntity {
  String title;
  int index;

  TypeItemEntity(this.title, this.index);
}

class TypeItemWidget extends StatefulWidget {
  List<TypeItemEntity> _typeItemEntity;

  TypeItemWidget(this._typeItemEntity);

  @override
  State<StatefulWidget> createState() {
    return TypeItemWidgetState();
  }
}

class TypeItemWidgetState extends State<TypeItemWidget> {
  var _selectedStyle = BoxDecoration(
      color: Colors.orangeAccent,
      borderRadius: BorderRadius.all(Radius.circular(5.0)));
  var _normalStyle = BoxDecoration(
      color: Colors.black12,
      borderRadius: BorderRadius.all(Radius.circular(5.0)));
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.all(20.0),
      // padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 10.0,
        childAspectRatio: 2.0,
        crossAxisSpacing: 10.0,
      ),
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          child: Container(
            alignment: Alignment.center,
            decoration: widget._typeItemEntity[index].index == _currentIndex
                ? _selectedStyle
                : _normalStyle,
            child: GestureDetector(
              child: Text(widget._typeItemEntity[index].title),
            ),
          ),
          onTap: () {
            this.setState(() {
              _currentIndex = widget._typeItemEntity[index].index;
              type = widget._typeItemEntity[index].index;
            });
          },
        );
      },
      itemCount: widget._typeItemEntity.length,
    );
  }
}
