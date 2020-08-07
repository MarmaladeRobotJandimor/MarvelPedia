import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';
import 'package:marvelhero/logic/application/home/pages/comics/bloc/comics_event.dart';
import 'package:marvelhero/logic/services/data_services/comics/comics_data_service.dart';

import 'comics_state.dart';

class ComicsBloc extends Bloc<ComicsEvent, ComicsState> {
  ComicsDataService comicsDataService;
  int takeComics = 20;
  int skipComics = 0;

  ComicsBloc(this.comicsDataService) : assert(comicsDataService != null);

  @override
  ComicsState get initialState => ComicsUnitialized();

  @override
  Stream<ComicsState> mapEventToState(ComicsEvent event) async* {
    if ((event is GetComics && !_hasReachedMax(state)) ||
        (event is GetComics && event.returnFromNoConnectivity)) {
      GetComics getComics = event;
      yield* _getComics(getComics.take, getComics.skip);
    }
    if (event is SearchComics) {
      var comics = await comicsDataService.searchComics(event.comicName);
      yield comics.isEmpty
          ? SearchComicsEmpty()
          : SearchComicsLoaded(comics: comics, hasReachedMax: true);
    }
  }

  Stream<ComicsState> _getComics(int take, int skip) async* {
    try {
      bool fromBackEnd = true;
      if (!kIsWeb) {
        var connectivity = await Connectivity().checkConnectivity();
        fromBackEnd = connectivity != ConnectivityResult.none;
      }
      if (state is ComicsUnitialized) {
        if (skip == 0) {
          yield ComicsLoading();
        }
        var comics = await comicsDataService.getComics(100, 0, fromBackEnd);
        yield ComicsLoaded(comics: comics, hasReachedMax: comics.isEmpty);
        return;
      }
      if (state is ComicsLoaded) {
        ComicsLoaded currentState = state;
        var comics = await comicsDataService.getComics(
            take, currentState.comics.length, fromBackEnd);
        yield ComicsLoaded(
            comics: currentState.comics + comics,
            hasReachedMax: comics.isEmpty);
      }
    } catch (e) {
      yield ComicsError(errorMessage: '$e');
    }
  }

  bool _hasReachedMax(ComicsState state) =>
      state is ComicsLoaded && state.hasReachedMax;

  void getComics({bool returnFromNoConnectivity = false}) {
    add(GetComics(takeComics, skipComics, returnFromNoConnectivity));
  }

  void searchHeroes(String query) {
    add(SearchComics(query));
  }
}
