import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';

class ToPayPal extends StatefulWidget{

  @override
  State<ToPayPal> createState() => new _ToPayPalState();
}

class _ToPayPalState extends State<ToPayPal>{

  getProgressDialog() {
    // // CircularProgressIndicator是一个圆形的Loading进度条
    return new Center(child: new CircularProgressIndicator());
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: new Text('在线支付'),),
      body: new WebView(
        initialUrl: 'https://paypal.me/puiiyuen',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}