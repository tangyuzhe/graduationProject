import 'package:flutter/material.dart';
import 'package:openSourceChina_APP/utils/storage_utils.dart';
import '../service/service.dart';
import '../widgets/NewsListItem.dart';
import 'package:flutter/cupertino.dart';

import 'login_web_page.dart';

class NewsListPage extends StatefulWidget {
  @override
  _NewsListPageState createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {
  bool isLogin = false;
  int curPage = 1;
  List newsList = [];
  ScrollController _controller = ScrollController();

  Future<Null> _pullToRefresh() async {
    curPage = 1;
    // getNewsList(false);
    return null;
  }

  getToken() async {
    String token = await StorageUtil.getStringItem('token');
    return token;
  }

  getIsLogin() async {
    bool isLogin = await StorageUtil.getBoolItem('isLogin');
    return isLogin;
  }

  getNewsList(token) async {
    requestNewsList(token).then((value) {
      // print(value);
      setState(() {
        newsList.addAll(value['data']);
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getIsLogin().then((val) {
      setState(() {
        isLogin = val;
      });
    });
    getToken().then((val) {
      setState(() {
        if (isLogin) {
          getNewsList(val);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!isLogin) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('请先登录查看校园新闻'),
            InkWell(
              onTap: () async {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
              child: Text('去登录'),
            ),
          ],
        ),
      );
    }
    return RefreshIndicator(
      onRefresh: _pullToRefresh,
      child: buildListView(),
    );
  }

  Widget buildListView() {
    return ListView.builder(
        controller: _controller,
        itemCount: newsList.length, //lsn 15
        itemBuilder: (context, index) {
          return NewsListItem(newsList: newsList[index]);
        });
  }
}
