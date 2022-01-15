
import 'package:appgestion/models/article_response.dart';
import 'package:appgestion/networking/api_base_helper.dart';

class ArticleRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<List<Article>> fetchArticle(cod_s_fam) async {
    final response = await _helper.get("articlelist?cod_s_fam=$cod_s_fam"  );
    return ArticleResponse.fromJson(response).articles;
  }
}
