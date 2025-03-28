import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ra_soat_ra_vao/models/user_provider.dart';
import 'package:ra_soat_ra_vao/widgets/DrawerWidget.dart';

class CustomScaffoldLayout extends StatelessWidget {
  CustomScaffoldLayout({super.key, required this.children, required this.selected});
  final Widget children;
  final int selected;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<AuthProvider>(context, listen: false).user;
    return  Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          shadowColor: const Color(0xff194689),
          leading: IconButton(
            icon: const Icon(Icons.menu, size: 45, ), // Set the icon to use for the drawer
            color: const Color(0xff194689), // Set the color of the icon
            onPressed: () {
              _scaffoldKey.currentState!.openDrawer(); // Open the drawer when the icon is pressed
            },
          ),


          actions: [
            Container(
              margin: const EdgeInsets.only(top: 10),
              width: 100,
              child: const Image(
                image: AssetImage("assets/images/logo.png"),
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: children,
        ),

        drawer: const CustomDrawer(),
        bottomNavigationBar: BottomNavigationBar(


          selectedItemColor: const Color(0xff194689),
          currentIndex: selected,
          unselectedItemColor: const Color(0x74474747),
          unselectedLabelStyle: const TextStyle(
            fontSize: 12
          ),
          selectedLabelStyle: const TextStyle(
              fontSize: 12
          ),
    showUnselectedLabels: true,
    onTap: (int index){

              switch (index){
                case 0 : if(selected!=0){Navigator.pushNamed(context, '/'); break;}else{break;}
                case 1 : if(selected!=1){Navigator.pushNamed(context, '/checking'); break;}else{break;}
                case 2 : if(selected!=2){Navigator.pushNamed(context, '/history'); break;}else{break;}
                case 3 : if(selected!=3){Navigator.pushNamed(context, '/historyravao'); break;}else{break;}
                case 4 : if(selected!=4){Navigator.pushNamed(context, '/user'); break;}else{break;}
              }


    },

    items:  [
      BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.house, size: 25), label: "Trang chủ"),
          BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.truck, size: 25,), label: "Xác nhận"),
      BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.history, size: 25,), label: "LS chuyến"),
      BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.history, size: 25,), label: "LS ra/vào"),
      BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.user), label: "Người dùng"),

    ]

          ,
    ),
    );
  }
}
