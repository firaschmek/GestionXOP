import 'dart:convert';

import 'package:appgestion/models/article_response.dart';
import 'package:appgestion/models/command_pour_envoi.dart';
import 'package:appgestion/models/ligne.dart';
import 'package:appgestion/models/product.dart';
import 'package:appgestion/networking/api_base_helper.dart';

class CommandRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  passerLaCommande(List<Product> products) async {
    List<Ligne> lignes = [];
    for (var i = 0; i < products.length; i++) {
      Ligne ligne =
          new Ligne(products[i].name, products[i].price, products[i].quantity);

      lignes.add(ligne);
    }

    CommandPourEnvoi commandPourEnvoi =
        new CommandPourEnvoi("cltTest", DateTime.now(), lignes);
    final response =
        await _helper.post("", jsonEncode(commandPourEnvoi.toJson()));
    return response;
  }
}
