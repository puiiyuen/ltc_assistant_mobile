import 'package:flutter/material.dart';

import 'sos_service.dart';
import '../login/login.dart';
import '../utils/opertaion_status.dart';

class Sos extends StatefulWidget {
  @override
  State<Sos> createState() => new _SosState();
}

class _SosState extends State<Sos> {
  var sosStatus = '';
  SosService sosService = new SosService();

  Padding buildTitle() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        '紧急求助',
        style: TextStyle(fontSize: 45.0, fontWeight: FontWeight.bold),
      ),
    );
  }

  Padding buildTitleLine() {
    return Padding(
      padding: EdgeInsets.only(left: 12.0, top: 4.0),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Container(
          color: Theme.of(context).primaryColor,
          width: 120.0,
          height: 4.0,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: new Text('紧急求助'),
        ),
        body: ListView(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            buildTitle(),
            buildTitleLine(),
            new SizedBox(
              height: 70,
            ),
            new Align(
              child: new Text(
                '按下按钮开始求助',
                style: new TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            new SizedBox(
              height: 50,
            ),
            new Align(
              child: new SizedBox(
                width: 150,
                height: 150,
                child: new RaisedButton(
                    child: new Text(
                      '求助',
                      style: TextStyle(fontSize: 50, color: Colors.white),
                    ),
                    color: Colors.red,
                    shape: CircleBorder(),
                    onPressed: () {
                      setState(() {
                        sosStatus = '正在求助';
                      });
                      sosService.sendSos().then((onValue) {
                        if (onValue == OperationStatus.SUCCESSFUL) {
                          setState(() {
                            sosStatus = '求助成功';
                          });
                        } else if (onValue == OperationStatus.NOT_EXIST) {
                          setState(() {
                            sosStatus = '首次使用请登陆';
                          });
                          Future.delayed(Duration(seconds: 2),(){
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) => new Login()));
                          });
                        } else {
                          setState(() {
                            sosStatus = '求助失败，请重试';
                          });
                        }
                      });
                    }),
              ),
            ),
            new SizedBox(
              height: 50,
            ),
            new Align(
              child: new Text(
                sosStatus,
                style: new TextStyle(
                    color: Colors.red,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ));
  }
}
