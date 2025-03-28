

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ra_soat_ra_vao/actions/localStory.dart';
import 'package:ra_soat_ra_vao/widgets/CustomElevatedButton.dart';
import 'package:ra_soat_ra_vao/widgets/CustomScaffoldLogin.dart';
import 'package:ra_soat_ra_vao/widgets/CustomTextFormField.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:ui';
import 'package:ra_soat_ra_vao/actions/loginAction.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}



class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formLoginKey = GlobalKey<FormState>();
  final TextEditingController _maNhanVienController = TextEditingController();
  final TextEditingController _matKhauController = TextEditingController();
  final TextEditingController _textServer = TextEditingController();
  bool loadding = false;
  String aapi = "";

  Future<void> getAPI() async {
    String baseUrl2 = await LocalStory.getData();
    setState(() {
      aapi = baseUrl2;
      _textServer.text =baseUrl2;
    });
  }
  Future<void> setAPI(api) async {
    await LocalStory.saveData(api, context);
    setState(() {
      aapi = api;
      _textServer.text =api;
    });
    Navigator.pop(context);
  }
  Future<void> getMNV() async {
    String baseUrl2 = await LocalStory.getMNV();
    setState(() {
      _maNhanVienController.text =baseUrl2;
    });
  }
  Future<void> getPass() async {
    String baseUrl2 = await LocalStory.getPassword();
    setState(() {
      _matKhauController.text = baseUrl2;
    });
  }

  Future<void> setUser(String mnv, String pass) async {
    await LocalStory.saveUser(mnv,pass, context);

  }


  void setLoadding (){
    setState(() {
      loadding = !loadding;

    });
    getAPI();

  }

  @override
  void initState() {
    _maNhanVienController.text = "HPDQ";
    getAPI();
    getMNV();
    getPass();

  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldLogin(
        children: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Form(
                key: _formLoginKey,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 70),
                      width: double.infinity,
                      height: 150,
                      child: const Image(
                        image: AssetImage("assets/images/logo.png"),
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(height: 30,),
                    CustomTextFormField(
                        name: "Mã nhân viên",
                        value_validator: "Vui lòng nhập đúng mã nhân viên",
                        bool_obscureText: false,
                        textController: _maNhanVienController
                    ),
                    SizedBox(height: 30,),
                    CustomTextFormField(
                        name: "Mật Khẩu",
                        value_validator: "Vui lòng nhập đúng mật khẩu",
                        bool_obscureText: true,
                        textController: _matKhauController
                    ),
                    SizedBox(height: 60,),
                    CustomElevatedButton(
                      loading: loadding,
                      value: "Đăng Nhập",
                      onPressed: (){
                        // Navigator.pushNamed(context, "/");
                        if(!loadding) {
                          if (_formLoginKey.currentState!.validate()) {
                            setLoadding();
                            setUser(_maNhanVienController.text, _matKhauController.text);
                            LoginAction.login(context, _maNhanVienController.text, _matKhauController.text, setLoadding);
                            // Navigator.pushNamed(context, '/');
                          }
                        }
                      },
                    ),
                    SizedBox(height: 10,),



                        Text(aapi),
                    ElevatedButton(
                      onPressed: () {

                          showModalBottomSheet<void>(
                            context: context,
                            isScrollControlled: true, // Ensures the sheet covers the whole screen
                            builder: (BuildContext context) {
                              return DraggableScrollableSheet(


                                initialChildSize: 0.7, // Adjust as needed
                                minChildSize: 0.3, // Adjust as needed
                                maxChildSize: 0.9, // Adjust as needed
                                builder: (BuildContext context, ScrollController scrollController) {
                                  return Container(
                                    padding: EdgeInsets.all(16.0),

                                    child: Column(

                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                      TextField(
                                      controller: _textServer,
                                      decoration: InputDecoration(
                                        labelText: 'Nhập Link Server',
                                        labelStyle: TextStyle(
                                          color: Colors.black87,
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(20),
                                        ),

                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(20),

                                        ),



                                      ),

                                      ),
                                        SizedBox(height: 30,),
                                        ElevatedButton(
                                          onPressed: () =>{
                                            setAPI(_textServer.text)
                                          },
                                          style: ButtonStyle(
                                            backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                                            minimumSize: MaterialStateProperty.all<Size>(Size(double.infinity, 64)),
                                          ),
                                          child: Text('Cấu hình', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          );

                      },
                      child: const Text(
                        'Config server',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),

                    SizedBox(height: 10,),
                    Center(
                      child: Text(
                          "Liên hệ để được giúp đỡ"
                      ),
                    ),
                    Center(
                      child: Text(
                        "nguyenchithang@hoaphat.com.vn", style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),

                  ],
                ),
              )),
        ));
  }
}



