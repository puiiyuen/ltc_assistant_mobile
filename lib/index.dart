import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:ltc_assistant/utils/map_location.dart';
import 'package:ltc_assistant/login/login.dart';
import 'utils/session.dart';
import 'utils/opertaion_status.dart';
import 'utils/info_config.dart';

import 'health_report/health_report.dart';
import 'bill/bill.dart';
import 'memo/memo.dart';
import 'suggestion/suggestion.dart';
import 'profile/profile.dart';
import 'sos/sos.dart';
import 'notice/notice.dart';

class Index extends StatefulWidget {
  @override
  State<Index> createState() => new _IndexState();
}

class _IndexState extends State<Index> {
  var _banner1 = 'images/banner-1.jpg';
  var _banner2 = 'images/banner-2.jpg';
  var _banner3 = 'images/banner-3.jpg';

  bool locationStart=false;
  SharedPreferences db;
  bool isResident = false;

  Session session = new Session();
  MapLocation mapLocation = new MapLocation();

  _IndexState(){
    initDB();
  }

  void initDB()async{
    db = await SharedPreferences.getInstance();
  }

  PageView notice(){
    return new PageView(scrollDirection: Axis.horizontal, children: <Widget>[
      new GestureDetector(
        child: Container(
          decoration: new BoxDecoration(
            color: Colors.blue,
            image: DecorationImage(
                image: new ExactAssetImage(_banner1),
                fit: BoxFit.cover),
          ),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text("通知公告", style: new TextStyle(
                  fontSize: 40,
                  color: Colors.white
              ))
            ],
          ),
        ),
        onTap: (){
          Navigator.push(context,
            new MaterialPageRoute(builder:
                (context) => new Notice(InfoConfig.SERVER_ADDRESS
                    +'/#/notices/1'))
              );
        },
      ),
      new GestureDetector(
        child: Container(
          decoration: new BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                  image: new ExactAssetImage(_banner2),
                  fit: BoxFit.cover)
          ),
        ),
        onTap: (){
          Navigator.push(context,
              new MaterialPageRoute(builder:
                  (context) => new Notice(InfoConfig.SERVER_ADDRESS
                  +'/#/notices/2'))
          );
        },
      ),
      new GestureDetector(
        child: Container(
          decoration: new BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                  image: new ExactAssetImage(_banner3),
                  fit: BoxFit.cover)
          ),
        ),
        onTap: (){
          Navigator.push(context,
              new MaterialPageRoute(builder:
                  (context) => new Notice(InfoConfig.SERVER_ADDRESS
                  +'/#/notices/3'))
          );
        },
      )
    ]);
  }

  SliverPadding resIndexMenu(){
    return SliverPadding(
      padding: EdgeInsets.only(top: 20, left: 15, right: 15),
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
                  new Text("健康报告", style: new TextStyle(
                      color: Colors.white,
                      fontSize: 30
                  ),)
                ],
              ),
            ),
            onTap: () async{
              int onlineStatus;
              int loginStatus=-1;
              await session.isOnline().then((onValue){
                onlineStatus = onValue;
              });
              if(onlineStatus == OperationStatus.IS_EXIST){
              Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new HealthReport()));
              } else if (onlineStatus == OperationStatus.NOT_EXIST) {
              await Navigator.push(context,
                    new MaterialPageRoute(
                        builder: (context) => new Login())).then((onValue){
                           loginStatus = onValue;
              });
                if  (loginStatus == OperationStatus.SUCCESSFUL){
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new HealthReport()));
                }
              }
            },
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
                    size: 100, color: Colors.white,),
                  new Text("事项提醒", style: new TextStyle(
                      color: Colors.white,
                      fontSize: 30
                  ),)
                ],
              ),
            ),
            onTap: () async{
              int onlineStatus;
              int loginStatus=-1;
              await session.isOnline().then((onValue){
                onlineStatus = onValue;
              });
              if(onlineStatus == OperationStatus.IS_EXIST){
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new Memo()));
              } else if (onlineStatus == OperationStatus.NOT_EXIST) {
                await Navigator.push(context,
                    new MaterialPageRoute(
                        builder: (context) => new Login())).then((onValue){
                  loginStatus = onValue;
                });
                if  (loginStatus == OperationStatus.SUCCESSFUL){
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new Memo()));
                }
              }
            },
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
                    size: 100, color: Colors.white,),
                  new Text("个人账单", style: new TextStyle(
                      color: Colors.white,
                      fontSize: 30
                  ),)
                ],
              ),
            ),
            onTap: () async{
              int onlineStatus;
              int loginStatus=-1;
              await session.isOnline().then((onValue){
                onlineStatus = onValue;
              });
              if(onlineStatus == OperationStatus.IS_EXIST){
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new Bill()));
              } else if (onlineStatus == OperationStatus.NOT_EXIST) {
                await Navigator.push(context,
                    new MaterialPageRoute(
                        builder: (context) => new Login())).then((onValue){
                  loginStatus = onValue;
                });
                if  (loginStatus == OperationStatus.SUCCESSFUL){
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new Bill()));
                }
              }
            },
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
                  new Icon(Icons.add_alert, size: 100,
                    color: Colors.white,),
                  new Text("紧急求助", style: new TextStyle(
                      color: Colors.white,
                      fontSize: 30
                  ),)
                ],
              ),
            ),
            onTap: () {
              Navigator.push(context,
                new MaterialPageRoute(
                    builder: (context) => new Sos())
              );
            },
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
                    size: 100, color: Colors.white,),
                  new Text("意见反馈", style: new TextStyle(
                      color: Colors.white,
                      fontSize: 30
                  ),)
                ],
              ),
            ),
            onTap: () async{
              int onlineStatus;
              int loginStatus=-1;
              await session.isOnline().then((onValue){
                onlineStatus = onValue;
              });
              if(onlineStatus == OperationStatus.IS_EXIST){
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new Suggestion()));
              } else if (onlineStatus == OperationStatus.NOT_EXIST) {
                await Navigator.push(context,
                    new MaterialPageRoute(
                        builder: (context) => new Login())).then((onValue){
                  loginStatus = onValue;
                });
                if  (loginStatus == OperationStatus.SUCCESSFUL){
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new Suggestion()));
                }
              }
            },
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
                  new Icon(
                    Icons.person, size: 100, color: Colors.white,),
                  new Text("个人中心", style: new TextStyle(
                      color: Colors.white,
                      fontSize: 30
                  ),)
                ],
              ),
            ),
            onTap: () async{
              int onlineStatus;
              int loginStatus=-1;
              await session.isOnline().then((onValue){
                onlineStatus = onValue;
              });
              if(onlineStatus == OperationStatus.IS_EXIST){
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new Profile()));
              } else if (onlineStatus == OperationStatus.NOT_EXIST) {
                await Navigator.push(context,
                    new MaterialPageRoute(
                        builder: (context) => new Login())).then((onValue){
                  loginStatus = onValue;
                });
                if  (loginStatus == OperationStatus.SUCCESSFUL){
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new Profile()));
                }
              }
            },
          )
        ],
      ),
    );
  }

  SliverPadding famIndexMenu(){
    return SliverPadding(
      padding: EdgeInsets.only(top: 20, left: 15, right: 15),
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
                  new Text("健康报告", style: new TextStyle(
                      color: Colors.white,
                      fontSize: 30
                  ),)
                ],
              ),
            ),
            onTap: () async{
              int onlineStatus;
              int loginStatus=-1;
              await session.isOnline().then((onValue){
                onlineStatus = onValue;
              });
              if(onlineStatus == OperationStatus.IS_EXIST){
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new HealthReport()));
              } else if (onlineStatus == OperationStatus.NOT_EXIST) {
                await Navigator.push(context,
                    new MaterialPageRoute(
                        builder: (context) => new Login())).then((onValue){
                  loginStatus = onValue;
                });
                if  (loginStatus == OperationStatus.SUCCESSFUL){
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new HealthReport()));
                }
              }
            },
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
                    size: 100, color: Colors.white,),
                  new Text("个人账单", style: new TextStyle(
                      color: Colors.white,
                      fontSize: 30
                  ),)
                ],
              ),
            ),
            onTap: () async{
              int onlineStatus;
              int loginStatus=-1;
              await session.isOnline().then((onValue){
                onlineStatus = onValue;
              });
              if(onlineStatus == OperationStatus.IS_EXIST){
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new Bill()));
              } else if (onlineStatus == OperationStatus.NOT_EXIST) {
                await Navigator.push(context,
                    new MaterialPageRoute(
                        builder: (context) => new Login())).then((onValue){
                  loginStatus = onValue;
                });
                if  (loginStatus == OperationStatus.SUCCESSFUL){
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new Bill()));
                }
              }
            },
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
                    size: 100, color: Colors.white,),
                  new Text("意见反馈", style: new TextStyle(
                      color: Colors.white,
                      fontSize: 30
                  ),)
                ],
              ),
            ),
            onTap: () async{
              int onlineStatus;
              int loginStatus=-1;
              await session.isOnline().then((onValue){
                onlineStatus = onValue;
              });
              if(onlineStatus == OperationStatus.IS_EXIST){
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new Suggestion()));
              } else if (onlineStatus == OperationStatus.NOT_EXIST) {
                await Navigator.push(context,
                    new MaterialPageRoute(
                        builder: (context) => new Login())).then((onValue){
                  loginStatus = onValue;
                });
                if  (loginStatus == OperationStatus.SUCCESSFUL){
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new Suggestion()));
                }
              }
            },
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
                  new Icon(
                    Icons.person, size: 100, color: Colors.white,),
                  new Text("个人中心", style: new TextStyle(
                      color: Colors.white,
                      fontSize: 30
                  ),)
                ],
              ),
            ),
            onTap: () {
              Navigator.push(context,
                  new MaterialPageRoute(
                      builder: (context) => new Profile())
              );
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: "智慧助手",
        home: new Scaffold(
            appBar: AppBar(title: new Text("智慧助手")),
            body: new GestureDetector(
              child:  new CustomScrollView(
                slivers: <Widget>[
                  SliverList(
                    delegate: SliverChildListDelegate([
                      new AspectRatio(aspectRatio: 1.8,
                        child: new Container(
                          child: notice(),
                        ),)
                    ]),
                  ),
                  isResident?resIndexMenu():famIndexMenu()
                ],
              ),
              onHorizontalDragCancel: (){
                int userId = db.get('userId');
                String userType = db.get('userType');
                setState(() {
                  if (userId!= null && userType == 'RESIDENT'){
                    isResident =true;
                  }
                });
                if (!locationStart){
                  locationStart = true;
//                  mapLocation.locationReport();
                }
              },
            )
        )
    );
  }
}
