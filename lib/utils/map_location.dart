import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:common_utils/common_utils.dart';
import 'package:ltc_assistant/utils/info_config.dart';
import 'package:imei_plugin/imei_plugin.dart';
import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';

class MapLocation {
  MapLocation({this.interval = Duration.millisecondsPerSecond,
    this.totalTime});

  int interval;
  int totalTime;
  Position _position;
  TimerUtil timerUtil;
  Response response;
  Dio dio = new Dio();
  LocationPack _locationPack;
  List<LocationPack> _locationList;


  void refreshLocation(){
    int count = 0;
    int nullPositionCount = 0;

    //定时任务
    timerUtil = new TimerUtil();
    timerUtil.setInterval(1000);

    _locationList = new List<LocationPack>();
    timerUtil.setOnTimerTickCallback((int value) {
      setLocation();
      if(_position == null){
        nullPositionCount ++;
      } else {
        _locationPack = new LocationPack(
            '1903091000',
            _position.longitude.toString(),
            _position.latitude.toString(),
            _position.timestamp.millisecondsSinceEpoch
            .toString()
            .substring(0, 10));
        _locationList.add(_locationPack);
        count++;
      }

      if(nullPositionCount >= 10){
        // failed to get position
        count = 0;
        nullPositionCount = 0;
        stopRefreshLocation();
      }

      if (count == 3) {
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
    var imei = await ImeiPlugin.getImei;
    print(imei);
    print(postData);
    _locationList = new List<LocationPack>();
    response = await dio.post(InfoConfig.SERVER_ADDRESS+"/location/collect",
        data: postData);
    print(response.data);
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

  Position getLocation() {
    setLocation();
    return _position;
  }
}

class LocationPack {
  String userId;
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
