import 'package:appgestion/constant/constants.dart';
import 'package:appgestion/models/cart_model.dart';
import 'package:appgestion/models/commande_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'custom_image.dart';
import 'delete_box.dart';



class CommandItem extends StatelessWidget {
  final CommandItemEntity data;
  final GestureTapCallback onTap;
  const CommandItem({ Key key,  this.data, this.onTap}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    var cart = context.watch<CartModel>();
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: shadowColor.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomImage(
              data.ImgSrc,
              width: 60, height:60,
              radius: 10,
            ),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data.libele,  maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                  SizedBox(height: 3,),
                  Text(data.quantity.toString()+" X "+data.price+"DT", maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 12, color: Colors.grey)),
                  SizedBox(height: 4,),

                ],
              ),
            ),
            Column(
              children: <Widget>[
                Text((data.quantity* double.parse(data.price)).toString()+"DT",  maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: kPrimaryColor)),
                SizedBox(height: 10,),
                DeleteBox(iconSize: 13, onTap: (){
                  cart.removeFromItems(data);
                },)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
