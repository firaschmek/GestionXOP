
import 'package:appgestion/model/SousFamille.dart';
import 'package:flutter/material.dart';


import 'package:appgestion/constant/constants.dart';


class SousFamilleItemCard extends StatelessWidget {
  final SousFamille sou_famille;
  final Function press;
  const SousFamilleItemCard({
    Key key,
    this.sou_famille,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(kDefaultPaddin),
              margin: const EdgeInsets.all(5.0),
              // For  demo we use fixed height  and width
              // Now we dont need them
              // height: 180,
              // width: 160,
              decoration: BoxDecoration(

                color: Colors.white,
                border:  Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(16),

              ),
              child: Hero(
                tag: "${sou_famille.lib_sfam}",
                child: Image.asset('images/familles/sousFamille.png'),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 50.0),

            child: Text(
              // products is out demo list
              sou_famille.lib_sfam,
              style: TextStyle(color: kTextLightColor, ),
            ),
          ),
          //Text(
          //  "${product.price} DT",
          //  style: TextStyle(fontWeight: FontWeight.bold),
         // )
        ],
      ),
    );
  }
}
