import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';

import 'dependency/http.dart';
import 'dependency/public.dart';
import 'dependency/course_entity.dart';
import 'dependency/cancel_result.dart';

////////////////////////////////////////
//使用 SelectCourse(学号,密码,Cookie) 调用此页,可直接传入登陆后的Cookie字符串保持登录状态（cookie可为空字符串''）
//例如 SelectCourse('2017666666','mypassword','sto-id-20480=CBLMMCMKFAAA; JSESSIONID=B980039E38AFC8C071BF30C788E23F89')
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class SelectCourse extends StatefulWidget {
  String USER;
  String PASS;
  String COOKIE;
  String SERVER = 'http://zhjw.qfnu.edu.cn';

  SelectCourse(this.USER,this.PASS,this.COOKIE);
  
  @override
  _SelectCourseState createState() => _SelectCourseState(this.USER,this.PASS,this.SERVER,this.COOKIE);
}

class _SelectCourseState extends State<SelectCourse> {
  String USER;
  String PASS;
  String SERVER;
  String COOKIE;
  _SelectCourseState(this.USER,this.PASS,this.SERVER,this.COOKIE);
  ///////////////////////////////////////////////////////////////////////////
  Http http = Http();
  bool ZY = false;
  String JX0502ZBID = '';
  List<Widget> _listWidget = List<Widget>();
  bool _blank = true; //查询结果为空
  bool _login = false; //是否登录成功
  int where = 0; //c初始选课查询类型
  var _title = '跨专业/计划外选课'; //顶部标题
  var _blankWord = '💡提示：点击右上角↗开始选课';
  ///////////////////////////////////////////////////////////////////////////
  var CHECKS = {
    'sEcho': 1,
    'iColumns': 12,
    'sColumns': '',
    'iDisplayStart': 0,
    'iDisplayLength': 100, //返回数据长度
    'mDataProp_0': 'kch',
    'mDataProp_1': 'kcmc',
    'mDataProp_2': 'fzmc',
    'mDataProp_3': 'xf',
    'mDataProp_4': 'skls',
    'mDataProp_5': 'sksj',
    'mDataProp_6': 'skdd',
    'mDataProp_7': 'xqmc',
    'mDataProp_8': 'xkrs',
    'mDataProp_9': 'syrs',
    'mDataProp_10': 'ctsm',
    'mDataProp_11': 'czOper',
  };
  ///////////////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppbar(),
      body: Container(
        decoration: BoxDecoration(
          color: _blank ? Colors.white : Color.fromRGBO(244, 244, 244, 1),
        ),
        child: _blank ? blankPage() : _createListView()
      ),
    );
  }

  Widget myAppbar() {
    return AppBar(
      title: Text( _title, style: TextStyle(fontSize: 20)),
      backgroundColor: Colors.blue,
      centerTitle: true,
      actions: <Widget>[
        IconButton(
            icon: Icon(Icons.delete_outline),
            onPressed: () async {
              if(_login){
                Navigator.push( context,  MaterialPageRoute(  builder: (_) => CancelResult(SERVER + JX0502ZBID, '选课结果与退选', USER, PASS, SERVER,COOKIE)));
              } else{
                await myTips(context, '注意', '请先点击右上角🔍登录。');
              }
            }),
        Builder(builder: (BuildContext context) {
          return IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              if(_login){
                searchx(context);
              }else{
                await startLogin(context);
              }
            });
          }
        ),
      ]);
  }

  Widget blankPage() {
    return ListView(children: <Widget>[
      SizedBox( height: 100.0 ),
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox( height: 20 ),
            Image(
              image: AssetImage("lib/img/blank.png"),
              width: 250.0,
            ),
            SizedBox( height: 50 ),
            Text(_blankWord, style: TextStyle(color: Colors.black54, fontSize: 18)),
            SizedBox( height: 20 ),
          ],
        ))
    ]);
  }

  // 创建ListView
  Widget _createListView() {
    return ListView.builder(
      itemCount: _listWidget.length,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO(244, 244, 244, 1),
          ),
          // Key
          key: Key('keyx${index}'),
          // Child
          child: _listWidget[index]);
      },
    );
  }

  ///////////////////////////////////////////////////////////////////////////

  Future xQurey(context,kcxx, skls, skxq, skjc) async {
    if (!_login) {
      await myTips(context, '注意', '当前暂时无法查询课程，请稍后再试！');
      return null;
    }
    var key = keyQuery(kcxx, skls, skxq, skjc);
    var result = await query(where,key,http,SERVER,CHECKS);
    if (result.contains("请求失败")) {
      await myTips(context, '注意', '网络异常，错误代码0x004'); //查询请求失败
      return null;
    }
    if (!result.contains("sEcho")) {
      await myTips(context, '注意', '数据异常，错误代码0x005'); //查询数据异常
      return null;
    }
    var courses = Courses.fromJson(jsonDecode(result)).aaData;
    _listWidget = [];//清空原来的课程
    if (courses.length > 0) {
      //添加课程信息
      for (var course in courses) {
        addWidget(course);
      }
      setState(() {
        _blank = false;
      });
    } else {
      //显示查询为空
      setState(() {
        _blank = true;
        _blankWord = "此课限选、冲突或课余量为零:(";
      });
    }
    setState(() {});//刷新界面
  }

  Future xSubmit(context,kcxx, kcid, cfbs, jx0404id, xkzy) async {
    var oper = keyOper(kcid, cfbs, jx0404id, xkzy);
    var verifyCode = await yzmXk(context,http,SERVER);//需要验证码
    oper=oper+verifyCode;
    dynamic result = await submit(where,oper,http,SERVER);
    if (result.contains("请求失败")) {
      await myTips(context, '注意', '网络异常，错误代码0x006'); //提交请求失败
    }
    if (!result.contains("success")) {
      await myTips(context, '注意', '数据异常，错误代码0x007'); //提交数据异常
    }
    result = jsonDecode(result);
    if (result['message'].contains('成功')) {
      await myTips(context, kcxx, '选课成功^_^');
    } else {
      await myTips(context, kcxx, result['message']);
    }
  }

  Future startLogin(context) async {
    await mySnackbar(context, '正在登陆，请稍候~~~');
    if(COOKIE.length>10){
      http.dio.options.headers['Cookie']=COOKIE;
    }
    dynamic result = await startLoginX(context,http,SERVER,USER,PASS,'/jsxsd/framework/xsMain.jsp');
    if (result) { //允许开始查询请求
      await mySnackbar(context, '登陆成功！≧▽≦');
      result = await http.get(SERVER + "/jsxsd/xsxk/xklc_list");
      if (result.contains("请求失败")) {
        await myTips(context, '注意', '网络异常，错误代码0x002'); //查询选课开始请求失败
      }
      if (!result.contains('学生选课')) {
        await myTips(context, '注意', '数据异常，错误代码0x003'); //查询选课开始请求返回异常数据
      }
      var key = RegExp('href="(.+)" target="blank">进入选课').stringMatch(result);
      if (key != null) {
        JX0502ZBID = key.substring(6, 72);
        if (result.contains("志愿抽签")) {
          ZY = true;
        }
        await http.get(SERVER + JX0502ZBID);//请求选课主页，获取选课权！
        await myTips(context, '提示', '现在可以开始选课了:)');
        _login = true;
        searchx(context);
      } else {
        await myTips(context, '注意', '现在选课尚未开始！');
      }
    } else {
      await mySnackbar(context, '登陆失败，请退出重试:(');
    }
  }

  /////////////////////////////////////////////////////////////////////////

  //加工可选课程列表
  void addWidget(course) async {
    var kch, xqmc, kcmc, skls, xf, skdd, sksj, syrs;
    var kcid, cfbs, jx0404id, xkzy;
    cfbs = course.cfbs.toString();
    kcid = course.jx02id.toString();
    jx0404id = course.jx0404id.toString();
    xf = course.xf.toString();
    kch = course.kch.toString();
    sksj = course.sksj.toString();
    xqmc = course.xqmc.toString();
    kcmc = course.kcmc.toString();
    skls = course.skls.toString();
    skdd = course.skdd.toString();
    syrs = course.syrs.toString();
    var item = Container(
        margin: const EdgeInsets.all(8.0),
        child: DecoratedBox(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                    color: Colors.white,
                    offset: Offset(0.0, 2.0),
                    blurRadius: 8.0,
                    spreadRadius: 0.0),
              ]),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: InkWell(
              onTap: () async {
                //点击选课
                await xSubmit(context,kcmc, kcid, cfbs, jx0404id, xkzy);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          kcmc + '($skls)',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        '剩余量:$syrs',
                        style: TextStyle(fontSize: 14, color: Colors.red),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    !sksj.contains('nbsp') ? (xqmc + skdd + ' ' + sksj) : '',
                    style: TextStyle(fontSize: 12, color: Colors.black45),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Theme(
                    // 修改button默认的最小宽度与padding
                    data: Theme.of(context).copyWith(
                      buttonTheme: ButtonThemeData(
                          padding: const EdgeInsets.symmetric(horizontal: 14.0),
                          minWidth: 64.0,
                          height: 30.0,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap, // 距顶部距离为0
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          )),
                      textTheme: TextTheme(
                          button: TextStyle(
                        fontSize: 14,
                      )),
                    ),
                    child: Row(
                      children: <Widget>[
                        FlatButton(
                          color: Color.fromRGBO(244, 244, 244, 1),
                          child: Text('课程号:' + kch),
                          onPressed: () {},
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        FlatButton(
                          color: Color.fromRGBO(244, 244, 244, 1),
                          child: Text(xf + '学分'),
                          onPressed: () {},
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 0,
                          ),
                        ),
                        FlatButton(
                          color: Colors.blue,
                          textColor: Colors.white,
                          onPressed: () async {
                            await xSubmit(context,kcmc, kcid, cfbs, jx0404id, xkzy);
                          },
                          child: Text('选课'),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
    _listWidget.add(item);
  }

  //弹出选课查询搜索框
  void searchx(context){
    TextEditingController _kcxxEditingController = TextEditingController();
    TextEditingController _sklsEditingController = TextEditingController();
    var _kcxx = '', _skls = '', _skxq = '', _skjc = '';
    bool type0 = false,
        type1 = false,
        type2 = false,
        type3 = false,
        type4 = false,
        type5 = false;
    var _xq11 = false,
        _xq12 = false,
        _xq13 = false,
        _xq14 = false,
        _xq15 = false,
        _xq16 = false,
        _xq17 = false;
    var _jc11 = false,
        _jc12 = false,
        _jc13 = false,
        _jc14 = false,
        _jc15 = false;
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return MyDialogx(
            title: "搜索课程",
            onPressed: () async {
              _kcxx = _kcxxEditingController.value.text.toString();
              _skls = _sklsEditingController.value.text.toString();
              if (_skxq == '' && _skjc != '') {
                await myTips(context, '注意', '选课‘节次’查询时，必须选择‘星期’组合一起查询！');
              } else {
                await xQurey(context,_kcxx, _skls, _skxq, _skjc);
                Navigator.of(context).pop();
              }
            },
            heightx: 300,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: ListView(children: <Widget>[
                //课程信息1
                Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Row(children: <Widget>[
                    Icon(
                      Icons.info_outline,
                      color: Colors.black45,
                      size: 20.0,
                    ),
                    SizedBox(width: 20),
                    Container(
                      height: 40,
                      width: 180.0,
                      child: TextField(
                        controller: _kcxxEditingController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(10.0),
                            hintText: '课程名称或课程号...',
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
                //上课老师1
                Padding(
                  padding: EdgeInsets.only(
                      left: 20.0, right: 20.0, top: 20.0, bottom: 20.0),
                  child: Row(children: <Widget>[
                    Icon(
                      Icons.flash_on,
                      color: Colors.black45,
                      size: 20.0,
                    ),
                    SizedBox(width: 20),
                    Container(
                      height: 40,
                      width: 180.0,
                      child: TextField(
                        controller: _sklsEditingController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(10.0),
                            hintText: '上课老师（默认为空）...',
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
                SizedBox(height: 0.0),
                //选课类型
                MaterialButton(
                    height: 45,
                    elevation: 0.0,
                    color: Color.fromRGBO(244, 244, 244, 1),
                    textColor: Colors.white,
                    child: Text(
                      '选课类型',
                      style: TextStyle(color: Colors.black45),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    onPressed: () async {
                      await showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return StatefulBuilder(
                                builder: (context, setState) {
                              return Stack(children: <Widget>[
                                Container(
                                  height: 20,
                                  width: double.infinity,
                                  color: Colors.black54,
                                ),
                                Container(
                                  height: 20,
                                  width: double.infinity,
                                  color: Colors.black54,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                    ),
                                  ),
                                  child: ListView(
                                    children: <Widget>[
                                      SizedBox(
                                        height: 10,
                                      ),
                                      CheckboxListTile(
                                        secondary: const Icon(
                                          Icons.trip_origin,
                                          color: Colors.lightBlue,
                                        ),
                                        title: const Text('跨专业/计划外选课'),
                                        value: type0,
                                        onChanged: (bool value) {
                                          setState(() {
                                            type0 = value;
                                            if (value) {
                                              type1 = false;
                                              type2 = false;
                                              type3 = false;
                                              type4 = false;
                                              type5 = false;
                                              where = 0;
                                              _title = '跨专业/计划外选课';
                                            } else {
                                              where = 0;
                                              _title = '跨专业/计划外选课';
                                            }
                                          });
                                        },
                                      ),
                                      CheckboxListTile(
                                        secondary: const Icon(
                                          Icons.trip_origin,
                                          color: Colors.lightBlue,
                                        ),
                                        title: const Text('公选课选课'),
                                        value: type2,
                                        onChanged: (bool value) {
                                          setState(() {
                                            type2 = value;
                                            if (value) {
                                              type1 = false;
                                              type0 = false;
                                              type3 = false;
                                              type4 = false;
                                              type5 = false;
                                              where = 2;
                                              _title = '公选课选课';
                                            } else {
                                              where = 0;
                                              _title = '跨专业/计划外选课';
                                            }
                                          });
                                        },
                                      ),
                                      CheckboxListTile(
                                        secondary: const Icon(
                                          Icons.trip_origin,
                                          color: Colors.lightBlue,
                                        ),
                                        title: const Text('本学期计划选课'),
                                        value: type1,
                                        onChanged: (bool value) {
                                          setState(() {
                                            type1 = value;
                                            if (value) {
                                              type0 = false;
                                              type2 = false;
                                              type3 = false;
                                              type4 = false;
                                              type5 = false;
                                              where = 1;
                                              _title = '本学期计划选课';
                                            } else {
                                              where = 0;
                                              _title = '跨专业/计划外选课';
                                            }
                                          });
                                        },
                                      ),
                                      CheckboxListTile(
                                        secondary: const Icon(
                                          Icons.trip_origin,
                                          color: Colors.lightBlue,
                                        ),
                                        title: const Text('必修选课'),
                                        value: type3,
                                        onChanged: (bool value) {
                                          setState(() {
                                            type3 = value;
                                            if (value) {
                                              type1 = false;
                                              type1 = false;
                                              type2 = false;
                                              type0 = false;
                                              type4 = false;
                                              type5 = false;
                                              where = 0;
                                              _title = '必修选课';
                                            } else {
                                              where = 0;
                                              _title = '跨专业/计划外选课';
                                            }
                                          });
                                        },
                                      ),
                                      CheckboxListTile(
                                        secondary: const Icon(
                                          Icons.trip_origin,
                                          color: Colors.lightBlue,
                                        ),
                                        title: const Text('选修选课'),
                                        value: type4,
                                        onChanged: (bool value) {
                                          setState(() {
                                            type4 = value;
                                            if (value) {
                                              type1 = false;
                                              type2 = false;
                                              type3 = false;
                                              type0 = false;
                                              type5 = false;
                                              where = 0;
                                              _title = '选修选课';
                                            } else {
                                              where = 0;
                                              _title = '跨专业/计划外选课';
                                            }
                                          });
                                        },
                                      ),
                                      CheckboxListTile(
                                        secondary: const Icon(
                                          Icons.trip_origin,
                                          color: Colors.lightBlue,
                                        ),
                                        title: const Text('专业内跨年级选课'),
                                        value: type5,
                                        onChanged: (bool value) {
                                          setState(() {
                                            type5 = value;
                                            if (value) {
                                              type1 = false;
                                              type2 = false;
                                              type0 = false;
                                              type4 = false;
                                              type3 = false;
                                              where = 5;
                                              _title = '专业内跨年级选课';
                                            } else {
                                              where = 0;
                                              _title = '跨专业/计划外选课';
                                            }
                                          });
                                        },
                                      ),
                                      SizedBox(
                                        height: 14,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white70,
                                        ),
                                        child: Row(children: <Widget>[
                                          Expanded(
                                            child: Builder(builder:
                                                (BuildContext context) {
                                              return Container(
                                                height: 50,
                                                child: RaisedButton(
                                                  color: Colors.lightBlue,
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    "确定",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              );
                                            }),
                                          ),
                                        ]),
                                      ),
                                    ],
                                  ),
                                ),
                              ]);
                            });
                          });
                      setState(() {
                        where = where;
                      });
                    }),
                SizedBox(height: 10.0),
                //上课星期1
                MaterialButton(
                    height: 45,
                    elevation: 0.0,
                    color: Color.fromRGBO(237, 210, 201, 1),
                    textColor: Colors.white,
                    child: Text(
                      '上课星期',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    onPressed: () async {
                      await showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return StatefulBuilder(
                                builder: (context, setState) {
                              return Stack(children: <Widget>[
                                Container(
                                  height: 20,
                                  width: double.infinity,
                                  color: Colors.black54,
                                ),
                                Container(
                                  height: 20,
                                  width: double.infinity,
                                  color: Colors.black54,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                    ),
                                  ),
                                  child: ListView(
                                    children: <Widget>[
                                      CheckboxListTile(
                                        secondary: const Icon(
                                          Icons.trip_origin,
                                          color: Colors.lightBlue,
                                        ),
                                        title: const Text('星期一'),
                                        value: _xq11,
                                        onChanged: (bool value) {
                                          setState(() {
                                            _xq11 = value;
                                            if (value) {
                                              _xq12 = false;
                                              _xq13 = false;
                                              _xq14 = false;
                                              _xq15 = false;
                                              _xq16 = false;
                                              _xq17 = false;
                                              _skxq = '1';
                                            } else {
                                              _skxq = '';
                                            }
                                          });
                                        },
                                      ),
                                      CheckboxListTile(
                                        secondary: const Icon(
                                          Icons.trip_origin,
                                          color: Colors.lightBlue,
                                        ),
                                        title: const Text('星期二'),
                                        value: _xq12,
                                        onChanged: (bool value) {
                                          setState(() {
                                            _xq12 = value;
                                          });
                                          if (value) {
                                            _xq11 = false;
                                            _xq13 = false;
                                            _xq14 = false;
                                            _xq15 = false;
                                            _xq16 = false;
                                            _xq17 = false;
                                            _skxq = '2';
                                          } else {
                                            _skxq = '';
                                          }
                                        },
                                      ),
                                      CheckboxListTile(
                                        secondary: const Icon(
                                          Icons.trip_origin,
                                          color: Colors.lightBlue,
                                        ),
                                        title: const Text('星期三'),
                                        value: _xq13,
                                        onChanged: (bool value) {
                                          setState(() {
                                            _xq13 = value;
                                          });
                                          if (value) {
                                            _xq12 = false;
                                            _xq11 = false;
                                            _xq14 = false;
                                            _xq15 = false;
                                            _xq16 = false;
                                            _xq17 = false;
                                            _skxq = '3';
                                          } else {
                                            _skxq = '';
                                          }
                                        },
                                      ),
                                      CheckboxListTile(
                                        secondary: const Icon(
                                          Icons.trip_origin,
                                          color: Colors.lightBlue,
                                        ),
                                        title: const Text('星期四'),
                                        value: _xq14,
                                        onChanged: (bool value) {
                                          setState(() {
                                            _xq14 = value;
                                          });
                                          if (value) {
                                            _xq12 = false;
                                            _xq13 = false;
                                            _xq11 = false;
                                            _xq15 = false;
                                            _xq16 = false;
                                            _xq17 = false;
                                            _skxq = '4';
                                          } else {
                                            _skxq = '';
                                          }
                                        },
                                      ),
                                      CheckboxListTile(
                                        secondary: const Icon(
                                          Icons.trip_origin,
                                          color: Colors.lightBlue,
                                        ),
                                        title: const Text('星期五'),
                                        value: _xq15,
                                        onChanged: (bool value) {
                                          setState(() {
                                            _xq15 = value;
                                          });
                                          if (value) {
                                            _xq12 = false;
                                            _xq13 = false;
                                            _xq14 = false;
                                            _xq11 = false;
                                            _xq16 = false;
                                            _xq17 = false;
                                            _skxq = '5';
                                          } else {
                                            _skxq = '';
                                          }
                                        },
                                      ),
                                      CheckboxListTile(
                                        secondary: const Icon(
                                          Icons.trip_origin,
                                          color: Colors.lightBlue,
                                        ),
                                        title: const Text('星期六'),
                                        value: _xq16,
                                        onChanged: (bool value) {
                                          setState(() {
                                            _xq16 = value;
                                          });
                                          if (value) {
                                            _xq12 = false;
                                            _xq13 = false;
                                            _xq14 = false;
                                            _xq15 = false;
                                            _xq11 = false;
                                            _xq17 = false;
                                            _skxq = '6';
                                          } else {
                                            _skxq = '';
                                          }
                                        },
                                      ),
                                      CheckboxListTile(
                                        secondary: const Icon(
                                          Icons.trip_origin,
                                          color: Colors.lightBlue,
                                        ),
                                        title: const Text('星期日'),
                                        value: _xq17,
                                        onChanged: (bool value) {
                                          setState(() {
                                            _xq17 = value;
                                          });
                                          if (value) {
                                            _xq12 = false;
                                            _xq13 = false;
                                            _xq14 = false;
                                            _xq15 = false;
                                            _xq16 = false;
                                            _xq11 = false;
                                            _skxq = '7';
                                          } else {
                                            _skxq = '';
                                          }
                                        },
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white70,
                                        ),
                                        height: 50,
                                        child: Row(children: <Widget>[
                                          Expanded(
                                            child: Builder(builder:
                                                (BuildContext context) {
                                              return Container(
                                                height: 50,
                                                child: RaisedButton(
                                                  color: Colors.lightBlue,
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    "确定",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              );
                                            }),
                                          ),
                                        ]),
                                      ),
                                    ],
                                  ),
                                ),
                              ]);
                            });
                          });
                      setState(() {
                        _skxq = _skxq;
                      });
                    }),
                SizedBox(height: 10.0),
                //上课节次1
                MaterialButton(
                    height: 45,
                    elevation: 0.0,
                    color: Color.fromRGBO(255, 183, 223, 1),
                    textColor: Colors.white,
                    child: Text(
                      '上课节次',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    onPressed: () async {
                      await showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return StatefulBuilder(
                                builder: (context, setState) {
                              return Stack(children: <Widget>[
                                Container(
                                  height: 20,
                                  width: double.infinity,
                                  color: Colors.black54,
                                ),
                                Container(
                                  height: 20,
                                  width: double.infinity,
                                  color: Colors.black54,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                    ),
                                  ),
                                  child: ListView(
                                    children: <Widget>[
                                      SizedBox(
                                        height: 20,
                                      ),
                                      CheckboxListTile(
                                        secondary: const Icon(
                                          Icons.shutter_speed,
                                          color:
                                              Color.fromRGBO(255, 255, 255, 0),
                                        ),
                                        title: const Text('第一大节'),
                                        value: _jc11,
                                        onChanged: (bool value) {
                                          setState(() {
                                            _jc11 = value;
                                            if (value) {
                                              _jc12 = false;
                                              _jc13 = false;
                                              _jc14 = false;
                                              _jc15 = false;
                                              _skjc = '1-2-';
                                            } else {
                                              _skjc = '';
                                            }
                                          });
                                        },
                                      ),
                                      CheckboxListTile(
                                        secondary: const Icon(
                                          Icons.shutter_speed,
                                          color:
                                              Color.fromRGBO(255, 255, 255, 0),
                                        ),
                                        title: const Text('第二大节'),
                                        value: _jc12,
                                        onChanged: (bool value) {
                                          setState(() {
                                            _jc12 = value;
                                          });
                                          if (value) {
                                            _jc11 = false;
                                            _jc13 = false;
                                            _jc14 = false;
                                            _jc15 = false;
                                            _skjc = '3-4-';
                                          } else {
                                            _skjc = '';
                                          }
                                        },
                                      ),
                                      CheckboxListTile(
                                        secondary: const Icon(
                                          Icons.shutter_speed,
                                          color:
                                              Color.fromRGBO(255, 255, 255, 0),
                                        ),
                                        title: const Text('第三大节'),
                                        value: _jc13,
                                        onChanged: (bool value) {
                                          setState(() {
                                            _jc13 = value;
                                          });
                                          if (value) {
                                            _jc12 = false;
                                            _jc11 = false;
                                            _jc14 = false;
                                            _jc15 = false;
                                            _skjc = '5-6-';
                                          } else {
                                            _skjc = '';
                                          }
                                        },
                                      ),
                                      CheckboxListTile(
                                        secondary: const Icon(
                                          Icons.shutter_speed,
                                          color:
                                              Color.fromRGBO(255, 255, 255, 0),
                                        ),
                                        title: const Text('第四大节'),
                                        value: _jc14,
                                        onChanged: (bool value) {
                                          setState(() {
                                            _jc14 = value;
                                          });
                                          if (value) {
                                            _jc12 = false;
                                            _jc13 = false;
                                            _jc11 = false;
                                            _jc15 = false;
                                            _skjc = '7-8-';
                                          } else {
                                            _skjc = '';
                                          }
                                        },
                                      ),
                                      CheckboxListTile(
                                        secondary: const Icon(
                                          Icons.shutter_speed,
                                          color:
                                              Color.fromRGBO(255, 255, 255, 0),
                                        ),
                                        title: const Text('第五大节'),
                                        value: _jc15,
                                        onChanged: (bool value) {
                                          setState(() {
                                            _jc15 = value;
                                          });
                                          if (value) {
                                            _jc12 = false;
                                            _jc13 = false;
                                            _jc14 = false;
                                            _jc11 = false;
                                            _skjc = '9-10-11';
                                          } else {
                                            _skjc = '';
                                          }
                                        },
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white70,
                                        ),
                                        height: 50,
                                        child: Row(children: <Widget>[
                                          Expanded(
                                            child: Builder(builder:
                                                (BuildContext context) {
                                              return Container(
                                                height: 50,
                                                child: RaisedButton(
                                                  color: Colors.lightBlue,
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    "确定",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              );
                                            }),
                                          ),
                                        ]),
                                      ),
                                    ],
                                  ),
                                ),
                              ]);
                            });
                          });
                      setState(() {});
                    }),
              ]),
            ),
          );
        });
  }
}
