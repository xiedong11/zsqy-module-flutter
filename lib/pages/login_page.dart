import 'package:flutter/material.dart';
import 'package:flutter_app/entity/qfnu_user_entity.dart';
import 'package:flutter_app/pages/home/home_page.dart';
import 'package:flutter_app/utils/dio_utils.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PageState();
  }
}

class PageState extends State<LoginPage> {
  TextEditingController _accountEditingController = TextEditingController();
  TextEditingController _passWordEditingController = TextEditingController();
  bool isShowProssgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.only(left: 25, right: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(height: 120),
              Text(
                "账号密码登陆",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 32,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 40),
              Flexible(
                child: TextField(
                  controller: _accountEditingController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: "请输入信息门户账号",
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.deepOrangeAccent, width: 2)),

                  ),
                ),
              ),
              SizedBox(height: 20),
              Flexible(
                  child: TextField(
                controller: _passWordEditingController,
                keyboardType: TextInputType.text,
                obscureText: true,
                decoration: InputDecoration(
                    hintText: "请输入信息门户密码",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.deepOrangeAccent, width: 2))),
              )),
              SizedBox(height: 50),
              Builder(builder: (BuildContext context) {
                return Column(
                  children: <Widget>[
                    RaisedButton(
                      color: Colors.teal,
                      onPressed: () {
                        doLogin(context);
                      },
                      child: Container(
                        height: 50,
                        child: Center(
                          child: Text(
                            "戳我登陆",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                    isShowProssgress
                        ? SizedBox(
                            height: 2,
                            child: LinearProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation(Colors.deepOrange),
                              backgroundColor: Colors.lightBlue,
                            ),
                          )
                        : Text("")
                  ],
                );
              })
            ],
          ),
        ),
      ),
    );
  }

  void doLogin(BuildContext context) async {
    this.setState(() {
      isShowProssgress = true;
    });
    var userAccount = _accountEditingController.value.text.toString();
    var userPassWrod = _passWordEditingController.value.text.toString();
    if (userAccount.length < 6 || userPassWrod.length < 6) {
      Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(
        '请输入正确的账号密码',
        style: TextStyle(color: Colors.red),
      )));
      this.setState(() {
        isShowProssgress = false;
      });
    } else {
      var params = {
        "method": "authUser",
        "xh": userAccount.trim(),
        "pwd": userPassWrod.trim()
      };
      var result = await DioUtils.getInstance().get(data: params);
      QfnuUserEntity qfnuUserEntity = QfnuUserEntity.fromJson(result);
      this.setState(() {
        isShowProssgress = false;
      });
      if (qfnuUserEntity.success) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>HomePage()));
      } else {
        showDialog(
            context: context,
            child: AlertDialog(
              title: Text('登陆失败'),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      _passWordEditingController.text = "";
                      _accountEditingController.text = "";
                    },
                    child: Text(
                      "确定",
                      style: TextStyle(color: Colors.red),
                    ))
              ],
            ));
      }
    }
  }
}
