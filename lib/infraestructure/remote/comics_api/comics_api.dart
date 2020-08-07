import 'package:marvelhero/data/models/comics/comics.dart';

abstract class ComicsMarvelApi {
  Future<List<Comic>> getComics(int characterId);
}