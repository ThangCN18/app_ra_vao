import 'package:flutter/material.dart';
import 'package:ra_soat_ra_vao/actions/localStory.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';

import '../configs/toast_message.dart';
import '../models/user_provider.dart';

class ResetpasAction {

  static Future<void> resetPass(BuildContext context, String token, String MatKhau, Function setLoadding) async {
    try {
      String baseUrl2 = await LocalStory.getData();


      Map<String, String> body = {
        'newPassword': MatKhau
      };

      var response = await http.post(
         Uri.parse('$baseUrl2/User/change-password'),
        headers: {'Content-Type': 'application/json', 'Authorization': "Bearer " +token},
        body: jsonEncode(body)
      );
      print(response.statusCode);

      if(response.statusCode == 200){
        Provider.of<AuthProvider>(context, listen: false).logout();
          ToastMessage.showMessageSuccess(context, "Cập nhật mật khẩu thành công");
          Navigator.pushNamed(context, "/login");

      }else{
        Provider.of<AuthProvider>(context, listen: false).logout();
        ToastMessage.showMessageError(context, "Cập nhật mật khẩu không thành công");
        Navigator.pushNamed(context, "/login");
      }
    } catch (e) {
      print('Error: $e');
      Provider.of<AuthProvider>(context, listen: false).logout();
      ToastMessage.showMessageError(context, "Cập nhật mật khẩu không thành công");
      Navigator.pushNamed(context, "/login");
    }
    setLoadding();
  }
}
