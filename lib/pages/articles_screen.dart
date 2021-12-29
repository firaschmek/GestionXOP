import 'dart:convert';
import 'package:appgestion/constant/constants.dart';
import 'package:appgestion/details/details_screen.dart';
import 'package:appgestion/helpers/UiHelper.dart';
import 'package:appgestion/model/Article.dart';
import 'package:appgestion/pages/article_item_card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


Future<List<Article>> fetchArticle(String query, String cod_s_fam) async {
  final response = await http.get(Uri.parse(
      'http://bm.shoptun.tk/admin/erp/articlelist?cod_s_fam=' + cod_s_fam));
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    if (!query.isEmpty && query != null) {
      var result = jsonResponse
          .where((element) => element['code_art']
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase()))
          .map((data) => new Article.fromJson(data))
          .toList();
      print(result);
      return result;
    }

    return jsonResponse.map((data) => new Article.fromJson(data)).toList();
  } else {
    throw Exception('Unexpected error occured!');
  }
}

class ArticleScreen extends StatefulWidget {
  String cod_fam = '';
  String cod_s_fam = '';
  bool isvisible = true;

  ArticleScreen(this.cod_s_fam, this.cod_fam);

  @override
  _ArticleScreenState createState() => _ArticleScreenState(this.cod_s_fam);
}

class _ArticleScreenState extends State<ArticleScreen> {
  TextEditingController editingController = TextEditingController();
  String cod_s_fam = '';
  String query = '';

  _ArticleScreenState(this.cod_s_fam);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        appBar: UiHelper.createAppBar(context),
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
              child: FutureBuilder<List<Article>>(
                future: fetchArticle(query, cod_s_fam),
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
                        itemBuilder: (context, index) => ArticleItemCard(
                              article: snapshot.data[index],
                              press: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailsScreen(
                                        snapshot.data[index],
                                        widget.cod_s_fam,
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

    );
  }
}
