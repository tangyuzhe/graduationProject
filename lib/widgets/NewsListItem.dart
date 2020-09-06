import 'package:flutter/material.dart';

class NewsListItem extends StatelessWidget {
  final Map<String, dynamic> newsList;

  NewsListItem({this.newsList});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
            color: Color(0xffaaaaaa),
            width: 0.5,
          )),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, right: 20.0),
          child: Column(
            children: <Widget>[
              Text(
                '${newsList['news_title']}',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 10.0),
              Text(
                '${newsList['news_body']}',
                style: TextStyle(
                  fontSize: 20.0,
                  letterSpacing: 1.0,
                ),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '${newsList['releaser']} ${newsList['release_time'].toString().split(' ')[0]}',
                    style: TextStyle(color: Color(0xaaaaaaaa), fontSize: 16.0),
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.message,
                        color: Color(0xaaaaaaaa),
                      ),
                      Text(
                        '${newsList['views']}',
                        style:
                            TextStyle(color: Color(0xaaaaaaaa), fontSize: 16.0),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
