
import 'package:flutter/material.dart';
import '../../models/sous_famille_response.dart';

class SousFamilleItem extends StatelessWidget {
  final SousFamille _s_famille;

  SousFamilleItem(this._s_famille);

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
            Text(_s_famille.lib_sfam),


          ],
        ),

      ),
      onTap: ()=>  Navigator.pushNamed(context, '/articleList', arguments: {'cod_s_fam': _s_famille.cod_s_fam},),
    );
  }
}
