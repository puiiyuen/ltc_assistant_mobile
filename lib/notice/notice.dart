import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';

class Notice extends StatefulWidget{

  final String url;

  Notice(this.url);

  @override
  State<Notice> createState() => new _NoticeState(this.url);
}

class _NoticeState extends State<Notice>{

  String url;
  _NoticeState(this.url);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: new Text('通知公告'),),
      body: new WebView(
      initialUrl: url,
        javascriptMode: JavascriptMode.unrestricted,
    ),
    );
  }
}