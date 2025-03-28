import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ra_soat_ra_vao/models/user_provider.dart';

import '../actions/loginAction.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<AuthProvider>(context, listen: false).user;
    return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          
          width: double.infinity,
          height: 220,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color(0x101B4A9B),
              Color(0x1052a1cb),
            ],
          )),
          child: const Column(
            children: [
              Image(
                  image: AssetImage("assets/images/logo.png"),
                  fit: BoxFit.contain,
                height: 120,
                ),

              Text(
                "CÔNG TY CP THÉP HPDQ",
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: "RobotoBold",

                  color: Color(0xff194689),),
              ),
              SizedBox(height: 6,),
              Text(
                "RÀ SOÁT NHU CẦU RA VÀO CỔNG",
                style: TextStyle(
                  fontSize: 13,
                  fontFamily: "RobotoBold",
                  color: Color(0xff077b9a),),
              ),

            ],
          ),
        ),
        SizedBox(height: 20,),
        ListTile(
          leading: FaIcon(FontAwesomeIcons.house),
          title: const Text('Trang chủ', style: TextStyle(fontFamily: "Roboto", fontSize: 16),),
          onTap: () {
            Navigator.pushNamed(context, '/');
          },
        ),

        ListTile(
          leading: FaIcon(FontAwesomeIcons.truck),
          title: const Text('Xác nhận chuyến', style: TextStyle(fontFamily: "Roboto", fontSize: 16),),
          onTap: () {
            Navigator.pushNamed(context, '/checking');
          },
        ),
        ListTile(
          leading: FaIcon(FontAwesomeIcons.history),
          title: const Text('Lịch sử chuyến', style: TextStyle(fontFamily: "Roboto", fontSize: 16),),
          onTap: () {
            Navigator.pushNamed(context, '/history');
          },
        ),
        ListTile(
          leading: FaIcon(FontAwesomeIcons.history),
          title: const Text('Lịch sử ra/vào', style: TextStyle(fontFamily: "Roboto", fontSize: 16),),
          onTap: () {
            Navigator.pushNamed(context, '/historyravao');
          },
        ),

        ListTile(
          leading: FaIcon(FontAwesomeIcons.user),
          title: const Text('Người dùng', style: TextStyle(fontFamily: "Roboto", fontSize: 16),),
          onTap: () {
            Navigator.pushNamed(context, '/user');
          },
        ),
        ListTile(

          leading: FaIcon(FontAwesomeIcons.signOut, color: Colors.red,),
          title: const Text('Đăng xuất', style: TextStyle(fontFamily: "Roboto", fontSize: 16),),
          onTap: () {
            LoginAction.logout(context);
          },
        ),
      ],
    ));
  }
}
