import 'dart:io';
import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:path_provider/path_provider.dart';

import '../utils/opertaion_status.dart';
import '../utils/info_config.dart';

class LoginService {
  String path;
  Directory appDocDir;
  Dio dio = new Dio();
  CookieJar cookieJar;

  LoginService() {
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

  Future<int> login(String loginId, String password) async {
    LoginInfo loginInfo = new LoginInfo(loginId, password);
    String postData = json.encode(loginInfo);
    Response response;
    response =
    await dio.post(InfoConfig.SERVER_ADDRESS + '/login', data: postData);
    if (response.data == OperationStatus.SUCCESSFUL) {
      return OperationStatus.SUCCESSFUL;
    } else {
      return response.data;
    }
  }
}

class LoginInfo {
  String userId;
  String password;

  LoginInfo(this.userId, this.password);

  Map<String, dynamic> toJson() => {'userId': userId, 'password': password};
}
