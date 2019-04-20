import 'package:flutter/material.dart';

class Sos extends StatefulWidget{
  @override
  State<Sos> createState() => new _SosState();
}

class _SosState extends State<Sos>{
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: new Text('紧急求助'),),
    );
  }
}