import 'dart:convert';

import 'package:appgestion/helpers/UiHelper.dart';
import 'package:appgestion/model/CommandePourEnvoi.dart';
import 'package:appgestion/model/Ligne.dart';
import 'package:appgestion/model/Product.dart';
import 'package:appgestion/model/cart_model.dart';
import 'package:appgestion/pages/familles_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:http/http.dart' as http;

class CommandScreen extends StatefulWidget {
  @override
  _CommandScreenState createState() => _CommandScreenState();
}

class _CommandScreenState extends State<CommandScreen> {
  @override
  Widget build(BuildContext context) {
    var cart = context.watch<CartModel>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(context),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    buildCommandItem(cart.items[index], cart),
                    Divider(),
                  ],
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(''),
            ),
            Expanded(
              child: Text(
                'TOTAL : ${cart.totalPrice} DT',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCommandItem(Product product, CartModel cart) => ListTile(
        leading: Image.network(
          product.ImgSrc,
          fit: BoxFit.cover,
          width: 50,
          height: 50,
        ),
        title: Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(flex: 3, child: Text(product.name)),
              Expanded(
                  child: Text((double.parse(product.price) * product.quantity)
                          .toString() +
                      " DT")),
              Expanded(
                child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18)),
                    color: Colors.white,
                    onPressed: () {
                      cart.removeFromItems(product);
                    },
                    child: Icon(
                      Icons.delete,
                      color: Colors.grey,
                      size: 30.0,
                      semanticLabel: 'Text to announce in accessibility modes',
                    )),
              )
            ],
          ),
        ),
        subtitle: Text(product.price.toString() +
            " DT" +
            " x " +
            product.quantity.toString()),
      );

  AppBar buildAppBar(BuildContext context) {
    var cart = context.watch<CartModel>();
    return AppBar(
      backgroundColor: Colors.blue,
      elevation: 0,
      leading: IconButton(
          icon: Icon(
            Icons.home,
            color: Colors.white,
            size: 35.0,
            semanticLabel: 'Text to announce in accessibility modes',
          ),
          onPressed: () {
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FamilleScreen(),
                ));
          }),
      actions: <Widget>[
        FlatButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          color: Colors.blue,
          onPressed: () {
            if (cart.items.isNotEmpty) {
              UiHelper.generateToast(
                  "تم إلغاء الطلبية", Colors.grey, Colors.black);
              cart.clearItems();
            } else {
              UiHelper.generateToast("الطلبية فارغة", Colors.red, Colors.white);
            }
          },
          child: Text(
            "إلغاء الطلبية".toUpperCase(),
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        FlatButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          color: Colors.blue,
          onPressed: () {
            if (cart.items.isNotEmpty) {
              _sendCommand(cart.items);
              cart.clearItems();
            } else {
              UiHelper.generateToast("الطلبية فارغة", Colors.red, Colors.white);
            }
          },
          child: Text(
            "تفعيل الطلبية".toUpperCase(),
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  _sendCommand(List<Product> products) {
    List<Ligne> lignes = [];
    for (var i = 0; i < products.length; i++) {
      Ligne ligne =
          new Ligne(products[i].name, products[i].price, products[i].quantity);

      lignes.add(ligne);
    }

    CommandPourEnvoi commandPourEnvoi =
        new CommandPourEnvoi("cltTest", DateTime.now(), lignes);
    passerLacommande(commandPourEnvoi);
  }

  passerLacommande(CommandPourEnvoi commandPourEnvoi) async {
    print("Send Commad");
    print(jsonEncode(commandPourEnvoi.toJson()));
    final response = await http.post(
      Uri.parse('http://bm.shoptun.tk/admin/erp/commandelist'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(commandPourEnvoi.toJson()),
    );
    if (response.statusCode == 201) {
      UiHelper.generateToast("تم تفعيل الطلبية", Colors.grey, Colors.black);
    } else {
      UiHelper.generateToast("عطل أثناء عملية التفعيل الرجاء إعادة المحاولة",
          Colors.red, Colors.white);
      throw Exception(response.body);
    }
  }
}
