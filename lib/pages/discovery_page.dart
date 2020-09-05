import 'package:flutter/material.dart';
// import 'package:flutter_osc_client/pages/common_web_page.dart';
import 'package:barcode_scan/barcode_scan.dart';

import 'tweet_page.dart';
// import 'package:flutter_osc_client/pages/shake_page.dart';

class DiscoveryPage extends StatefulWidget {
  @override
  _DiscoveryPageState createState() => _DiscoveryPageState();
}

class _DiscoveryPageState extends State<DiscoveryPage> {
  List<Map<String, IconData>> blocks = [
    {
      '我的Android项目1': Icons.pageview,
      '我的Android项目2': Icons.speaker_notes_off,
      '我的Android项目3': Icons.screen_share,
      '我的Android项目4': Icons.assignment,
    },
    {
      '扫一扫': Icons.camera_alt,
      '摇一摇': Icons.camera,
    },
    {
      '我的Android项目5': Icons.person,
      '我的Android项目6': Icons.android,
    }
  ];
  String content = '';
  scan() async {
    // String barcode = await BarcodeScanner.scan();
    // var barcode = await BarcodeScanner.scan();
    // print(barcode);
    var options = ScanOptions();
    ScanResult result = await BarcodeScanner.scan(options: options);
    print(result.rawContent);
    setState(() {
      content = result.rawContent;
      print(content);
    });
  }

  void _handleItemClick(String title) {
    switch (title) {
      case '扫一扫':
        scan();
        break;
      case '摇一摇':
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TweetPage(
                      title: content,
                    )));
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
                top: BorderSide(
                  width: 1.0,
                  color: Color(0xffaaaaaa),
                ),
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
