import 'dart:convert';

import 'package:appgestion/constant/constants.dart';
import 'package:appgestion/helpers/CardHelper.dart';
import 'package:appgestion/helpers/UiHelper.dart';
import 'package:appgestion/model/SousFamille.dart';
import 'package:appgestion/pages/articles_screen.dart';
import 'package:appgestion/pages/familles_screen.dart';
import 'package:appgestion/pages/sous_famille_item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;


import 'command_screen.dart';

Future<List<SousFamille>> fetchSousFamilles(
    String query, String cod_fam) async {
  final response = await http
      .get( Uri.parse('http://bm.shoptun.tk/admin/erp/sfamilleslist?cod_fam=' + cod_fam));
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    if (!query.isEmpty && query != null) {
      var result = jsonResponse
          .where((element) => element['lib_sfam']
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase()))
          .map((data) => new SousFamille.fromJson(data))
          .toList();
      print(result);
      return result;
    }


    return jsonResponse.map((data) => new SousFamille.fromJson(data)).toList();
  } else {
    throw Exception('Unexpected error occured!');
  }
}

class SousFamilleScreen extends StatefulWidget {
  String cod_fam = '';
  bool isvisible = true;

  SousFamilleScreen(this.cod_fam);

  @override
  _SousFamilleScreenState createState() =>
      _SousFamilleScreenState(this.cod_fam);
}

class _SousFamilleScreenState extends State<SousFamilleScreen> {
  TextEditingController editingController = TextEditingController();
  String cod_fam = '';
  String query = '';

  _SousFamilleScreenState(this.cod_fam) {}

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () async { 
        UiHelper.generateToast("استعمل زر التطبيق للرجوع للوراء", Colors.grey, Colors.black);
        return false;},
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: SvgPicture.asset(
              'assets/icons/back.svg',
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FamilleScreen(),
                  ));
            },
          ),
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
          title: Text('Sous Familles'),
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
              child: FutureBuilder<List<SousFamille>>(
                future: fetchSousFamilles(query, cod_fam),
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
                        itemBuilder: (context, index) => SousFamilleItemCard(
                              sou_famille: snapshot.data[index],
                              press: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ArticleScreen(
                                        snapshot.data[index].cod_s_fam,
                                        widget.cod_fam),
                                  )),
                            ));
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
