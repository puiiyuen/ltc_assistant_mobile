import 'dart:io';
import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geolocator/geolocator.dart';

import '../utils/opertaion_status.dart';
import '../utils/info_config.dart';
import '../utils/map_location.dart';

class SosService {
  String path;
  Directory appDocDir;
  Dio dio = new Dio();
  CookieJar cookieJar;
  SharedPreferences db;
  Position sosPosition;
  Response response;
  MapLocation mapLocation = new MapLocation();


  Future<int> sendSos() async {
    int tryGetSosLocation = 0;
    //fetch userId
    db = await SharedPreferences.getInstance();
    int userId = db.get('userId');
    String userType = db.get('userType');
    if (userId != null && userType == 'RESIDENT') {
      //fetch location
      while (tryGetSosLocation < 3) {
        mapLocation.setLocation().then((location) {
          sosPosition = location;
        });
        tryGetSosLocation++;
        if (sosPosition != null) {
          tryGetSosLocation = 0;
          break;
        }
      }

      if (tryGetSosLocation >= 3 || sosPosition == null) {
        return OperationStatus.FAILED;
      }
      SosInfo sosInfo = new SosInfo(
          userId,
          sosPosition.longitude.toString(),
          sosPosition.latitude.toString(),
          sosPosition.timestamp.millisecondsSinceEpoch
              .toString()
              .substring(0, 10));
      String postData = json.encode(sosInfo);
      Response response;
      response = await dio.post(InfoConfig.SERVER_ADDRESS + '/security/sos',
          data: postData);
      if(response.data!=OperationStatus.SUCCESSFUL){
        return OperationStatus.FAILED;
      } else {
        return OperationStatus.SUCCESSFUL;
      }
    } else {
      return OperationStatus.NOT_EXIST;
    }
  }
}

class SosInfo {
  dynamic userId;
  String longitude;
  String latitude;
  String timestamp;

  SosInfo(this.userId, this.longitude, this.latitude, this.timestamp);

  SosInfo.fromJson(Map<String, dynamic> json)
      : userId = json['userId'],
        longitude = json['longitude'],
        latitude = json['latitude'],
        timestamp = json['timestamp'];

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'longitude': longitude,
        'latitude': latitude,
        'timestamp': timestamp,
      };
}
