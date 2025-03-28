import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ra_soat_ra_vao/models/user_model.dart';
import 'package:ra_soat_ra_vao/screens/CheckingDevicesScreen.dart';
import 'package:ra_soat_ra_vao/screens/DetailHistoryScreen.dart';
import 'package:ra_soat_ra_vao/screens/DetailShipScreen.dart';
import 'package:ra_soat_ra_vao/screens/HistoryRaVaoScreen.dart';
import 'package:ra_soat_ra_vao/screens/HistoryScreen.dart';
import 'package:ra_soat_ra_vao/screens/HomeScreen.dart';
import 'package:ra_soat_ra_vao/screens/LoginScreen.dart';
import 'package:ra_soat_ra_vao/screens/ResetPasswordScreen.dart';
import 'package:ra_soat_ra_vao/screens/UserScreen.dart';
import 'package:provider/provider.dart';

import 'models/user_provider.dart';

void main() {
  // HttpOverrides.global = new MyHttpOverrides();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MyApp(),
    ),
  );

}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<AuthProvider>(context, listen: false).user;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: "Roboto",
        textSelectionTheme: TextSelectionThemeData(

            cursorColor: Colors.blue,
            selectionColor: Colors.blue,
            selectionHandleColor: Colors.blue
        ),
      ),

      routes:{
        '/login': (context) => LoginScreen(),
        '/checking': (context) => CheckingDevicesScreen(),
        '/user': (context) => UserScreen(),
        '/resetpass': (context) => ResetPasswordScreen(),
        '/detailship': (context) => DetailShipScreen(),
        '/detailhistoryship': (context) => DetailHistoryScreen(),
        '/history': (context) => HistoryScreen(),
        '/historyravao': (context) => HistoryRaVaoScreen(),
        '/': (context) => HomeScreen()

      },
      initialRoute: "/login",
      builder: FToastBuilder(),
    );
  }
}



// class MyHttpOverrides extends HttpOverrides{
//   @override
//   HttpClient createHttpClient(SecurityContext? context)
//   { return super.createHttpClient(context) ..badCertificateCallback =
//   (X509Certificate cert, String host, int port) => true; }
// }

