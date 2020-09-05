import 'package:flutter/material.dart';
import 'package:openSourceChina_APP/utils/storage_utils.dart';
import '../constants/constants.dart' show AppColors;
import 'package:flutter/cupertino.dart';
import '../service/service.dart';

class ProfileDetailPage extends StatefulWidget {
  @override
  _ProfileDetailPageState createState() => _ProfileDetailPageState();
  final String name;
  ProfileDetailPage({Key key, this.name}) : super(key: key);
}

class _ProfileDetailPageState extends State<ProfileDetailPage> {
  var data = {};

  getAlumnuInfo() async {
    String name = await StorageUtil.getStringItem('name');
    if (name == null) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('提示'),
              content: Text('您尚未登录，无法查看自己的信息。'),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context, "1");
                    Navigator.of(context)..pop();
                  },
                  child: Text('关闭'),
                )
              ],
            );
          });
    } else {
      await requestAlumnuInfo(name).then((value) {
        setState(() {
          data = value['data'];
        });
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAlumnuInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          '我的资料',
          style: TextStyle(
            color: Color(AppColors.APPBAR),
          ),
        ),
        iconTheme: IconThemeData(color: Color(AppColors.APPBAR)),
      ),
      body: buildSingleChildScrollView(data),
    );
  }

  Widget buildSingleChildScrollView(data) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          InkWell(
            onTap: () {
              //TODO
            },
            child: Container(
              margin: const EdgeInsets.only(left: 20.0),
              padding:
                  const EdgeInsets.only(top: 10.0, bottom: 10.0, right: 20.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '头像',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  Container(
                    width: 60.0,
                    height: 60.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 2.0,
                      ),
                      image: DecorationImage(
                        image: NetworkImage(
                            'https://dss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=1373560079,871367259&fm=26&gp=0.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Divider(),
          _InkWellContainer('姓名：', data['name']),
          _InkWellContainer('学号：', data['student_id']),
          _InkWellContainer('性别：', data['sex']),
          _InkWellContainer('出生日期：', data['birthday']),
          _InkWellContainer('学校：', data['school']),
          _InkWellContainer('学院：', data['college']),
          _InkWellContainer('专业：', data['speciality']),
          _InkWellContainer('班级：', data['class']),
          _InkWellContainer('教育经历：', data['education']),
          _InkWellContainer(
              '工作地点：', data['workplace'] == null ? '' : data['workplace']),
          _InkWellContainer(
              '工作单位：', data['workunit'] == null ? '' : data['workunit']),
          _InkWellContainer('职务：', data['post'] == null ? '' : data['post']),
          _InkWellContainer('联系电话：', data['phone']),
          _InkWellContainer('年级：', data['grade']),
        ],
      ),
    );
  }

  Widget _InkWellContainer(title, content) {
    return Column(
      children: <Widget>[
        InkWell(
          onTap: () {
            //TODO
          },
          child: Container(
            margin: const EdgeInsets.only(left: 20.0),
            padding:
                const EdgeInsets.only(top: 10.0, bottom: 10.0, right: 20.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  '$title',
                  style: TextStyle(fontSize: 20.0),
                ),
                Text(
                  '$content',
                  // _userInfo.name,
                  style: TextStyle(fontSize: 20.0),
                ),
              ],
            ),
          ),
        ),
        Divider(),
      ],
    );
  }
}
