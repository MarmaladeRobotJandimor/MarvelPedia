import 'package:marvelhero/data/models/character/marvel_character.dart';
import 'package:sembast/sembast.dart';

abstract class HeroesDataService {
  Future<List<MarvelCharacter>> getHeroes(int take, int skip);

  Future<List<MarvelCharacter>> searchHeroes(String name);

  Future<MarvelCharacter> getHero(Finder finder);

  Future<List<MarvelCharacter>> getAllHeroesFromBackendAndInsert();

  Future<int> heroesCount();
}
