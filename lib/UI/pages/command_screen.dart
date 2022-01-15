import 'package:appgestion/UI/widgets/command_item.dart';
import 'package:appgestion/constant/constants.dart';
import 'package:appgestion/models/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class CommandScreen extends StatefulWidget {
  const CommandScreen({Key key}) : super(key: key);

  @override
  State<CommandScreen> createState() => _CommandScreenState();
}

class _CommandScreenState extends State<CommandScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cart = context.watch<CartModel>();
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 15, right: 15, top: 40),
            child: Text(
              "Sous-total   ${cart.sousTotal()} DT ",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: 10.0,left: 10.0,right: 10.0,bottom: 10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(primary: kPrimaryColor
                  // fromHeight use double.infinity as width and 40 is the height
                  ),
              onPressed: () {},
              child: Text('Passer la commande (${cart.item_count} articles)'),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.only(left: 15, right: 15),
            child: Column(
              children: List.generate(cart.item_count,
                  (index) => CommandItem(data: cart.items[index])),
            ),
          ),
        ],
      ),
    );
  }
}
