import 'dart:convert';//base64
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

String keyQuery(kcxx, skls, skxq, skjc) =>
    '?kcxx=' +
    Uri.encodeComponent(
        Uri.encodeComponent((kcxx == 'null' || kcxx == null) ? '' : kcxx)) +
    '&skls=' +
    Uri.encodeComponent(
        Uri.encodeComponent((skls == 'null' || skls == null) ? '' : skls)) +
    '&skxq=' +
    ((skxq == 'null' || skxq == null) ? '' : skxq) +
    '&skjc=' +
    ((skjc == 'null' || skjc == null) ? '' : skjc) +
    '&sfym=true&sfct=true&sfxx=true';

String keyOper(kcid, cfbs, jx0404id, xkzy) =>
    '?kcid=' +
    kcid.toString() +
    '&cfbs=' +
    cfbs.toString() +
    '&jx0404id=' +
    jx0404id.toString() +
    '&xkzy=' +
    xkzy.toString() +
    '&trjf=&verifyCode=';

Future<String> query(where,check,http,server,checks) async {
  dynamic result;
  switch (where) {
    case 0:
      result = await http.post(server + '/jsxsd/xsxkkc/xsxkFawxk' + check, data: checks); break;
    case 1:
      result = await http.post(server + '/jsxsd/xsxkkc/xsxkBxqjhxk' + check, data: checks); break;
    case 2:
      result = await http.post(server + '/jsxsd/xsxkkc/xsxkGgxxkxk' + check, data: checks); break;
    case 3:
      result = await http.post(server + '/jsxsd/xsxkkc/xsxkBxxk' + check,  data: checks); break;
    case 4:
      result = await http.post(server + '/jsxsd/xsxkkc/xsxkXxxk' + check, data: checks); break;
    case 5:
      result = await http.post(server + '/jsxsd/xsxkkc/xsxkKnjxk' + check, data: checks); break;
    default:
      result = await http.post(server + '/jsxsd/xsxkkc/xsxkFawxk' + check, data: checks); break;
  }
  return result;
}

Future<String> submit(where,oper,http,server) async {
  dynamic result;
  switch (where) {
    case 0:
      result = await http.get(server + '/jsxsd/xsxkkc/fawxkOper' + oper); break;
    case 1:
      result = await http.get(server + '/jsxsd/xsxkkc/bxqjhxkOper' + oper); break;
    case 2:
      result = await http.get(server + '/jsxsd/xsxkkc/ggxxkxkOper' + oper); break;
    case 3:
      result = await http.get(server + '/jsxsd/xsxkkc/bxxkOper' + oper); break;
    case 4:
      result = await http.get(server + '/jsxsd/xsxkkc/xxxkOper' + oper); break;
    case 5:
      result = await http.get(server + '/jsxsd/xsxkkc/knjxkOper' + oper);  break;
    default:
      result = await http.get(server + '/jsxsd/xsxkkc/fawxkOper' + oper); break;
  }
  return result;
}  

Future startLoginX(context,http,server,user,pass,where) async {
  //访问教务系统主页
  dynamic result = await http.get(server + where);
  if (result.contains("请求失败")) {
    await mySnackbar(context, '与教务系统失联，请稍后再试:( 1');
    return false;
  }
  if (result.contains("我的桌面")) {
    return true;
  }
  //教务系统登录方式（暂不支持从信息门户登录）
  if (true) {//带验证码登录
    result = await loginWithYzm(context,http,server,user,pass);
  } else {//不带验证码登录
    result = await loginNormal(http,server,user,pass);
  }
  //判断登录结果
  if (result.contains("请求失败")) {
    await mySnackbar(context, '与教务系统失联，请稍后再试:( 2');
    return false;
  } else if (result.contains("我的桌面")) {
    await mySnackbar(context, '登陆成功！≧▽≦');
    return true;
  } else {
    await mySnackbar(context, '与教务系统失联，请稍后再试:( 3');
    return false;
  }
}

Future loginWithYzm(context,http,server,user,pass) async {
  var yzm = await yzmLogin(context,http,server);//输入验证码
  var encoded = b64(user) + '%%%' + b64(pass);
  var data = {
    'userAccount': user,
    'userPassword': '',//密码置空
    'encoded': encoded,
    'RANDOMCODE': yzm
  };
  var result = await http.post(server + '/jsxsd/xk/LoginToXkLdap', data: data);
  return result;
}

String b64(s) => base64Encode(utf8.encode(s));

Future loginNormal(http,server,user,pass) async {
  var encoded = b64(user) + '%%%' + b64(pass);
  var data = {
    'userAccount': user,
    'userPassword': pass,
    'encoded': encoded
  };
  var result = await http.post(server + '/jsxsd/xk/LoginToXkLdap', data: data);
  return result;
}

//弹窗-->填写登录验证码
Future<String> yzmLogin(context,http,server) async {
  var xencode;
  TextEditingController _encodeEditingController = TextEditingController();
  var bytes = await http.getImage(server + '/jsxsd/verifycode.servlet');//一定注意验证码地址！
  bytes.runtimeType != String //判断返回数据是否正常
      ? await showDialog(
          context: context,
          builder: (BuildContext context) {
            return MyDialogx(
              title: "验证码",
              onPressed: () async {
                xencode = _encodeEditingController.value.text.toString();
                Navigator.of(context).pop();
              },
              child: Container(
                padding: EdgeInsets.only(left: 40.0, right: 40.0),
                child: Row(children: <Widget>[
                  Image.memory(bytes),
                  SizedBox(
                    width: 20.0,
                  ),
                  //验证码
                  Container(
                    width: 120.0,
                    child: TextField(
                      controller: _encodeEditingController,
                      keyboardType: TextInputType.text,
                      decoration: new InputDecoration(
                          contentPadding: const EdgeInsets.all(10.0),
                          hintText: '请输入验证码...',
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
            );
          })
      : await mySnackbar(context, '网络异常，加载验证码失败:(');
  return (xencode != null && xencode.length >= 4) ? xencode : '';
}

//弹窗-->填写选课验证码
Future<String> yzmXk(context,http,server) async {
  var xencode;
  var bytes = await http.getImage(server + '/jsxsd/sys/kaptcha/handleRequestInternal');
  TextEditingController _encodexEditingController = TextEditingController();
  bytes.runtimeType != String //判断返回数据是否正常
      ? await showDialog(
          context: context,
          builder: (BuildContext context) {
            return MyDialogx(
              title: "验证码",
              onPressed: () async {
                xencode = _encodexEditingController.value.text.toString();
                Navigator.of(context).pop();
              },
              child: Container(
                padding: EdgeInsets.only(left: 40.0, right: 40.0),
                child: Row(children: <Widget>[
                  Image.memory(bytes,width: 100,),
                  SizedBox(
                    width: 20.0,
                  ),
                  //验证码
                  Container(
                    width: 100.0,
                    child: TextField(
                      controller: _encodexEditingController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10.0),
                          hintText: '请输入验证码...',
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
            );
          })
      : await mySnackbar(context, '网络异常，错误代码0x000');
  return (xencode != null && xencode.length >= 4) ? xencode : '';
}

//弹窗-->消息提示
Future myTips(context, title, words) async {
  return showDialog(
    context: context,
    child: new AlertDialog(
      title: Text(title,style: TextStyle(color: Colors.red),),
      content: Text(words),
      actions: <Widget>[
        FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("确定",style: TextStyle(color: Colors.blue))),
      ],
    ));
}

//Snackbar-->消息提示
Future mySnackbar(context, words) async {
  Scaffold.of(context).showSnackBar(SnackBar(
    content: Text(words),
    duration: Duration(milliseconds: 1000),
  ));
  await Future.delayed(Duration(milliseconds: 1000));
}

//弹窗-->自定义弹窗
class MyDialogx extends StatefulWidget {
  final String title;
  final Function onPressed;
  final Widget child;
  final double heightx;
  final bool hiddenTitle;
  const MyDialogx(
      {Key key,
      this.title,
      this.heightx=100,
      this.onPressed,
      this.hiddenTitle: false,
      @required this.child})
      : super(key: key);
  @override
  _MyDialogxState createState() => _MyDialogxState(this.title, this.onPressed, this.hiddenTitle, this.child, this.heightx);
}

class _MyDialogxState extends State<MyDialogx> {
  final String title;
  final Function onPressed;
  final Widget child;
  final double heightx;
  final bool hiddenTitle;
  _MyDialogxState(this.title, this.onPressed, this.hiddenTitle, this.child, this.heightx);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //创建透明层
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      // 键盘弹出收起动画过渡
      body: AnimatedContainer(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height -MediaQuery.of(context).viewInsets.bottom,
        duration: Duration(milliseconds: 120),
        curve: Curves.easeInCubic,
        child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
            width: 300.0,
            padding: const EdgeInsets.only(top: 20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Offstage(
                  offstage: hiddenTitle,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text(hiddenTitle ? "" : title,style: TextStyle(fontSize: 18)),
                  ),
                ),
                Container(height: heightx, child: child),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        height: 48.0,
                        child: FlatButton(
                          child: Text("取消",style: TextStyle(fontSize: 18), ),textColor: Colors.grey,
                          onPressed: () { Navigator.of(context).pop(); },
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 48.0,
                        child: FlatButton(
                          child: Text("确定",style: TextStyle(fontSize: 18),),textColor: Colors.blue,
                          onPressed: () async { await onPressed(); },
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10)
              ],
            )),
      ),
    );
  }
}
