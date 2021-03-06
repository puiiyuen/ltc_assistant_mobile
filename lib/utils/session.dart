import 'dart:io';
import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'opertaion_status.dart';
import 'info_config.dart';

class Session {

  Dio dio = new Dio();
  String path;
  Directory appDocDir;
  CookieJar cookieJar;
  SharedPreferences db;

  Session() {
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

  Future<int> isOnline() async {
    Response response = await dio.get(InfoConfig.SERVER_ADDRESS + '/session');
    Response user;
    if (response.data == OperationStatus.IS_EXIST) {
      db = await SharedPreferences.getInstance();
      user = await dio.get(InfoConfig.SERVER_ADDRESS+'/user');
      db.setInt('userId', user.data['userId']);
      return OperationStatus.IS_EXIST;
    } else {
      return OperationStatus.NOT_EXIST;
    }
  }

}