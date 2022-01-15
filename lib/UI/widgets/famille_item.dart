
import 'package:appgestion/UI/pages/sous_famille_screen.dart';
import 'package:appgestion/constant/constants.dart';
import 'package:flutter/material.dart';
import '../../models/famille_response.dart';

class FamilleItem extends StatelessWidget {
  final Famille _famille;

  FamilleItem(this._famille);

  @override
  Widget build(BuildContext context) {
    //final cartBloc = BlocProvider.of<CartBloc>(context);

    return buildCard(_famille, context);
  }
}

Container buildCard(Famille _famille, BuildContext context) {
  return Container(
    margin:EdgeInsets.all(8.0),
    child: Card(

      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.lightGreen)
      ),

      child: InkWell(
        onTap: () => Navigator.pushNamed(context, '/sousFamille', arguments: {'cod_fam': _famille.cod_fam},),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.0),
                topRight: Radius.circular(8.0),
              ),
              child: Image.asset(
                  "images/familles/famille1.png",

                  height: 150,
                  fit:BoxFit.fill

              ),
            ),
            ListTile(
              title: Text(_famille.lib_fam),
              //subtitle: Text('Location 1'),
            ),
          ],
        ),
      ),
    ),
  );
}
