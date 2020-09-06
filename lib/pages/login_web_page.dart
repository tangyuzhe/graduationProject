import 'package:flutter/material.dart';
import 'package:openSourceChina_APP/home_page.dart';
import 'package:openSourceChina_APP/service/service.dart';
import '../utils/storage_utils.dart';

//登录页面
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> loginKey = new GlobalKey<FormState>();
  String userName;
  String password;
  bool isShowPassWord = false;
  bool isLogin = false;
  void login() {
    var loginForm = loginKey.currentState;
    if (loginForm.validate()) {
      loginForm.save();
      requestToken(password, userName).then((value) {
        if (value['code'] == 0) {
          String token = "Bearer " + value['token'];
          StorageUtil.setStringItem('token', token);
          StorageUtil.setStringItem('name', userName);
          isLogin = true;
          StorageUtil.setBoolItem('isLogin', isLogin);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => HomePage(name: userName)));
        }
      });
    }
  }

  void showPassWord() {
    setState(() {
      isShowPassWord = !isShowPassWord;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _logoContainer(),
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                  key: loginKey,
                  autovalidate: true,
                  child: Column(
                    children: <Widget>[
                      _phoneField(),
                      _passwordField(),
                      _loginButton(),
                      _otherOperation()
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }

  Widget _logoContainer() {
    return Container(
        padding: EdgeInsets.only(top: 100.0, bottom: 10.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                width: 100.0,
                height: 100.0,
                child: Image.network(
                    'https://bkimg.cdn.bcebos.com/pic/00e93901213fb80e43a6638d39d12f2eb9389470?x-bce-process=image/resize,m_lfit,w_268,limit_1/format,f_jpg',
                    fit: BoxFit.cover),
              ),
              Text(
                '三院第二课堂',
                style: TextStyle(
                    color: Color.fromARGB(255, 53, 53, 53), fontSize: 15.0),
              ),
            ],
          ),
        ));
  }

  Widget _phoneField() {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: Color.fromARGB(255, 240, 240, 240), width: 1.0))),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: '请输入姓名：',
          labelStyle:
              TextStyle(fontSize: 15.0, color: Color.fromARGB(255, 93, 93, 93)),
          border: InputBorder.none,
        ),
        // keyboardType: TextInputType.phone,
        onSaved: (value) {
          //TODO save
          userName = value;
        },
        validator: (value) {
          //TODO 校验
          // if (value.length < 10) {
          //   return '学号长度不够10位';
          // } else if (value.length > 11) {
          //   return '学号长度超出10位';
          // }
        },
        onFieldSubmitted: (value) {
          //TODO 提交
        },
      ),
    );
  }

  Widget _passwordField() {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: Color.fromARGB(255, 240, 240, 240), width: 1.0))),
      child: TextFormField(
        decoration: InputDecoration(
            labelText: '请输入学号：',
            labelStyle: TextStyle(
                fontSize: 15.0, color: Color.fromARGB(255, 93, 93, 93)),
            border: InputBorder.none,
            suffixIcon: IconButton(
              icon: Icon(
                isShowPassWord ? Icons.visibility : Icons.visibility_off,
                color: Color.fromARGB(255, 126, 126, 126),
              ),
              onPressed: showPassWord,
            )),
        obscureText: !isShowPassWord,
        onSaved: (value) {
          //TODO save
          password = value;
        },
        validator: (value) {
          // if (value.length < 6) {
          //   return '密码长度不够6位';
          // } else if (value.length > 6) {
          //   return '密码长度超出6位';
          // }
        },
      ),
    );
  }

  Widget _loginButton() {
    return Container(
      height: 45.0,
      margin: EdgeInsets.only(top: 40.0),
      child: SizedBox.expand(
        child: RaisedButton(
          onPressed: login,
          color: Color.fromARGB(255, 61, 203, 128),
          child: Text('登录',
              style: TextStyle(
                  fontSize: 14.0, color: Color.fromARGB(255, 255, 255, 255))),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(45.0)),
        ),
      ),
    );
  }

  Widget _otherOperation() {
    return Container(
      margin: EdgeInsets.only(top: 30.0),
      padding: EdgeInsets.only(left: 8.0, right: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Text('注册账号',
                style: TextStyle(
                    fontSize: 13.0, color: Color.fromARGB(255, 53, 53, 53))),
          ),
          Container(
            child: Text('忘记密码？',
                style: TextStyle(
                    fontSize: 13.0, color: Color.fromARGB(255, 53, 53, 53))),
          ),
        ],
      ),
    );
  }
}
