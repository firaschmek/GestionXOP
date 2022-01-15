import 'package:appgestion/constant/constants.dart';
import 'package:flutter/material.dart';



class RoundButton extends StatelessWidget {
  final String title;
  final Function ajouteAlaCarte;
  const RoundButton({
    Key key,
    this.title,
    this.ajouteAlaCarte,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap:   () {
        ajouteAlaCarte();
      },
      child: Container(
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          title,
          style: kTitleStyle.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
