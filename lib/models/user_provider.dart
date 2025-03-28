import 'package:flutter/material.dart';
import 'package:ra_soat_ra_vao/models/user_model.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class AuthProvider with ChangeNotifier {
  User? _user = null;
  bool _isLoggedIn = false;
  User? get user => _user;
  bool get isLoggedIn => _isLoggedIn;

  void changeuser (User user){
    _user = User(
        id: user.id,
        ma_nv: user.ma_nv,
        ho_ten: user.ho_ten,
        vi_tri: user.vi_tri,
        bo_phan: user.bo_phan,
        ca_kip: user.ca_kip,
        role: user.role,
        token: user.token,
        idVaiTro: user.idVaiTro,
        idKho: user.idKho

    );
    _isLoggedIn = true;
    notifyListeners();
  }
  User? getUser(){
    return this._user;
  }

  // Future<bool> login(String username, String password) async {
  //   final String baseUrl = 'https://example.com/api';
  //   final String loginUrl = '$baseUrl/login';
  //
  //   try {
  //     final response = await http.post(
  //       Uri.parse(loginUrl),
  //       body: {
  //         'username': username,
  //         'password': password,
  //       },
  //     );
  //
  //     if (response.statusCode == 200) {
  //       final responseData = json.decode(response.body);
  //       _user = User(
  //           id: responseData.id,
  //           ma_nv: responseData.ma_nv,
  //           ho_ten: responseData.ho_ten,
  //           vi_tri: responseData.vi_tri,
  //           bo_phan: responseData.bo_phan,
  //           ca_kip: responseData.ca_kip,
  //           role: responseData.role,
  //           token: responseData.token);
  //       _isLoggedIn = true;
  //       notifyListeners();
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   } catch (e) {
  //     print('Error: $e');
  //     return false;
  //   }
  // }

  void logout() {
    _user = null;
    _isLoggedIn = false;
    notifyListeners();
  }
}