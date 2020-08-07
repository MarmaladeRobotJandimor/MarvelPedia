import 'dart:convert';
import 'package:marvelhero/data/models/base/marvel_metadata.dart';
import 'package:http/http.dart' as http;
import 'package:marvelhero/data/models/comics/comics.dart';
import 'package:marvelhero/infraestructure/remote/characters_marvel_api/characters_marvel_api.dart';

class ComicsMarvelApiService implements ComicsMarvelApi {
  final String _apiQuery =
      "apikey=658848b5571b8b3f2d87ecd5721614a4&ts=1569697200&hash=ac144921a60ae9faa636bb037fec9dbf";
  final String _baseUrl = "https://gateway.marvel.com/v1/public/";

  @override
  Future<List<Comic>> getComics(int take, int skip) async {
    var uri = '${_baseUrl}comics?$_apiQuery&limit=$take&offset=$skip';
    var data = await http.get(uri);
    var marvelBase = json.decode(data.body);
    MarvelMetaData<Comic> metaData = MarvelMetaData.fromJson(marvelBase);
    return metaData.data.results;
  }
}
