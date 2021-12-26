import 'dart:convert';

import 'package:appgestion/helpers/UiHelper.dart';
import 'package:appgestion/model/CommandePourEnvoi.dart';
import 'package:appgestion/model/Ligne.dart';
import 'package:appgestion/model/Product.dart';
import 'package:appgestion/pages/familles_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CommandScreen extends StatefulWidget {
  @override
  _CommandScreenState createState() => _CommandScreenState();
}

class _CommandScreenState extends State<CommandScreen> {
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
      print(product['price']);
      total += (double.parse(product['price']) * product['quantity']);
    }
    print('command Prefs $products');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () async {
        UiHelper.generateToast("استعمل زر التطبيق للعودة للقائمة الرئيسية", Colors.grey, Colors.black);
        return false;},
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: buildAppBar(context),
        body: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      buildCommand(json.decode(products[index]), index, products),
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
      ),
    );
  }

  Widget buildCommand(var product, int index, List products) => ListTile(
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
              Expanded(
                  flex: 3,
                  child: Text(product['name'])),
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
                      products.removeAt(index);
                      setCommand(products);
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CommandScreen(),
                          ));
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
        subtitle: Text(product['price'].toString() + " DT" + " x " + product['quantity'].toString() ),
      );

  AppBar buildAppBar(BuildContext context) {
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
            if (!products.isEmpty) {
              UiHelper.generateToast(
                  "تم إلغاء الطلبية", Colors.grey, Colors.black);

              _clearCommand();
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CommandScreen(),
                  ));
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
            if (!products.isEmpty) {
              _sendCommand(products);
              _clearCommand();
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CommandScreen(),
                  ));
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

  _clearCommand() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('mycard');
    prefs.setBool('cardVisibility', false);
    setState(() {});
  }

  Future setCommand(List products) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('mycard', products);
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
      UiHelper.generateToast("تم تفعيل الطلبية", Colors.grey, Colors.black);
    } else {
      UiHelper.generateToast("عطل أثناء عملية التفعيل الرجاء إعادة المحاولة",
          Colors.red, Colors.white);
      throw Exception(response.body);
    }
  }
}
