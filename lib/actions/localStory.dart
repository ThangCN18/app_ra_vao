import 'package:flutter/material.dart';
import 'package:ra_soat_ra_vao/configs/toast_message.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStory {

  static Future<void> saveData(String api, BuildContext context) async {
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('API', api);
    }catch(e){
      ToastMessage.showMessageError(context, e.toString());
    }
  }

  // https://10.0.2.2:7269/api

  static Future<String> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // String myStringValue = prefs.getString('API')??"https://nmcd4.hoaphatdungquat.vn/api";
    // String myStringValue = prefs.getString('API')??"https://10.0.2.2:7269/";
    String myStringValue = prefs.getString('API')??"https://apigate.hoaphatdungquat.vn:60526/api";

    return myStringValue;
  }


  static Future<void> saveUser(String mnv, String pass, BuildContext context) async {
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('mnv', mnv);
      await prefs.setString('pass', pass);
    }catch(e){
      ToastMessage.showMessageError(context, e.toString());
    }
  }

  static Future<String> getMNV() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String myStringValue = prefs.getString('mnv')??"HPDQ";

    return myStringValue;
  }
  static Future<String> getPassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String myStringValue = prefs.getString('pass')??"";

    return myStringValue;
  }
}
