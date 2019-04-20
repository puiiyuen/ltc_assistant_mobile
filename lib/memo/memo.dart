import 'package:flutter/material.dart';

class Memo extends StatefulWidget{

  @override
  State<Memo> createState() => new _MemoState();
}

class _MemoState extends State<Memo> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: new Text('事项提醒'),),
    );
  }
}