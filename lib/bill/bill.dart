import 'package:flutter/material.dart';

class Bill extends StatefulWidget{

  @override
  State<Bill> createState() => new _BillState();
}

class _BillState extends State<Bill>{

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: AppBar(title: new Text('个人账单'),),
    );
  }
}