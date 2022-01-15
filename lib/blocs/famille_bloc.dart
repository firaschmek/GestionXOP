import 'dart:async';

import 'package:appgestion/models/famille_response.dart';
import 'package:appgestion/networking/api_response.dart';
import 'package:appgestion/repository/famille_repository.dart';



class FamilleBloc {
  FamilleRepository _familleRepository;

  StreamController _familleListController;

  StreamSink<ApiResponse<List<Famille>>> get familleListSink =>
      _familleListController.sink;

  Stream<ApiResponse<List<Famille>>> get familleListStream =>
      _familleListController.stream;

  FamilleBloc() {
    _familleListController = StreamController<ApiResponse<List<Famille>>>();
    _familleRepository = FamilleRepository();
    fetchFamilleList();
  }

  fetchFamilleList() async {
    familleListSink.add(ApiResponse.loading('Fetching Familles'));
    try {
      List<Famille> familles = await _familleRepository.fetchFamille();
      familleListSink.add(ApiResponse.completed(familles));
    } catch (e) {
      familleListSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _familleListController?.close();
  }
}