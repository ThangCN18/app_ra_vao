
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ra_soat_ra_vao/actions/localStory.dart';
import 'package:ra_soat_ra_vao/models/user_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ra_soat_ra_vao/configs/toast_message.dart';

import 'package:provider/provider.dart';

import '../models/user_model.dart';

class LoginAction {
  static const String baseUrl = 'https://nmcd4.hoaphatdungquat.vn/api';

  static Future<void> login(BuildContext context,String username, String password, Function setLoadding) async {

    try {

      String baseUrl2 = await LocalStory.getData();

      Map<String, String> body = {
        'maNV': username,
        'password': password,
      };

      var response = await http.post(
        Uri.parse('$baseUrl2/user/login'),
        body: json.encode(body),
        headers: {'Content-Type': 'application/json'},
      );
      print(Uri.parse('$baseUrl2/User/login'));
      print(json.encode(body));
      print(response.statusCode);

      if(response.statusCode == 200){
        print(response.body);
        Map<String, dynamic> responseData = json.decode(response.body);
        // // Map<String, dynamic> header = response.headers;
         String token = responseData['token'].toString();
        String id = responseData['user']['id'].toString();
        // //
        String ma_nv = responseData['user']['maNhanVien'].toString();
        String ho_ten = responseData['user']['hoTen'].toString();
        String vi_tri = responseData['user']['idKho'].toString();
        String bo_phan = responseData['role']['tenBoPhan'].toString();
        String ca_kip = responseData['user']['caKip'].toString();
        String role = responseData['role']['idVaiTro'].toString();
        int idVaiTro = responseData['user']['idVaiTro']??0;
        int idKho = responseData['user']['idKho']??0;
         User user = User(
            id: int.parse(id),
            ma_nv: ma_nv,
            ho_ten: ho_ten,
            vi_tri: vi_tri,
            bo_phan: bo_phan,
            ca_kip: ca_kip,
            role: role,
            token: token,
           idKho: idKho,
           idVaiTro: idVaiTro,
        );
         if(user.idVaiTro == 3 || user.idVaiTro ==2 || user.idVaiTro ==5 ){
           Provider.of<AuthProvider>(context, listen: false).changeuser(user);


           bool islogin = Provider.of<AuthProvider>(context, listen: false).isLoggedIn;
           if(islogin){
             Navigator.pushNamed(context, "/");
           }
         }else{
           ToastMessage.showMessageError(context, "Bạn không có quyền đăng nhập trên App!");
         }

      }else{
        Map<String, dynamic> responseData = json.decode(response.body);
        String message = responseData['message'].toString();
        ToastMessage.showMessageError(context, "Mã nhân viên hoặc mậk khẩu không chính xác");

      }
         } catch (e) {
      print('Error: $e');
      ToastMessage.showMessageError(context, "Đã xảy ra lỗi vui lòng thử lại sau");
    }
    setLoadding();
  }
  static void logout(BuildContext context) {

    Provider.of<AuthProvider>(context, listen: false).logout();
    Navigator.pushNamed(context, "/login");
  }

}