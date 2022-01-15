import 'package:appgestion/constant/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'home.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            //Image.asset("images/icons/logo.png"),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(
                    "images/icons/logo.png",
                    width: 100,
                    height: 100,
                  ),
                  Text("EcommerceTn",
                    style: GoogleFonts.pacifico(
                      textStyle: TextStyle(fontSize: 40,color: Colors.white, letterSpacing: .5),
                    ),)
                ],
              ),
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(60),
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.only(left: 50.0, right: 50.0, top: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'utilisateur',
                      labelStyle: TextStyle(
                        color: kPrimaryColor,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kPrimaryColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kPrimaryColor),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10.0),
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'mot de passe',
                        labelStyle: TextStyle(
                          color: kPrimaryColor,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: kPrimaryColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: kPrimaryColor),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size.fromHeight(40),
                          primary: kPrimaryColor
                          // fromHeight use double.infinity as width and 40 is the height
                          ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Home()),
                        );

                      },
                      child: Text('LOGIN'),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
