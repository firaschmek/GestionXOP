import 'package:appgestion/model/Article.dart';
import 'package:flutter/material.dart';


import 'package:appgestion/constant/constants.dart';


class ArticleItemCard extends StatelessWidget {
  final Article article;
  final Function press;
  const ArticleItemCard({
    Key key,
    this.article,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(kDefaultPaddin),
              margin: const EdgeInsets.all(5.0),
              // For  demo we use fixed height  and width
              // Now we dont need them
              // height: 180,
              // width: 160,
              decoration: BoxDecoration(
                color: Colors.white,
                border:  Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(16),

              ),
              child: Hero(
                tag: "${article.lib_art}",
                child: Image.network(article.image),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 50.0),
            child: Text(
              // products is out demo list
              article.lib_art,
              style: TextStyle(color: kTextLightColor),
            ),
          ),
         // Text(
         //   "19 DT",
         //   style: TextStyle(fontWeight: FontWeight.bold),
        //  )
        ],
      ),
    );
  }
}
