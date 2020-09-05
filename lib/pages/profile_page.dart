import 'package:flutter/material.dart';
import 'package:openSourceChina_APP/pages/login_web_page.dart';
import 'package:openSourceChina_APP/utils/storage_utils.dart';
// import './pages/login_web_page.dart';
import '../constants/constants.dart';
import 'my_message_page.dart';
import 'profile_detail_page.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();

  final name;
  ProfilePage({Key key, this.name}) : super(key: key);
}

class _ProfilePageState extends State<ProfilePage> {
  List menuTitles = ProfileData.menuTitles;
  List menuIcons = ProfileData.menuIcons;
  String userAvatar;
  String userName;
  bool isLogin;
  String name = '';

  getStorageStatus() async {
    bool isLogin = await StorageUtil.getBoolItem('isLogin');
    String token = await StorageUtil.getStringItem('token');
    String name = await StorageUtil.getStringItem('name');
    return {'isLogin': isLogin, 'name': name, 'token': token};
  }

  removeLoginStatus() async {
    if (isLogin) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('提示'),
              content: Text('是否要退出当前登录？'),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context, "1");
                  },
                  child: Text('取消'),
                ),
                FlatButton(
                  onPressed: () async {
                    await StorageUtil.setBoolItem('isLogin', false);
                    await StorageUtil.remove('token');
                    await StorageUtil.remove('name');
                    Navigator.pop(context, "1");
                  },
                  child: Text('确认'),
                )
              ],
            );
          });
    } else {
      print('err');
    }
  }

  void _showDialog(String message, String buttonmsg) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('提示'),
            content: Text('$message'),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.pop(context, "1");
                },
                child: Text('$buttonmsg'),
              )
            ],
          );
        });
  }

  _login() async {
    if (isLogin == false) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    } else {
      _showDialog('您已经登录，清先退出账号', '关闭');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStorageStatus().then((val) {
      setState(() {
        isLogin = val['isLogin'];
        name = val['name'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) {
          if (index == 0) {
            return _Header(isLogin, name);
          }
          index -= 1;
          return ListTile(
            leading: Icon(menuIcons[index]),
            title: Text(menuTitles[index]),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              switch (index) {
                case 0:
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyMessagePage()));
                  break;
                case 1:
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProfileDetailPage()));
                  break;
                case 6:
                  removeLoginStatus();
                  break;
                default:
              }
            },
          );
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
        itemCount: menuTitles.length + 1);
  }

  Container _Header(isLogin, name) {
    return Container(
      height: 150.0,
      color: Color(AppColors.APP_THEME),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              child: Container(
                width: 60.0,
                height: 60.0,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Color(0xffffffff),
                      width: 2.0,
                    ),
                    image: DecorationImage(
                        image:
                            AssetImage('assets/images/ic_avatar_default.png'),
                        fit: BoxFit.cover)),
              ),
              onTap: () {
                //TODO
                _login();
              },
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              name == null ? '请点击头像登录' : '$name',
              style: TextStyle(color: Color(0xffffffff), fontSize: 20.0),
            )
          ],
        ),
      ),
    );
  }
}
