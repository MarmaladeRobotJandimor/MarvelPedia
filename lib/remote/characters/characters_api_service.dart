import 'dart:convert';

import 'package:marvelhero/data/models/base/marvel_base.dart';
import 'package:marvelhero/data/models/base/marvel_metadata.dart';
import 'package:marvelhero/data/models/character/marvel_character.dart';

import 'package:http/http.dart' as http;
import 'package:marvelhero/data/models/comics/comics.dart';
import 'package:marvelhero/data/models/series/series.dart';
import 'package:marvelhero/infraestructure/remote/characters_marvel_api/characters_marvel_api.dart';

class CharactersMarvelApiService implements CharactersMarvelApi {
  final String _apiQuery =
      "apikey=658848b5571b8b3f2d87ecd5721614a4&ts=1569697200&hash=ac144921a60ae9faa636bb037fec9dbf";
  final String _baseUrl = "https://gateway.marvel.com/v1/public/";

  @override
  Future<List<MarvelCharacter>> getCharacters(int take, int skip) async {
    var uri = '${_baseUrl}characters?$_apiQuery&limit=$take&offset=$skip';
    var data = await http.get(uri);
    var marvelBase = json.decode(data.body);
    MarvelMetaData<MarvelCharacter> metaData =
        MarvelMetaData.fromJson(marvelBase);
    return metaData.data.results;
  }

  @override
  Future<List<MarvelCharacter>> getCharacter(String heroName) async {
    var uri =
        _baseUrl + 'characters?nameStartsWith=$heroName&$_apiQuery';
    var data = await http.get(uri);
    var marvelBase = json.decode(data.body);
    MarvelMetaData<MarvelCharacter> metaData =
        MarvelMetaData.fromJson(marvelBase);
    return metaData.data.results;
  }

  @override
  Future<MarvelBase> getCharacterComics(int characterId,int take, int skip) async {
    var uri = '${_baseUrl}characters/$characterId/comics?$_apiQuery&limit=$take&offset=$skip';
    var data = await http.get(uri);
    var marvelBase = json.decode(data.body);
    MarvelMetaData<Comic> metaData = MarvelMetaData.fromJson(marvelBase);
    return metaData.data;
  }

  @override
  Future<List<Series>> getCharacterSeries(int characterId) async {
    var uri = '${_baseUrl}characters/$characterId/series?$_apiQuery';
    var data = await http.get(uri);
    var marvelBase = json.decode(data.body);
    MarvelMetaData<Series> metaData = MarvelMetaData.fromJson(marvelBase);
    return metaData.data.results;
  }
}
