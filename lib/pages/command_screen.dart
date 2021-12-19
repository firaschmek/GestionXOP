import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
                return buildCommand(json.decode(products[index]),index,products );
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

  Widget buildCommand(var product, int index , List products) => ListTile(
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
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CommandScreen(),
                ));
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
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CommandScreen(),
                ));
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
}