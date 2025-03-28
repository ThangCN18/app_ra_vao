import 'package:flutter/material.dart';

class CustomScaffoldLogin extends StatelessWidget {
  const CustomScaffoldLogin({super.key, required this.children});
  final Widget children;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: children,
        ),
      ),


    );
  }
}
