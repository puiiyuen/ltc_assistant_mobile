import 'package:flutter/material.dart';
import 'map_location.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      title: "智慧助手",
      home: new Scaffold(
        body: CurrentLocationWidget()
      )
    );
  }

}
