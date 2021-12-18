import 'package:shared_preferences/shared_preferences.dart';

class CardHelper {

 static Future<String> getCommandSize() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List products = prefs.getStringList('mycard');
    if (products == null) {
      products = new List();
    }
    return products.length.toString();
  }


}
