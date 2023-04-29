import 'dart:convert';
import 'package:crafty_bay/getx/user_data_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

class NetworkUtils{

  final UserDataController userDataController = Get.put(UserDataController());

  //get method for http request
  Future<dynamic> getMethod(String url, {VoidCallback? onUnAuthorized}) async{
    try{
      Uri uri = Uri.parse(url);
      final response = await get(uri, headers: {'token': userDataController.userToken?? ''});
      print(response.body);
      if (response.statusCode == 200){
        return jsonDecode(response.body);
      } else if (response.statusCode == 401){
        if (onUnAuthorized != null){
          onUnAuthorized();
        }
      } else {
        print('status code ${response.statusCode}');
      }
    }catch (e) {
      print(e);
    }
  }

// post method for http request
   Future<dynamic> postMethod(String url, {VoidCallback? onUnAuthorized, Map <String, String>? body}) async{
    try{
      Uri uri = Uri.parse(url);
      final response = await post(uri, headers: {"Content-type": "application/json",
       'token': userDataController.userToken?? ''},
        body: jsonEncode(body));
      print(response.body);
      if (response.statusCode == 200){
        return jsonDecode(response.body);
      } else if (response.statusCode == 401){
        // if (onUnAuthorized != null){
        //   onUnAuthorized();
        // }
        if (userDataController.userToken != null){
          await userDataController.Logout();
        }
        userDataController.redirectUnAuthenticateUser();
      } else {
        print('status code ${response.statusCode}');
      }
    }catch (e) {
      print(e);
    }
  }
}


