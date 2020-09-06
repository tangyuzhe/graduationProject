import 'dart:io';

import 'package:dio/dio.dart';
import 'package:openSourceChina_APP/utils/storage_utils.dart';

const base_url = "http://thesecondclass.linaxhua.cn/api";

getToken() async {
  String token = await StorageUtil.getStringItem('token');
  return token;
}

Dio dio = new Dio();

//Auth测试获取token
requestToken(userid, name) async {
  dio.options.baseUrl = base_url;
  try {
    var response = await dio
        .post('/user/Auth', queryParameters: {"userid": userid, "name": name});
    return response.data;
  } catch (e) {
    return '请求出错';
  }
}

//查询校友信息
requestAlumnuInfo(name) async {
  dio.options.baseUrl = base_url;
  try {
    var response =
        await dio.get('/alumnus/findAlumnu', queryParameters: {"name": name});
    return response.data;
  } catch (e) {
    return e.toString();
  }
}

//获取新闻列表
requestNewsList(token) async {
  Options options =
      Options(headers: {HttpHeaders.authorizationHeader: "$token"});
  dio.options.baseUrl = base_url;
  try {
    var response = await dio.get('/news', options: options);
    return response.data;
  } catch (e) {
    return e.toString();
  }
}

//扫码签到
ScanToSign(id, signed, token) async {
  Options options =
      Options(headers: {HttpHeaders.authorizationHeader: "$token"});
  dio.options.baseUrl = base_url;
  try {
    var response = await dio.put('/studentactivity/updatestudentactivity',
        options: options, queryParameters: {"id": id, "signed": signed});
    return response.data;
  } catch (e) {
    return e.toString();
  }
}
