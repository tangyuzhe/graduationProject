import 'package:flutter/material.dart';
// import 'package:flutter_osc_client/pages/common_web_page.dart';
import 'package:barcode_scan/barcode_scan.dart';

import 'tweet_page.dart';
import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import '../service/service.dart';
import 'package:openSourceChina_APP/utils/storage_utils.dart';
import './questionnaire_page.dart';
// import 'package:flutter_osc_client/pages/shake_page.dart';

class DiscoveryPage extends StatefulWidget {
  @override
  _DiscoveryPageState createState() => _DiscoveryPageState();
}

class _DiscoveryPageState extends State<DiscoveryPage> {
  List<Map<String, IconData>> blocks = [
    {
      '讲座扫码器': Icons.camera_alt,
      '问卷调查': Icons.info_outline,
    },
  ];
  String content = '';
  int id;
  String token;

  getToken() async {
    String token = await StorageUtil.getStringItem('token');
    return token;
  }

  @override
  void initState() {
    super.initState();
    getToken().then((val) {
      setState(() {
        token = val;
      });
    });
  }

  //扫码功能
  scan() async {
    var options = ScanOptions();
    ScanResult result = await BarcodeScanner.scan(options: options);
    setState(() {
      id = json.decode(result.rawContent)['id'];
      content = generateMd5(result.rawContent);
    });
    ScanToSign(id, content, token);
  }

  //MD5加密
  String generateMd5(String data) {
    var content = new Utf8Encoder().convert(data);
    var digest = md5.convert(content);
    return hex.encode(digest.bytes);
  }

  void _handleItemClick(String title) {
    switch (title) {
      case '讲座扫码器':
        scan();
        break;
      case '问卷调查':
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => QuestionNairePage()));
        break;
    }
  }

  void _navToWebPage(String title, String url) {
    if (title != null && url != null) {
      // Navigator.of(context).push(MaterialPageRoute(
      //     builder: (context) => CommonWebPage(
      //           title: title,
      //           url: url,
      //         )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: blocks.length,
        itemBuilder: (context, bolockIndex) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 10.0),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 1.0,
                  color: Color(0xffaaaaaa),
                ),
              ),
            ),
            child: ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                //滑动冲突
                shrinkWrap: true,
                itemBuilder: (context, mapIndex) {
                  return InkWell(
                    onTap: () {
                      _handleItemClick(
                          blocks[bolockIndex].keys.elementAt(mapIndex));
                    },
                    child: Container(
                      height: 60.0,
                      child: ListTile(
                        leading: Icon(
                            blocks[bolockIndex].values.elementAt(mapIndex)),
                        title:
                            Text(blocks[bolockIndex].keys.elementAt(mapIndex)),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, mapIndex) {
                  return Divider(
                    height: 1.0,
                  );
                },
                itemCount: blocks[bolockIndex].length),
          );
        });
  }
}
