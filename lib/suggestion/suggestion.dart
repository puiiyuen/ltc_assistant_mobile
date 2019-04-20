import 'package:flutter/material.dart';


class Suggestion extends StatefulWidget{

  @override
  State<Suggestion> createState() => new _SuggestionState();
}

class _SuggestionState extends State<Suggestion> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: new Text('意见反馈'),),
    );
  }
}