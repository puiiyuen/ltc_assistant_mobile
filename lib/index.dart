import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Index extends StatefulWidget {
  @override
  State<Index> createState() => new _IndexState();
}

class _IndexState extends State<Index> {
  PageView _topBoard;
  GridView _funcSelect;

  @override
  void initState() {
    super.initState();

    _topBoard =
        new PageView(scrollDirection: Axis.horizontal, children: <Widget>[
      Container(
        color: Colors.blue,
      ),
      Container(
        color: Colors.yellow,
      ),
      Container(
        color: Colors.green,
      )
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
          appBar: AppBar(title: new Text("智慧助手")),
          body: new CustomScrollView(
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildListDelegate([
                  new AspectRatio(aspectRatio: 2,
                  child: new Container(
                    child: _topBoard,
                  ),)
                ]),
              ),
              SliverGrid.count(crossAxisCount: 2,
              childAspectRatio: 1,
              children: <Widget>[
                new Container(
                  color: Colors.blue,
                ),
                new Container(
                  color: Colors.green,
                ),
                new Container(
                  color: Colors.yellow,
                ),
                new Container(
                  color: Colors.red,
                ),
                new Container(
                  color: Colors.orange,
                ),
                new Container(
                  color: Colors.deepPurple,
                ),
                new Container(
                  color: Colors.cyanAccent,
                )
              ],)
            ],
          )
          )
    );
  }
}
