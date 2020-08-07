import 'package:marvelhero/data/models/base/marvel_base.dart';
import 'package:marvelhero/data/models/character/marvel_character.dart';
import 'package:marvelhero/data/models/comics/comics.dart';
import 'package:marvelhero/data/models/series/series.dart';

abstract class CharactersMarvelApi {
  Future<List<MarvelCharacter>> getCharacters(int take,int skip);
  Future<List<MarvelCharacter>> getCharacter(String heroName) ;
  Future<MarvelBase> getCharacterComics(int characterId,int take, int skip);
  Future<List<Series>> getCharacterSeries(int characterId);
}

abstract class ComicsMarvelApi {
  Future<List<Comic>> getComics(int take,int skip);
}