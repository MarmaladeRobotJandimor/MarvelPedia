import 'package:connectivity/connectivity.dart';
import 'package:marvelhero/data/models/comics/comics.dart';
import 'package:marvelhero/infraestructure/dao/comics_dao/comics_dao.dart';
import 'package:marvelhero/remote/comics/comics_api_service.dart';
import 'package:sembast/sembast.dart';

class ComicsDataService {
  final ComicsMarvelApiService marvelApiService;
  final ComicsDao comicsDao;

  ComicsDataService(this.marvelApiService, this.comicsDao)
      : assert(marvelApiService != null && comicsDao != null);

  Future<List<Comic>> getComics(int take, int skip, bool fromBackend) async {
    var comics = await comicsDao.get(Finder(limit: take, offset: skip));
    if (fromBackend && comics.isEmpty) {
      var comicsFromBackend = await marvelApiService.getComics(take, skip);
      if (comicsFromBackend.isNotEmpty) comicsDao.insertAll(comicsFromBackend);
      return comicsFromBackend;
    } else {
      return comics;
    }
  }

  Future<List<Comic>> searchComics(String name) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    var storedHeroes = await comicsDao.getAllSortedByName();
    if (storedHeroes.isEmpty && connectivityResult != ConnectivityResult.none) {
      return List<Comic>();
    } else {
      var filtered = storedHeroes
          .where((element) =>
              element.title.toLowerCase().contains(name.toLowerCase()))
          .toList();
      return filtered;
    }
  }

  Future setFvouriteComic(int comicId, bool isFavourite) async {
    var comics =
        await comicsDao.get(Finder(filter: Filter.equals('id', comicId)));
    if (comics != null && comics.length > 0) {
      var comic = comics.first;
      var comicUpdated = comic.copyWith(isFavourite: isFavourite);
      await comicsDao.update(comicUpdated);
    }
  }
}
