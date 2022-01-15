import 'package:appgestion/models/famille_response.dart';
import 'package:appgestion/networking/api_base_helper.dart';

class FamilleRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<List<Famille>> fetchFamille() async {
    final response = await _helper.get("familleslist");
    return FamilleResponse.fromJson(response).familles;
  }
}
