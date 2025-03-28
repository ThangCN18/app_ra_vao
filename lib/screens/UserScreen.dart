import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ra_soat_ra_vao/actions/loginAction.dart';
import 'package:ra_soat_ra_vao/models/user_model.dart';
import 'package:ra_soat_ra_vao/models/user_provider.dart';
import 'package:ra_soat_ra_vao/widgets/CustomScaffoldLayout.dart';
import 'package:provider/provider.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {

  @override
  void initState() {
    super.initState();

    // Use a post-frame callback to ensure the context is valid
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      User? user = Provider.of<AuthProvider>(context, listen: false).user;
      if (user == null) {
        Navigator.pushReplacementNamed(context, "/login");
        // or Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
      } else {
        print("User is logged in.");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<AuthProvider>(context, listen: false).user;
    return CustomScaffoldLayout(
        selected: 4,
        children: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: 350,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
                color: Colors.blue,
              ),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 50),
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60),
                        color: Colors.white
                    ),
                    child: Image(
                      image: AssetImage("assets/images/logo.png"),
                      fit: BoxFit.contain,
                      height: 120,
                    ),
                  ),

                  const SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: Text(
                      user?.ho_ten ??
                          "NGUYỄN CHÍ THẮNG",
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: "RobotoBold",
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text(
                      user?.ma_nv ??
                          "HPDQ26802",
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: "Roboto",
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text(
                      user?.bo_phan ??
                          "",
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: "Roboto",
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),


            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Column(

                children: [
                  ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                        minimumSize: MaterialStateProperty.all<Size>(Size(double.infinity, 60)),
                      ),
                      onPressed: (){

                      },

                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          Text(
                            'Giúp đỡ',
                            style: TextStyle(fontFamily: "Roboto", fontSize: 16, color: Colors.black),
                          ),
                        ],
                      ))

                ],
              ),
            ),
            SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Column(

                children: [
                  ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                        minimumSize: MaterialStateProperty.all<Size>(Size(double.infinity, 60)),
                      ),
                      onPressed: (){
                        Navigator.pushNamed(context, '/resetpass');
                      },

                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          Text(
                            'Thay đổi mật khẩu',
                            style: TextStyle(fontFamily: "Roboto", fontSize: 16, color: Colors.black),
                          ),
                        ],
                      ))

                ],
              ),
            ),
            SizedBox(height: 15,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Column(

                children: [
                  ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                        minimumSize: MaterialStateProperty.all<Size>(Size(double.infinity, 60)),
                      ),
                      onPressed: (){
                        Provider.of<AuthProvider>(context, listen: false).logout();
                        bool loginaa = Provider.of<AuthProvider>(context, listen: false).isLoggedIn;
                        print(loginaa);
                        Navigator.pushNamed(context, '/login');
                      },

                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FaIcon(FontAwesomeIcons.signOut, color: Colors.red),
                          SizedBox(width: 10), // Khoảng cách giữa icon và tiêu đề
                          Text(
                            'Đăng xuất',
                            style: TextStyle(fontFamily: "Roboto", fontSize: 16, color: Colors.black),
                          ),
                        ],
                      ))

                ],
              ),
            ),
            SizedBox(height: 15,),


          ],
        ));
  }
}


