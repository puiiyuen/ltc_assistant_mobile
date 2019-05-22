import 'package:flutter/material.dart';

class Profile extends StatefulWidget{

  @override
  State<Profile> createState() => new _ProfileState();
}

class _ProfileState extends State<Profile>{



  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: new Text('个人中心'),),

    );
  }
}