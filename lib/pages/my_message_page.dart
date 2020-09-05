import 'package:flutter/material.dart';
import '../constants/constants.dart';
import 'package:flutter/cupertino.dart';

class MyMessagePage extends StatefulWidget {
  @override
  _MyMessagePageState createState() => _MyMessagePageState();
}

class _MyMessagePageState extends State<MyMessagePage> {
  List<String> _tabTitles = ['我的消息', '我的讲座', '我的调查问卷'];
  int curPage = 1;
  List messageList = [
    '11111111',
    '22221111',
    '33331111',
    '44441111',
    '55551111'
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabTitles.length,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text(
            '消息中心',
            style: TextStyle(
              color: Color(AppColors.APPBAR),
            ),
          ),
          iconTheme: IconThemeData(
            color: Color(AppColors.APPBAR),
          ),
          bottom: TabBar(
              tabs: _tabTitles
                  .map((title) => Tab(
                        text: title,
                      ))
                  .toList()),
        ),
        body: TabBarView(children: [
          ListView(
              scrollDirection: Axis.vertical,
              children: messageList.map((value) {
                return ListTile(
                  title: Text(value),
                );
              }).toList()),
          Center(
            child: Text('暂无内容'),
          ),
          Center(
            child: Text('暂无内容'),
          ),
        ]),
      ),
    );
  }
}
