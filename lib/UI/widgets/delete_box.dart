import 'package:appgestion/constant/constants.dart';

import 'package:flutter/material.dart';



class DeleteBox extends StatelessWidget {
  DeleteBox({ Key key, this.padding = 5, this.iconSize = 18,  this.onTap}) : super(key: key);
  final double padding;
  final double iconSize;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {

    return 
      GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(padding),
          decoration: BoxDecoration(
            color: kPrimaryColor,
            shape: BoxShape.circle
          ),
          child: Icon(Icons.delete_forever, size: iconSize, color: Colors.white,)
        ),
      );
  }
}