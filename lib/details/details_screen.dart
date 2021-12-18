import 'dart:convert';

import 'package:appgestion/helpers/CardHelper.dart';
import 'package:appgestion/model/Article.dart';
import 'package:appgestion/pages/articles_screen.dart';
import 'package:appgestion/pages/command_screen.dart';
import 'package:appgestion/pages/sous_familles_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:appgestion/constant/constants.dart';
import 'package:appgestion/model/Product.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'components/color_and_size.dart';

class DetailsScreen extends StatefulWidget {
  final Article article;
  bool isvisible = true;
  int numOfItems = 1;
  String cod_s_fam='';
  String cod_fam = '';

  DetailsScreen(this.article,this.cod_s_fam,this.cod_fam);



  @override
  _DetailsScreenState createState() => _DetailsScreenState(article);
}

class _DetailsScreenState extends State<DetailsScreen> {
  final Article article;


  _DetailsScreenState(this.article);

  @override
  initState() {
    // TODO: implement initState
    super.initState();
    getcardVisVar();
  }

  Future getcardVisVar() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    widget.isvisible = prefs.getBool('cardVisibility');
    print(" ICI ON RECUPERE LA VISIBILITE DE CARD");
    print(widget.isvisible);

  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print(" ICI ON BUILD");
    getcardVisVar();
    return Scaffold(
      // each product have a color
      backgroundColor: Colors.white,
      appBar: buildAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: size.height,
              child: Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: size.height * 0.3),
                    padding: EdgeInsets.only(
                      top: size.height * 0.12,
                      left: kDefaultPaddin,
                      right: kDefaultPaddin,
                    ),
                    // height: 500,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                    ),
                    child: Column(
                      children: <Widget>[
                        Opacity(
                            opacity: 0.0,
                            child: ColorAndSize(article: widget.article)),
                        // SizedBox(height: kDefaultPaddin / 2),
                        SizedBox(height: kDefaultPaddin / 2),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: kDefaultPaddin),
                          child: Text(
                            widget.article.lib_art,
                            style: TextStyle(height: 1.5),
                          ),
                        ),
                        SizedBox(height: kDefaultPaddin / 2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                buildOutlineButton(
                                  icon: Icons.remove,
                                  press: () {
                                    if (widget.numOfItems > 1) {
                                      setState(() {
                                        widget.numOfItems--;
                                      });
                                    }
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: kDefaultPaddin / 2),
                                  child: Text(
                                    // if our item is less  then 10 then  it shows 01 02 like that
                                    widget.numOfItems
                                        .toString()
                                        .padLeft(2, "0"),
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  ),
                                ),
                                buildOutlineButton(
                                    icon: Icons.add,
                                    press: () {
                                      setState(() {
                                        widget.numOfItems++;
                                      });
                                    }),
                              ],
                            ),
                            Text(
                              "${ double.parse(widget.article.prix) * widget.numOfItems} DT",
                              style: TextStyle(fontSize: 22),
                            ),
                          ],
                        ),
                        SizedBox(height: kDefaultPaddin / 2),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: kDefaultPaddin),
                          child: Row(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(right: kDefaultPaddin),
                                height: 50,
                                width: 58,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18),
                                  border: Border.all(
                                    color: Colors.white,
                                  ),
                                ),
                                child: IconButton(
                                  icon: SvgPicture.asset(
                                    "assets/icons/add_to_cart.svg",
                                    color: Colors.lightBlue,
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                              Expanded(
                                child: SizedBox(
                                  height: 50,
                                  child: FlatButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18)),
                                    color: Colors.lightBlue,
                                    onPressed: () {
                                      widget.isvisible = true;

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(
                                            "تمت الإضافة إلى قائمة المشتريات بنجاح"),
                                      ));
                                      _addToCommand(
                                          widget.article,widget.numOfItems );
                                      Navigator.pop(context);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => DetailsScreen(widget.article,widget.cod_s_fam,widget.cod_fam),
                                          ));

                                    },
                                    child: Text(
                                      "أضف إلى الطلبية".toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.article.lib_art,
                          style: Theme.of(context).textTheme.headline4.copyWith(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: kDefaultPaddin),
                        Row(
                          children: <Widget>[
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(text: "Price\n"),
                                  TextSpan(
                                    text: "\$${widget.article.cod_unite}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4
                                        .copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: kDefaultPaddin),
                            Expanded(
                              child: Hero(
                                tag: "${widget.article.lib_art}",
                                child: Image.network(
                                  widget.article.image,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.blue,
      elevation: 0,
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
                builder: (context) => ArticleScreen(widget.cod_s_fam,widget.cod_fam),
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
                    future: CardHelper.getCommandSize(), // a previously-obtained Future<String> or null
                    builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
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
                  MaterialPageRoute(builder: (context) => Command()),
                );
              },
            )
          ],
        ),
        SizedBox(width: kDefaultPaddin / 2)
      ],
    );
  }

  SizedBox buildOutlineButton({IconData icon, Function press}) {
    return SizedBox(
      width: 40,
      height: 32,
      child: OutlineButton(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(13),
        ),
        onPressed: press,
        child: Icon(icon),
      ),
    );
  }

  _addToCommand(Article article, int numbOfItems) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('THE RESULT OF SharedPreferences');
    Product product=new Product(article.lib_art, article.image, numbOfItems, article.prix);

    List<String> commandMap = prefs.getStringList('mycard');
    if (commandMap == null) {
      commandMap = new List();
    }
    var jsonEncode2 = jsonEncode(product);
    commandMap.add(jsonEncode2);
    await prefs.setStringList('mycard', commandMap);
    print(jsonEncode2);
    //cardVisibility
    prefs.setBool('cardVisibility',true);
  }
}
