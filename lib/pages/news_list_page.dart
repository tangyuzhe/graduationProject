import 'package:flutter/material.dart';
import 'package:openSourceChina_APP/utils/storage_utils.dart';
import '../service/service.dart';
import '../widgets/NewsListItem.dart';
import 'package:flutter/cupertino.dart';

class NewsListPage extends StatefulWidget {
  @override
  _NewsListPageState createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {
  bool isLogin = true;
  int curPage = 1;
  List newsList = [
    // {
    //   "id": 26754,
    //   "author": "test33",
    //   "pubDate": "2013-09-17 16:49:50.0",
    //   "title": "asdfa",
    //   "authorid": 253469,
    //   "commentCount": 0,
    //   "type": 4
    // },
    // {
    //   "id": 26754,
    //   "author": "后勤处",
    //   "pubDate": "2020-05-07 00:24:55",
    //   "title": "关于金鸡岭校区部分地方停电的通知",
    //   "authorid":
    //       "各有关单位、各住户:因金鸡岭校区后勒楼变压器需停电检修停电时间：5月5日（周二)13:00—14:00。若有不便，敬清谅解",
    //   "commentCount": 43,
    //   "type": 1
    // }
  ];
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
    getToken().then((val) {
      setState(() {
        getNewsList(val);
        // print(newsList);
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
            Text('由于openapi限制，必须登录才能获取资讯！'),
            InkWell(
              onTap: () async {},
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
