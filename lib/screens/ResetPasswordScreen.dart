
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ra_soat_ra_vao/actions/resetpassAction.dart';
import 'package:ra_soat_ra_vao/widgets/CustomElevatedButton.dart';
import 'package:ra_soat_ra_vao/widgets/CustomScaffoldLayout.dart';
import 'package:ra_soat_ra_vao/widgets/CustomScaffoldLogin.dart';
import 'package:ra_soat_ra_vao/widgets/CustomTextFormField.dart';
import 'dart:ui';
import 'package:ra_soat_ra_vao/actions/loginAction.dart';
import 'package:provider/provider.dart';

import '../models/user_model.dart';
import '../models/user_provider.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
   final GlobalKey<FormState> _formResetPassKey = GlobalKey<FormState>();
   final TextEditingController _matKhauMoiController = TextEditingController();
   final TextEditingController _reMatKhauController = TextEditingController();
   bool show01 = true;
   bool show02 = true;

  User? user;
  bool loadding = false;
   @override
   void initState() {
     super.initState();
     setState(() {
       user = Provider.of<AuthProvider>(context, listen: false).user;
     });
     // Use a post-frame callback to ensure the context is valid
     // WidgetsBinding.instance!.addPostFrameCallback((_) {
     //
     //   if (user == null) {
     //     Navigator.pushReplacementNamed(context, "/login");
     //     // or Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
     //   } else {
     //     print("User is logged in.");
     //   }
     // });
   }
  void setloadding(){
    setState(() {
      loadding = !loadding;
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
         appBar: AppBar(backgroundColor: Color(0xffd8ebf2) ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          color: Color(0xffd8ebf2),

          child: Padding(
           padding: EdgeInsets.all(20),

            child: SingleChildScrollView(
              child:

                Form(
                  key: _formResetPassKey,
                  child: Column(
                    children: [
                      SizedBox(height: 80,),
                      Text("THAY ĐỔI MẬT KHẨU",style: TextStyle(color: Color(0xff194689), fontSize: 24, fontFamily: "RobotoBold"),),
                      SizedBox(height: 80,),

                      Stack(
                        children: [
                          TextFormField(
                            controller: _matKhauMoiController,
                            obscureText: show01,
                            obscuringCharacter: "*",
                            validator: (value) {
                              if (value == null || value.isEmpty || value.length <=5) {
                                return "Mật khẩu mới tổi thiểu có 6 ký tự";
                              }
                              return null;
                            },
                            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontFamily: "Roboto", fontSize: 18),
                            onChanged: (value) {
                              // Update the value of the controller
                              _matKhauMoiController.text = value;
                              _formResetPassKey.currentState?.validate();
                            },
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                hintText: "Mật khẩu mới",
                                hintStyle: const TextStyle(color: Colors.black54, fontWeight: FontWeight.w500, fontFamily: "Roboto", fontSize: 18),
                                contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: const BorderSide(width: 1, color: Colors.white),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: const BorderSide(color: Colors.white),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                errorStyle: const TextStyle(color: Colors.red, fontWeight: FontWeight.w500, fontFamily: "Roboto", fontSize: 16)),
                          ),

                            Positioned(
                              right: 10,
                              top: 10,
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    show01 = !show01;
                                  });
                                },
                                icon: show01 ?  FaIcon(FontAwesomeIcons.eyeSlash, size: 20,) : FaIcon(FontAwesomeIcons.eye, size: 20,),
                              ),
                            )
                        ],
                      ),
                      SizedBox(height: 25,),
                      Stack(
                        children: [
                          TextFormField(
                            controller: _reMatKhauController,
                            obscureText: show02,
                            obscuringCharacter: "*",
                            validator: (value) {
                              if (value == null || value.isEmpty || value != _matKhauMoiController.text) {
                                return "Nhập đúng mật khẩu";
                              }
                              return null;
                            },
                            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontFamily: "Roboto", fontSize: 18),
                            onChanged: (value) {
                              // Update the value of the controller
                              _reMatKhauController.text = value;
                              _formResetPassKey.currentState?.validate();
                            },
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                hintText: "nhập lại mật khẩu",
                                hintStyle: const TextStyle(color: Colors.black54, fontWeight: FontWeight.w500, fontFamily: "Roboto", fontSize: 18),
                                contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: const BorderSide(width: 1, color: Colors.white),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: const BorderSide(color: Colors.white),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                errorStyle: const TextStyle(color: Colors.red, fontWeight: FontWeight.w500, fontFamily: "Roboto", fontSize: 16)),
                          ),

                          Positioned(
                            right: 10,
                            top: 10,
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  show02 = !show02;
                                });
                              },
                              icon: show02 ?  FaIcon(FontAwesomeIcons.eyeSlash, size: 20,) : FaIcon(FontAwesomeIcons.eye, size: 20,),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height:80,),
                      CustomElevatedButton(value: "Cập nhật", onPressed: (){
                        if(!loadding) {
                          if (_formResetPassKey.currentState!.validate()) {
                            setloadding();
                            ResetpasAction.resetPass(context, user?.token??"", _matKhauMoiController.text, setloadding);
                          }
                        }
                      }, loading: loadding)
                    ],
                  ),
                )

            ),
          ),
        )
    );
  }
}



