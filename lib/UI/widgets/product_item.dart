import 'package:appgestion/models/article_response.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final Article _article;

  ProductItem(this._article);

  @override
  Widget build(BuildContext context) {
    //final cartBloc = BlocProvider.of<CartBloc>(context);

    return buildCard(_article, context);
  }
}

Container buildCard(Article article, BuildContext context) {
  return Container(
    margin: EdgeInsets.all(8.0),
    child: Card(
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.lightGreen)),
      child: InkWell(
        onTap: () => Navigator.pushNamed(
          context,
          '/articleDetail',
          arguments: {'article': article},
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.0),
                topRight: Radius.circular(8.0),
              ),
              child: CachedNetworkImage(
                  imageUrl: article.image,
                  placeholder: (context, url) =>
                      new CircularProgressIndicator(color: Colors.lightGreen),
                  errorWidget: (context, url, error) => new Icon(Icons.error),
                  height: 120,
                  fit: BoxFit.fill),
            ),
            ListTile(
              title: Text(article.lib_art,  overflow: TextOverflow.ellipsis,),
              subtitle: Text(article.prix + "DT"),
            ),
          ],
        ),
      ),
    ),
  );
}
