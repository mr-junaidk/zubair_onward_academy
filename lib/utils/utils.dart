import 'package:another_flushbar/flushbar_route.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';


class Utils{

  // TextFieldFocusChange
  static void fieldFocusChange(BuildContext context, FocusNode current, FocusNode nextFocus){
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  // ToastMessage
  static toastMessage(String message){
    Fluttertoast.showToast(msg: message);
  }

  //FlushBarMessage
  static flushBarErrorMessage(String message, BuildContext context){
    showFlushbar(context: context, flushbar: Flushbar(
      forwardAnimationCurve:Curves.decelerate,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(15),
      message: message,
      duration: const Duration(seconds: 3),
      flushbarPosition: FlushbarPosition.TOP,
      backgroundColor: Colors.red,
      reverseAnimationCurve: Curves.easeInOut,
      borderRadius: BorderRadius.circular(20),
      positionOffset: 20,
      icon: const Icon(Icons.error, size: 28, color: Colors.white),
    )..show(context),
    );
  }

  //SnackBarMessage
  static SnackBarMessage(String message, BuildContext context){
      return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: Colors.red,
            content: Text(message))
      );
  }
}

