import 'package:appgestion/constant/constants.dart';
import 'package:appgestion/model/cart_model.dart';
import 'package:appgestion/pages/command_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/src/provider.dart';

class UiHelper {
  static generateToast(String msg, Color backg, Color txtColor) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: backg,
        textColor: txtColor,
        fontSize: 16.0);
  }

  static AppBar createAppBar(BuildContext context) {
    var cart = context.watch<CartModel>();
    return AppBar(
      backgroundColor: Colors.blue,
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset(
          'assets/icons/back.svg',
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: <Widget>[
        Stack(
          children: <Widget>[
            Container(
                width: 20,
                height: 20,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(cart.item_count.toString()),
                  ],
                )),
            IconButton(
              icon: SvgPicture.asset("assets/icons/cart.svg"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CommandScreen()),
                );
              },
            )
          ],
        ),
        SizedBox(width: kDefaultPaddin / 2)
      ],
    );
  }
}
