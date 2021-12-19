import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


 class UiHelper {
   static  generateToast(String msg, Color backg, Color txtColor) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: backg,
        textColor: txtColor,
        fontSize: 16.0);
  }
}
