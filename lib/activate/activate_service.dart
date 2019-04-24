import 'dart:io';
import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';

import '../utils/opertaion_status.dart';
import '../utils/info_config.dart';

class ActivateService{

  Dio dio =new Dio();

  Future<int> activate(String userId,String password,String activateCode) async{
      ActivateInfo activateInfo = new ActivateInfo(userId, password, activateCode);
      String postData = json.encode(activateInfo);
      Response response =
          await dio.post(InfoConfig.SERVER_ADDRESS+'/activate',data: postData);
      if(response.data == OperationStatus.SUCCESSFUL){
        return OperationStatus.SUCCESSFUL;
      } else {
        return response.data;
      }

  }

}

class ActivateInfo {
  String userId;
  String password;
  String activateCode;

  ActivateInfo(this.userId,this.password,this.activateCode);

  Map<String,dynamic> toJson() => {'userId':userId,'password':password,
    'activateCode':activateCode};

}