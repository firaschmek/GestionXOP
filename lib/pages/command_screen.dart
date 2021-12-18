import 'dart:convert';

import 'package:appgestion/model/CommandePourEnvoi.dart';
import 'package:appgestion/model/Ligne.dart';
import 'package:appgestion/model/Product.dart';
import 'package:http/http.dart' as http;
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

  Future setCommand(List products) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('mycard', products);
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
      print(product['price']);
      total += (double.parse(product['price']) * product['quantity']);
    }
    print('command Prefs BOOOM $products');

  }

  @override
  Widget build(BuildContext context) {
   // print("**************************");
   // getCommand();
    //print(products.length);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(context),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                return buildCommand(json.decode(products[index]),index,products,total);
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
                    fontSize: 20,
                    color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCommand(var product, int index, List products,double total) => ListTile(
        leading: Image.network(
          product['ImgSrc'],
          fit: BoxFit.cover,
          width: 50,
          height: 50,
        ),
        title: Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: Text(product['name'])),
              Expanded(
                  child: Text(
                      (double.parse(product['price']) * product['quantity'])
                              .toString() +
                          " DT")),
              Expanded(
                child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18)),
                    color: Colors.white,
                    onPressed: () {
                    // products.removeAt(index);
                     // setCommand(products);

                    },
                    child: Icon(
                      Icons.delete,
                      color: Colors.blue,
                      size: 35.0,
                      semanticLabel: 'Text to announce in accessibility modes',
                    )),
              )
            ],
          ),
        ),
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
            _sendCommand(products);
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

  _sendCommand(List products) {
    List<Product> lesVraisProduits = [];
    List<Ligne> lignes = [];

    for (var i = 0; i < products.length; i++) {
      Map<String, dynamic> json = jsonDecode(products[i]);
      lesVraisProduits.add(Product.fromJson(json));
    }

    for (var i = 0; i < lesVraisProduits.length; i++) {
      print(lesVraisProduits[i].name);
      Ligne ligne = new Ligne(lesVraisProduits[i].name,
          lesVraisProduits[i].price, lesVraisProduits[i].quantity);
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
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("تم تفعيل الطلبية"),
      ));

    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(" عطل أثناء عملية التفعيل الرجاء إعادة المحاولة"),
      ));
      throw Exception(response.body);
    }
  }

  _clearCommand() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('mycard');


    MaterialPageRoute(
      builder: (context) => Command(),
    );

  }
}
