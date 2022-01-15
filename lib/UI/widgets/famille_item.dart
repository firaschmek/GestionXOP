
import 'package:appgestion/UI/pages/sous_famille_screen.dart';
import 'package:flutter/material.dart';
import '../../models/famille_response.dart';

class FamilleItem extends StatelessWidget {
  final Famille _famille;

  FamilleItem(this._famille);

  @override
  Widget build(BuildContext context) {
    //final cartBloc = BlocProvider.of<CartBloc>(context);

    return GestureDetector(
      child: Card(
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: Image.asset(
                  "images/familles/famille1.png",
                ),
              ),
            ),
            Text(_famille.lib_fam),


          ],
        ),

      ),
      onTap: ()=>  Navigator.pushNamed(context, '/sousFamille', arguments: {'cod_fam': _famille.cod_fam},),
    );
  }
}
