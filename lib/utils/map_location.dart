import 'dart:io';
import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:common_utils/common_utils.dart';
import 'package:ltc_assistant/utils/info_config.dart';
import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'session.dart';
import 'opertaion_status.dart';

class MapLocation {

  int interval;
  int totalTime;
  Position _position;
  TimerUtil timerUtil= new TimerUtil();
  TimerUtil sessionTimer;
  Response response;
  Dio dio = new Dio();
  LocationPack _locationPack;
  List<LocationPack> _locationList;
  String path;
  Directory appDocDir;
  CookieJar cookieJar;
  Session session = new Session();
  SharedPreferences db;

  MapLocation(){
    this.getPath().then((onValue) {
      path = onValue + '/cookies';
      cookieJar = new PersistCookieJar(dir: path,ignoreExpires: true);
      dio.interceptors.add(CookieManager(cookieJar));
    });
  }

  Future<String> getPath() async {
    db = await SharedPreferences.getInstance();
    Directory appDocDir = await getApplicationDocumentsDirectory();
    return appDocDir.path;
  }

  void locationReport(){
    sessionTimer = new TimerUtil();
    sessionTimer.setInterval(5*1000);
    sessionTimer.setOnTimerTickCallback((int value) async{
      int onlineStatus = await session.isOnline();
      if(onlineStatus == OperationStatus.IS_EXIST){
        refreshLocation();
        print('exist test location report');
        sessionTimer.cancel();
      } else if (onlineStatus == OperationStatus.NOT_EXIST){
        print('not exist');
        stopRefreshLocation();
      }
    });
    sessionTimer.startTimer();
  }


  void refreshLocation() {
    int count = 0;
    int nullPositionCount = 0;

    //定时任务
    timerUtil.setInterval(10000);

    _locationList = new List<LocationPack>();
    timerUtil.setOnTimerTickCallback((int value) {
      setLocation();
      if (_position == null) {
        nullPositionCount ++;
      } else {
        _locationPack = new LocationPack(
            db.get('userId'),
            _position.longitude.toString(),
            _position.latitude.toString(),
            _position.timestamp.millisecondsSinceEpoch
                .toString()
                .substring(0, 10));
        _locationList.add(_locationPack);
        count++;
      }

      if (nullPositionCount >= 10) {
        // failed to get position
        count = 0;
        nullPositionCount = 0;
        stopRefreshLocation();
      }

      if (count == 1) {
        sendLocation();
        count = 0;
        //stopRefreshLocation();
      }
    });
    timerUtil.startTimer();
  }

  void stopRefreshLocation() {
    timerUtil.cancel();
    _position = null;
    _locationPack = null;
    _locationList = null;
  }

  void sendLocation() async {
    String postData = json.encode(_locationList);
    _locationList = new List<LocationPack>();
    response = await dio.post(InfoConfig.SERVER_ADDRESS + "/location/collect",
        data: postData);
    if(response.data != OperationStatus.SUCCESSFUL){
      locationReport();
    }
  }

  void setLocation() async {
    try {
      final Geolocator geolocator = Geolocator()
        ..forceAndroidLocationManager = true;
      _position = await geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.bestForNavigation);
    } on PlatformException {
      _position = null;
    }
  }

}

class LocationPack {
  dynamic userId;
  String longitude;
  String latitude;
  String timestamp;

  LocationPack(this.userId,this.longitude, this.latitude, this.timestamp);

  LocationPack.fromJson(Map<String, dynamic> json)
      : userId = json['userId'],
        longitude = json['longitude'],
        latitude = json['latitude'],
        timestamp = json['timestamp'];

  Map<String, dynamic> toJson() => {
        'userId':userId,
        'longitude': longitude,
        'latitude': latitude,
        'timestamp': timestamp,
      };
}
