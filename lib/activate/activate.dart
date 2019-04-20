import 'package:flutter/material.dart';

class Activate extends StatefulWidget{

  @override
  State<Activate> createState() => new _ActivateState();

}

class _ActivateState extends State<Activate>{
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: new Text('激活账户'),),
    );
  }
}