import 'dart:async';


import 'package:appgestion/models/article_response.dart';
import 'package:appgestion/networking/api_response.dart';
import 'package:appgestion/repository/article_repository.dart';




class ArticleBloc {
  ArticleRepository _articleRepository;

  StreamController _articleListController;

  StreamSink<ApiResponse<List<Article>>> get articleListSink =>
      _articleListController.sink;

  Stream<ApiResponse<List<Article>>> get articleListStream =>
      _articleListController.stream;

  ArticleBloc(cod_s_fam) {
    _articleListController = StreamController<ApiResponse<List<Article>>>();
    _articleRepository = ArticleRepository();
    fetchArticleList(cod_s_fam);
  }

  fetchArticleList(cod_s_fam) async {
    articleListSink.add(ApiResponse.loading(""));
    try {
      List<Article> articles = await _articleRepository.fetchArticle(cod_s_fam);
      articleListSink.add(ApiResponse.completed(articles));
    } catch (e) {
      articleListSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _articleListController?.close();
  }
}