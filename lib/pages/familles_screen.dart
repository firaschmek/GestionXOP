import 'dart:convert';

import 'package:appgestion/constant/constants.dart';
import 'package:appgestion/helpers/CardHelper.dart';
import 'package:appgestion/helpers/UiHelper.dart';
import 'package:appgestion/model/Famille.dart';

import 'package:appgestion/pages/famille_item_card.dart';
import 'package:appgestion/pages/sous_familles_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;

import 'command_screen.dart';
import 'login_screen.dart';

Future<List<Famille>> fetchFamilles(String query) async {
  final response =
      await http.get(Uri.parse('http://bm.shoptun.tk/admin/erp/familleslist'));
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    if (!query.isEmpty && query != null) {
      var result = jsonResponse
          .where((element) => element['lib_fam']
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase()))
          .map((data) => new Famille.fromJson(data))
          .toList();
      print(result);
      return result;
    }

    return jsonResponse.map((data) => new Famille.fromJson(data)).toList();
  } else {
    throw Exception('Unexpected error occured!');
  }
}

class FamilleScreen extends StatefulWidget {
  @override
  _FamilleScreenState createState() => _FamilleScreenState();
}

class _FamilleScreenState extends State<FamilleScreen> {
  TextEditingController editingController = TextEditingController();

  String query = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () async {
        UiHelper.generateToast(
            "استعمل زر الخروج من التطبيق", Colors.grey, Colors.black);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  width: 20,
                  height: 20,
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FutureBuilder<String>(
                        future: CardHelper.getCommandSize(),
                        // a previously-obtained Future<String> or null
                        builder: (BuildContext context,
                            AsyncSnapshot<String> snapshot) {
                          List<Widget> children;
                          if (snapshot.hasData) {
                            children = <Widget>[
                              // Text('Result: ${snapshot.data}'),
                              Text('${snapshot.data}'),
                            ];
                          }
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: children,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: SvgPicture.asset("assets/icons/cart.svg"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CommandScreen()),
                    );
                  },
                )
              ],
            ),
            SizedBox(width: kDefaultPaddin / 2)
          ],
          title: Text('Familles'),
        ),
        body: Container(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  query = value;
                  setState(() {});
                },
                controller: editingController,
                decoration: InputDecoration(
                    labelText: "البحث",
                    hintText: "البحث",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Famille>>(
                future: fetchFamilles(query),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return GridView.builder(
                        itemCount: snapshot.data.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: kDefaultPaddin,
                          crossAxisSpacing: kDefaultPaddin,
                          childAspectRatio: 0.75,
                        ),
                        itemBuilder: (context, index) => FamilleItemCard(
                              famille: snapshot.data[index],
                              press: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SousFamilleScreen(
                                        snapshot.data[index].cod_fam),
                                  )),
                            ));
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ]),
        ),
        drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage("images/wallpaper.jpg")),
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                        backgroundImage: AssetImage("images/person.jpeg")),
                    Text('Mohamed est connecté !'),
                  ],
                ),
              ),
              ListTile(
                trailing: Icon(Icons.login_outlined),
                title: Text('خروج'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
