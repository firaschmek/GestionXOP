
import 'package:flutter/material.dart';
import '../../models/sous_famille_response.dart';

class SousFamilleItem extends StatelessWidget {
  final SousFamille _s_famille;

  SousFamilleItem(this._s_famille);

  @override
  Widget build(BuildContext context) {

    return buildCard(_s_famille, context);
  }
}

Container buildCard(SousFamille _s_famille, BuildContext context) {
  return Container(
    margin:EdgeInsets.all(8.0),
    child: Card(

      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.lightGreen)
      ),

      child: InkWell(
        onTap: () => Navigator.pushNamed(context, '/articleList', arguments: {'cod_s_fam': _s_famille.cod_s_fam},),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.0),
                topRight: Radius.circular(8.0),
              ),
              child: Image.asset(
                  "images/familles/sousFamille.png",

                  height: 150,
                  fit:BoxFit.fill

              ),
            ),
            ListTile(
              title: Text(_s_famille.lib_sfam),
              //subtitle: Text('Location 1'),
            ),
          ],
        ),
      ),
    ),
  );
}
