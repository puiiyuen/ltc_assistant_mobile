import 'package:flutter/material.dart';
import 'location/map_location.dart';

void main() => runApp(new LtcAssistant());

class LtcAssistant extends StatelessWidget {

  @override
  Widget build (BuildContext context) {
    return new MaterialApp(
      title: "智慧助手",
      home: new Scaffold(
        body: new CurrentLocationWidget()
      )
    );
  }
}

