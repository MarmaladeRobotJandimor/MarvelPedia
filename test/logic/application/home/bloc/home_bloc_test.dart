import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvelhero/data/models/character/marvel_character.dart';
import 'package:marvelhero/infraestructure/dao/heroes_dao/heroes_dao.dart';
import 'package:marvelhero/infraestructure/data_services/heroes_data_service/heroes_data_service.dart';
import 'package:marvelhero/logic/application/home/pages/heroes/bloc/heroes_bloc.dart';
import 'package:marvelhero/logic/application/home/pages/heroes/bloc/heroes_event.dart';
import 'package:marvelhero/logic/application/home/pages/heroes/bloc/heroes_state.dart';
import 'package:marvelhero/remote/characters/characters_api_service.dart';
import 'package:mockito/mockito.dart';

class MockHeroDao extends Mock implements HeroesDao {}

class MockMarvelApiService extends Mock implements CharactersMarvelApiService {}

class MockHeroesDataService extends Mock implements HeroesDataService {}

void main() {
  group('HeroesBloc', () {
    WidgetsFlutterBinding.ensureInitialized();
    //ignore: close_sinks
    HeroesBloc heroesBloc;
    MockHeroesDataService mockHeroesDataService;

    String connectionType;
    final MarvelCharacter hero =
        MarvelCharacter(1, null, null, null, null, null, null, null,null);
    //final List<MarvelCharacter> heroes = List<MarvelCharacter>()..add(hero);

    setUp(() {
      mockHeroesDataService = MockHeroesDataService();
      heroesBloc = HeroesBloc(mockHeroesDataService);

      const MethodChannel('plugins.flutter.io/connectivity')
          .setMockMethodCallHandler((MethodCall methodCall) async {
        if (methodCall.method == 'check') {
          return connectionType ?? 'none';
        }
        return methodCall;
      });

      const MethodChannel channel =
          MethodChannel('plugins.flutter.io/path_provider');
      channel.setMockMethodCallHandler((MethodCall methodCall) async {
        return ".";
      });
    });

    test('initialState should be HeroesUninitialized', () {
      // assert
      //expect(heroesBloc.initialState, equals(HeroesUnitialized()));
    });

    test('throws AssertionError if MarvelApiService is null', () {
      expect(
        () => HeroesBloc(null),
        throwsA(isAssertionError),
      );
    });

    blocTest(
      'emits [HeroesUnitialized ,HeroesLoading , HeroesLoaded] when GetHeroes',
      build: () {
        connectionType = "wifi";
        // when(heroesBloc.heroesDataService.getHeroes(1, 0, false))
        //     .thenAnswer((_) async => heroes);
        return heroesBloc;
      },
      act: (bloc) => bloc.add(GetHeroes(1, 0, false)),
      expect: [
        HeroesUnitialized(),
        HeroesLoading(),
        HeroesLoaded(
            heroes: List<MarvelCharacter>()..add(hero), hasReachedMax: false)
      ],
    );

    blocTest(
      'emits [HeroesUnitialized ,HeroesLoading , HeroesError] when GetHeroes',
      build: () {
        // when(mockHeroesDataService.getHeroes(20, 0, true))
        //     .thenThrow(Exception());
        return HeroesBloc(mockHeroesDataService);
      },
      act: (bloc) => bloc.add(GetHeroes(20, 0, false)),
      expect: [
        HeroesUnitialized(),
        HeroesLoading(),
        HeroesError(errorMessage: 'Error')
      ],
    );
  });
}
