import 'package:flutter/material.dart';
import 'map_location.dart';
import 'index.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "智慧助手",
      home: new Index()
    );
  }

}
