import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:imei_plugin/imei_plugin.dart';
import 'package:common_utils/common_utils.dart';
import 'info_config.dart';
import 'package:dio/dio.dart';

class MapLocation extends StatefulWidget{
  @override
  State<MapLocation> createState() => new _MapLocation();
  
}

class _MapLocation extends State<MapLocation>{

  var _lng,_lat,_timestamp;
  String _idfv;
  TimerUtil timerUtil;

  Response response;
  Dio dio = new Dio();

  @override
  void initState() {
    super.initState();
    _initPlatformState();
  }

  Future<void> _initPlatformState() async {
    String idfv;
    try {
      idfv = await ImeiPlugin.getImei;
    } on PlatformException {
      idfv = "cannot get idfv/imei";
    }

    if (!mounted) {
      return;
    }

    setState(() {
      _idfv = idfv;
    });
  }

  void refreshLocation(){
    int count = 0;
    //定时任务test
    timerUtil = new TimerUtil();
    timerUtil.setInterval(1000);
    timerUtil.setOnTimerTickCallback((int value) {
      getLocation();
      count++;
      LogUtil.e("TimerTick: " + value.toString()+" count: "+ count.toString());
      // add send location
      if (count == 3){
        sendLocation();
        count = 0;
      }
    });
    timerUtil.startTimer();
  }
  
  void stopRefreshLocation(){
    timerUtil.cancel();
  }

  void sendLocation () async{
    response = await dio.get(InfoConfig.SERVER_ADDRESS+"/session");
    print(response.data);
  }

  @override
  void dispose() {
    timerUtil.cancel();
    super.dispose();
  }
  
  void getLocation() async{

    Position position;
    try {
      final Geolocator geolocator = Geolocator()
        ..forceAndroidLocationManager = true;
      position = await geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.bestForNavigation);
    } on PlatformException {
      position = null;
    }

    if (!mounted) {
      return;
    }
    setState(() {
      _lng=position.longitude;
      _lat=position.latitude;
      _timestamp = position.timestamp.toLocal().millisecondsSinceEpoch.toString().substring(0,10);
    });

  }
  
  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text("nihao"),
            new Text("wohaixing$_idfv"),
            new Text("lng: $_lng, lat: $_lat"),
            new Text("time:$_timestamp"),
            new RaisedButton(onPressed: refreshLocation,
            color: Colors.blue,
            child: new Text("get location"),),
            new RaisedButton(onPressed: stopRefreshLocation,
            color: Colors.red,
            child: new Text("stop refresh"),)
          ],
        ),
      ),
    );
  }
}
