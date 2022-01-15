import 'dart:async';

import 'package:appgestion/models/sous_famille_response.dart';
import 'package:appgestion/networking/api_response.dart';
import 'package:appgestion/repository/sous_famille_repository.dart';



class SousFamilleBloc {
  SousFamilleRepository _sousFamilleRepository;

  StreamController _sousFamilleListController;

  StreamSink<ApiResponse<List<SousFamille>>> get sousFamilleListSink =>
      _sousFamilleListController.sink;

  Stream<ApiResponse<List<SousFamille>>> get sousFamilleListStream =>
      _sousFamilleListController.stream;

  SousFamilleBloc(cod_fam) {
    _sousFamilleListController = StreamController<ApiResponse<List<SousFamille>>>();
    _sousFamilleRepository = SousFamilleRepository();
    fetchSousFamilleList(cod_fam);
  }

  fetchSousFamilleList(cod_fam) async {
    sousFamilleListSink.add(ApiResponse.loading(''));
    try {
      List<SousFamille> fousFamilles = await _sousFamilleRepository.fetchSousFamille(cod_fam);
      sousFamilleListSink.add(ApiResponse.completed(fousFamilles));
    } catch (e) {
      sousFamilleListSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _sousFamilleListController?.close();
  }
}