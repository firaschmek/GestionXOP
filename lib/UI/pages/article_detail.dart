import 'package:appgestion/UI/widgets/details.dart';
import 'package:appgestion/UI/widgets/expandable.dart';
import 'package:appgestion/UI/widgets/header.dart';
import 'package:appgestion/UI/widgets/round_button.dart';
import 'package:appgestion/constant/constants.dart';
import 'package:appgestion/models/article_response.dart';
import 'package:appgestion/models/cart_model.dart';
import 'package:appgestion/models/commande_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class ArticleDetailScreen extends StatefulWidget {
  const ArticleDetailScreen({Key key}) : super(key: key);

  @override
  State<ArticleDetailScreen> createState() => _ArticleDetailScreenState();
}

class _ArticleDetailScreenState extends State<ArticleDetailScreen> {
  Article article;
  int quantite=1;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    final arguments = ModalRoute.of(context).settings.arguments as Map;
    article = arguments["article"];
  }

  @override
  Widget build(BuildContext context) {
    var cart = context.watch<CartModel>();
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Header(item: article),
            Details(item: article,numbeofItemsChanged: (value){
              print("numberOfItemsCalled");
              print(value);
              quantite=value;
            },),
            SizedBox(height: 15),
            Divider(color: kBorderColor),
            Expandable(title: 'Details Produit'),
            Divider(color: kBorderColor, indent: 15, endIndent: 15),
            /*Expandable(
              title: 'Nutrition',
              trailing: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: kSecondaryColor,
                ),
                child: Text('100gr'),
              ),
            ),
            Divider(color: kBorderColor, indent: 15, endIndent: 15),
            Expandable(
              title: 'Reviews',
              trailing: Row(
                children: List.generate(
                    5,
                    (index) => Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 20,
                        )),
              ),
            ),*/
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: RoundButton(title: 'Add To Cart',ajouteAlaCarte: (){

                print(article.prix);
                print(quantite);
                print(cart.sousTotal().toString());
                cart.addToItems(new CommandItemEntity(article.code_art, article.lib_art, article.image, quantite, article.prix));
              },),
            ),
          ],
        ),
      ),
    );
  }
}
