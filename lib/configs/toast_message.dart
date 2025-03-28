import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastMessage {

  static void showMessageSuccess(BuildContext context, String message) {
    FToast fToast;
    fToast = FToast();

    fToast.init(context);

    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.green,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check, color: Colors.white),
          SizedBox(width: 12.0),
          Text(
            message,
            style: TextStyle(color: Colors.white, fontSize: 15, fontFamily: "Roboto"),
          ),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      toastDuration: Duration(seconds: 2),
      positionedToastBuilder: (context, child, gravity) {
        return Positioned(
          child: child,
          top: 40,
          right: 10.0,
        );
      },
    );
  }

  static void showMessageError(BuildContext context, String message) {
    FToast fToast;
    fToast = FToast();

    fToast.init(context);

    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.red,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.error, color: Colors.white),
          SizedBox(width: 12.0),
          Text(
            message,
            style: TextStyle(color: Colors.white, fontSize: 15, fontFamily: "Roboto"),
          ),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      toastDuration: Duration(seconds: 2),
      positionedToastBuilder: (context, child, gravity) {
        return Positioned(
          child: child,
          top: 40,
          right: 10.0,
        );
      },
    );
  }

  static void showLoading(BuildContext context) {
    FToast fToast;
    fToast = FToast();

    fToast.init(context);

    Widget toast = Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Color(0x90dbdbdb),
      ),
      child: Center(
        child: CircularProgressIndicator(color: Colors.blue),
      ),
    );

    fToast.showToast(
      child: toast,
      toastDuration: Duration(seconds: 2),
      positionedToastBuilder: (context, child, gravity) {
        return Positioned(
          child: child,
          top: 0,
          right: 0,
        );
      },
    );
  }
}
