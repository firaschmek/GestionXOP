import 'package:appgestion/model/Article.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Hero(
                tag: "${article.lib_art}",
                child: CachedNetworkImage(
                  imageUrl: article.image,
                  placeholder: (context, url) =>
                      new CircularProgressIndicator(),
                  errorWidget: (context, url, error) => new Icon(Icons.error),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  // products is out demo list
                  "${article.lib_art}",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: kTextLightColor),
                ),
                Text(
                  // products is out demo list
                  "prix : ${article.prix} DT",

                  style: TextStyle(color: kTextLightColor ),
                )
              ],
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
