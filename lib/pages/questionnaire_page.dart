import 'package:flutter/material.dart';

//问卷调查页面
class QuestionNairePage extends StatefulWidget {
  QuestionNairePage({Key key}) : super(key: key);

  @override
  _QuestionNairePageState createState() => _QuestionNairePageState();
}

class _QuestionNairePageState extends State<QuestionNairePage> {
  @override
  String name;
  ScrollController controller = new ScrollController();
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('问卷调查')),
        body: Container(
          child: Text('data'),
        ));
  }
}
