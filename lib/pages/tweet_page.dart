import 'package:flutter/material.dart';

class TweetPage extends StatefulWidget {
  final String title;
  TweetPage({Key key, this.title}) : super(key: key);
  @override
  _TweetPageState createState() => _TweetPageState();
}

class _TweetPageState extends State<TweetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('动弹'),
      ),
      body: Text('${widget.title}'),
    );
  }
}
