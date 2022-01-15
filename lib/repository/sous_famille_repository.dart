import 'package:appgestion/models/sous_famille_response.dart';
import 'package:appgestion/networking/api_base_helper.dart';

class SousFamilleRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<List<SousFamille>> fetchSousFamille(cod_fam) async {
    final response = await _helper.get("sfamilleslist?cod_fam=$cod_fam"  );
    return SousFamilleResponse.fromJson(response).familles;
  }
}
