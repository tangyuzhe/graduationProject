import 'package:flutter/material.dart';

abstract class AppColors {
  //应用主题色
  static const APP_THEME = 0xff64b5f6;
  static const APPBAR = 0xffffffff;
}

//profile_page 列表数据
abstract class ProfileData {
  static List menuTitles = [
    '我的消息',
    '基本信息',
    '我的博客',
    '我的问答',
    '我的活动',
    '我的团队',
    '退出登录',
  ];
  static List menuIcons = [
    Icons.message,
    Icons.info,
    Icons.error,
    Icons.phone,
    Icons.send,
    Icons.people,
    Icons.exit_to_app,
  ];
}

//login_web_page
abstract class AppInfos {
  static const String CLIENT_ID = 'a8nBnrIUiLGcHyjZb5G4'; //应用id
  static const String CLIENT_SECRET = 'lV3aPUNjrK9vgFiBXOZkC9oxjusEhERl'; //应用密钥
  static const String REDIRECT_URI = 'https://www.dongnaoedu.com/'; //回调地址
}

abstract class AppUrls {
  static const String HOST = 'https://www.oschina.net';
  //授权登录 ctrl shift u
  static const String OAUTH2_AUTHORIZE = HOST + '/action/oauth2/authorize';
  //获取token
  static const String OAUTH2_TOKEN = HOST + '/action/openapi/token';
}
