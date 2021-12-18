import 'dart:convert';

import 'package:appgestion/constant/constants.dart';
import 'package:appgestion/model/Product.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Command extends StatefulWidget {
  @override
  _CommandState createState() => _CommandState();
}

class _CommandState extends State<Command> {
  List products = new List();
  double total = 0;

  @override
  initState() {
    // TODO: implement initState
    super.initState();
    getCommand();
  }

  Future getCommand() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    products = prefs.getStringList('mycard');
    if (products == null) {
      products = new List();
    }


    for (var i = 0; i < products.length; i++) {
      var product = jsonDecode(products[i]);
      print(product);
      print( product['price']);
      total+= (double.parse(product['price'])*product['quantity']);


    }
    print('command Prefs $products');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(context),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                return buildCommand(json.decode(products[index]));
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
                'TOTAL : ${total} DT',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.grey),
              ),
            ),


          ],
        ),
      ),
    );
  }

  Widget buildCommand(var product) => ListTile(
        leading: Image.network(
          product['ImgSrc'],
          fit: BoxFit.cover,
          width: 50,
          height: 50,
        ),
        title: Text(product['name']),
        subtitle: Text(product['quantity'].toString()),
      );

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.blue,
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset(
          'assets/icons/back.svg',
          color: Colors.white,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      actions: <Widget>[
        FlatButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          color: Colors.blue,
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("تم إلغاء الطلبية"),
            ));
            _clearCommand();
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
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("تم تفعيل الطلبية"),
            ));
            _clearCommand();
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

  _clearCommand() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('mycard');
    prefs.setBool('cardVisibility', false);
    setState(() {});
  }
}
