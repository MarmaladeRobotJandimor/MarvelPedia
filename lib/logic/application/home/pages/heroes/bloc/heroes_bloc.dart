import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:marvelhero/infraestructure/data_services/heroes_data_service/heroes_data_service.dart';
import 'package:flutter/foundation.dart';
import 'heroes_event.dart';
import 'heroes_state.dart';

class HeroesBloc extends Bloc<HeroesEvent, HeroesState> {
  HeroesDataService heroesDataService;
  int takeHeroes = 100;
  int skipHeroes = 0;
  bool connectivityAvailable;

  HeroesBloc(this.heroesDataService) : assert(heroesDataService != null);

  @override
  HeroesState get initialState => HeroesUnitialized();

  @override
  Stream<HeroesState> mapEventToState(HeroesEvent event) async* {
    if ((event is GetHeroes && !_hasReachedMax(state)) ||
        (event is GetHeroes && event.returnFromNoConnectivity)) {
      var heroesCount = await heroesDataService.heroesCount();
      if (heroesCount > 0) {
        yield* _getHeroes(event);
      } else {
        yield* _getAllHeroes();
      }
    }
    if (event is SearchHeroes) {
      yield* _searchHeroes(event.heroName);
    }
  }

  Stream<HeroesState> _getAllHeroes() async* {
    try {
      yield HeroesLoading();
      if (await checkConnectivity()) {
        var heroesFromBackend =
            await heroesDataService.getAllHeroesFromBackendAndInsert();
        yield HeroesLoaded(heroes: heroesFromBackend, hasReachedMax: true);
      } else {
        yield HeroesError(errorMessage: 'No valid connection detected.');
      }
    } catch (e) {}
  }

  Future<bool> checkConnectivity() async {
    if (!kIsWeb) {
      var connectivity = await Connectivity().checkConnectivity();
      return connectivity != ConnectivityResult.none;
    }
    return true;
  }

  Stream<HeroesState> _getHeroes(HeroesEvent event) async* {
    try {
      GetHeroes getHeroesEvent = event;
      int take = getHeroesEvent.take;
      int skip = getHeroesEvent.skip;

      if (state is HeroesUnitialized) {
        if (skip == 0) {
          yield HeroesLoading();
        }
        var heroes = await heroesDataService.getHeroes(take, 0);
        yield HeroesLoaded(heroes: heroes, hasReachedMax: heroes.isEmpty);
        return;
      }

      if (state is HeroesLoaded) {
        HeroesLoaded currentState = state;
        var heroes =
            await heroesDataService.getHeroes(take, currentState.heroes.length);
        yield HeroesLoaded(
            heroes: currentState.heroes + heroes,
            hasReachedMax: heroes.isEmpty);
      }
    } catch (e) {
      yield HeroesError(errorMessage: 'Error');
    }
  }

  Stream<HeroesState> _searchHeroes(String heroName) async* {
    try {
      yield HeroesLoading();
      var heroes = await heroesDataService.searchHeroes(heroName);
      yield heroes.isEmpty
          ? SearchHeroesEmpty()
          : SearchHeroesLoaded(heroes: heroes, hasReachedMax: true);
    } catch (e) {
      yield HeroesError(errorMessage: 'Error');
    }
  }

  bool _hasReachedMax(HeroesState state) =>
      state is HeroesLoaded && state.hasReachedMax;

  void getHeroes({bool returnFromNoConnectivity = false}) {
    add(GetHeroes(takeHeroes, skipHeroes, returnFromNoConnectivity));
  }

  void searchHeroes(String query) {
    add(SearchHeroes(query));
  }
}
