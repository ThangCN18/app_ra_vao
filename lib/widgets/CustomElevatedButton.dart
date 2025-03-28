import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({super.key, required this.value, required this.onPressed, required this.loading});
  final String value;
  final VoidCallback onPressed;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
        minimumSize: MaterialStateProperty.all<Size>(Size(double.infinity, 64)),
      ),
      onPressed: onPressed,
      child: loading? CircularProgressIndicator(color: Colors.white,) :Text(value, style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: "Roboto", fontWeight: FontWeight.bold),),

    );
  }
}
