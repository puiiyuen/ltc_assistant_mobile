import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

import '../utils/opertaion_status.dart';
import '../utils/info_config.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => new _ProfileState();
}

class _ProfileState extends State<Profile> {
  var _profilePhoto = 'images/profile.jpg';

  String path;
  Directory appDocDir;
  Dio dio = new Dio();
  CookieJar cookieJar;
  SharedPreferences db;

  _ProfileState() {
    this.getPath().then((onValue) {
      path = onValue + '/cookies';
      cookieJar = new PersistCookieJar(dir: path,ignoreExpires: true);
      dio.interceptors.add(CookieManager(cookieJar));
    });
  }

  Future<String> getPath() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    return appDocDir.path;
  }

  Container headProfile() {
    return Container(
      height: 100,
      padding: EdgeInsets.only(left: 155,right: 155),
      child: CircleAvatar(
        radius: 100,
        backgroundImage: AssetImage(_profilePhoto
        ),
      ),
    );
  }
  
  Card residentInfo(){
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.keyboard_arrow_right),
            title: Text('1903101000',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
              ),),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('张敬车',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold
            ),),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.local_hotel),
            title: Text('812',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
              ),),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.local_phone),
            title: Text('13212365986',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
              ),),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.insert_invitation),
            title: Text('1981-02-01',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
              ),),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('广东省广州市培正路149',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
              ),),
          )
        ],
      ),
    );
  }

  Card famInfo(){
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.keyboard_arrow_right),
            title: Text('1903101000',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
              ),),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('张继葱',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
              ),),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.local_phone),
            title: Text('13659954682',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
              ),),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('广东省广州市培正路五号之六',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
              ),),
          )
        ],
      ),
    );
  }

  Align logoutButton(BuildContext context) {
    return Align(
      child: SizedBox(
        height: 55.0,
        width: 270.0,
        child: RaisedButton(
            child: Text(
              '退出登录',
              style: Theme.of(context).primaryTextTheme.headline,
            ),
            color: Colors.redAccent,
            shape: StadiumBorder(),
            onPressed: () async{
              Response response;
              response = await dio.get(InfoConfig.SERVER_ADDRESS+'/logout');
              if (response.data == OperationStatus.SUCCESSFUL){
                Navigator.of(context).pop();
              }

            }
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: new Text('个人中心'),
      ),
      body: new ListView(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          headProfile(),
          Text('  住户信息',
          style: TextStyle(
            fontSize: 20
          ),),
          residentInfo(),
          SizedBox(height: 10,),
          Text('  家属信息',
            style: TextStyle(
                fontSize: 20
            ),),
          famInfo(),
          SizedBox(height: 10,),
          logoutButton(context),
          SizedBox(height: 10,)
        ],
      ),
    );
  }
}
