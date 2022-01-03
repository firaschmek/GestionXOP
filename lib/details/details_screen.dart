import 'dart:convert';
import 'package:appgestion/helpers/CardHelper.dart';
import 'package:appgestion/helpers/UiHelper.dart';
import 'package:appgestion/model/Article.dart';
import 'package:appgestion/model/cart_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:appgestion/constant/constants.dart';
import 'package:appgestion/model/Product.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'components/color_and_size.dart';

class DetailsScreen extends StatefulWidget {
  final Article article;
  bool isvisible = true;
  int numOfItems = 1;
  String cod_s_fam = '';
  String cod_fam = '';

  DetailsScreen(this.article, this.cod_s_fam, this.cod_fam);

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

  }

  @override
  Widget build(BuildContext context) {

    var cart = context.watch<CartModel>();
    Size size = MediaQuery.of(context).size;

    return  Scaffold(
        // each product have a color
        backgroundColor: Colors.white,
        appBar: UiHelper.createAppBar(context),
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
                                "${widget.article.prix } DT",
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
                                "${double.parse(widget.article.prix) * widget.numOfItems} DT",
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
                                  margin:
                                      EdgeInsets.only(right: kDefaultPaddin),
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
                                        UiHelper.generateToast(
                                            "تمت الإضافة إلى قائمة المشتريات بنجاح",
                                            Colors.grey,
                                            Colors.black);
                                        Product product =
                                        new Product(article.code_art,article.lib_art, article.image, widget.numOfItems , article.prix);
                                        cart.addToItems(product);



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
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPaddin),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.article.lib_art,
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                .copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
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
                                  tag: "${widget.article.code_art}",
                                  child: CachedNetworkImage(
                                    imageUrl: article.image,
                                    placeholder: (context, url) =>
                                        new CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        new Icon(Icons.error),
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

}


