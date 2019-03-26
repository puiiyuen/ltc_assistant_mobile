import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Index extends StatefulWidget {
  @override
  State<Index> createState() => new _IndexState();
}

class _IndexState extends State<Index> {
  PageView _topBoard;

  @override
  void initState() {
    super.initState();

    _topBoard =
        new PageView(scrollDirection: Axis.horizontal, children: <Widget>[
      new GestureDetector(
        child: Container(
          color: Colors.blue,
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text("通知公告",style:new TextStyle(
                  fontSize: 40,
                  color: Colors.white
              ))
            ],
          ),
        ),
      ),
      new GestureDetector(
        child: Container(
          color: Colors.yellow,
        ),
      ),
      new GestureDetector(
        child: Container(
          color: Colors.green,
        ),
      )
    ]);
  }
  

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "智慧助手",
      home: new Scaffold(
          appBar: AppBar(title: new Text("智慧助手")),
          body: new CustomScrollView(
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildListDelegate([
                  new AspectRatio(aspectRatio: 1.8,
                  child: new Container(
                    child: _topBoard,
                  ),)
                ]),
              ),
              SliverPadding(
                padding: EdgeInsets.only(top: 20,left: 15,right: 15),
                sliver: SliverGrid.count(
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                  children: <Widget>[
                    new GestureDetector(
                      child: new Container(
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: new BorderRadius.vertical(
                                top: Radius.elliptical(15, 15),
                                bottom: Radius.elliptical(15, 15)
                            ),
                            // 阴影位置由offset决定,阴影模糊层度由blurRadius大小决定（大就更透明更扩散），阴影模糊大小由spreadRadius决定
                            boxShadow: [
                              BoxShadow(color: Colors.grey,
                                  offset: Offset(3.0, 3.0),
                                  blurRadius: 10.0,
                                  spreadRadius: 2.0),
                            ],

                        ),
                        child: new Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Icon(Icons.assignment,
                              size: 100,
                              color: Colors.white,),
                            new Text("健康报告",style: new TextStyle(
                                color: Colors.white,
                                fontSize: 30
                            ),)
                          ],
                        ),
                      ),
                    ),
                    new GestureDetector(
                      child: new Container(
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: new BorderRadius.vertical(
                              top: Radius.elliptical(15, 15),
                              bottom: Radius.elliptical(15, 15)
                          ),
                          boxShadow: [
                            BoxShadow(color: Colors.grey,
                                offset: Offset(3.0, 3.0),
                                blurRadius: 10.0,
                                spreadRadius: 2.0),
                          ],
                        ),
                        child: new Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Icon(Icons.calendar_today,
                              size: 100,color: Colors.white,),
                            new Text("事项提醒",style: new TextStyle(
                                color: Colors.white,
                                fontSize: 30
                            ),)
                          ],
                        ),
                      ),
                    ),
                    new GestureDetector(
                      child: new Container(
                        decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: new BorderRadius.vertical(
                              top: Radius.elliptical(15, 15),
                              bottom: Radius.elliptical(15, 15)
                          ),
                          boxShadow: [
                            BoxShadow(color: Colors.grey,
                                offset: Offset(3.0, 3.0),
                                blurRadius: 10.0,
                                spreadRadius: 2.0),
                          ],
                        ),
                        child: new Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Icon(Icons.attach_money,
                              size: 100,color: Colors.white,),
                            new Text("个人账单",style: new TextStyle(
                                color: Colors.white,
                                fontSize: 30
                            ),)
                          ],
                        ),
                      ),
                    ),
                    new GestureDetector(
                      child: new Container(
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: new BorderRadius.vertical(
                              top: Radius.elliptical(15, 15),
                              bottom: Radius.elliptical(15, 15)
                          ),
                          boxShadow: [
                            BoxShadow(color: Colors.grey,
                                offset: Offset(3.0, 3.0),
                                blurRadius: 10.0,
                                spreadRadius: 2.0),
                          ],
                        ),
                        child: new Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Icon(Icons.add_alert,size: 100,color:Colors.white,),
                            new Text("紧急求助",style: new TextStyle(
                                color: Colors.white,
                                fontSize: 30
                            ),)
                          ],
                        ),
                      ),
                    ),
                    new GestureDetector(
                      child: new Container(
                        decoration: BoxDecoration(
                          color: Colors.cyan,
                          borderRadius: new BorderRadius.vertical(
                              top: Radius.elliptical(15, 15),
                              bottom: Radius.elliptical(15, 15)
                          ),
                          boxShadow: [
                            BoxShadow(color: Colors.grey,
                                offset: Offset(3.0, 3.0),
                                blurRadius: 10.0,
                                spreadRadius: 2.0),
                          ],
                        ),
                        child: new Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Icon(Icons.sms,
                              size: 100,color: Colors.white,),
                            new Text("意见反馈",style: new TextStyle(
                                color: Colors.white,
                                fontSize: 30
                            ),)
                          ],
                        ),
                      ),
                    ),
                    new GestureDetector(
                      child: new Container(
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: new BorderRadius.vertical(
                              top: Radius.elliptical(15, 15),
                              bottom: Radius.elliptical(15, 15)
                          ),
                          boxShadow: [
                            BoxShadow(color: Colors.grey,
                                offset: Offset(3.0, 3.0),
                                blurRadius: 10.0,
                                spreadRadius: 2.0),
                          ],
                        ),
                        child: new Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Icon(Icons.person,size: 100,color: Colors.white,),
                            new Text("个人中心",style: new TextStyle(
                                color: Colors.white,
                                fontSize: 30
                            ),)
                          ],
                        ),
                      ),
                    )
                  ],),
              )
            ],
          )
          )
    );
  }
}
