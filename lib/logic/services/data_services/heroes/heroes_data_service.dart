import 'package:marvelhero/data/models/character/marvel_character.dart';
import 'package:marvelhero/infraestructure/dao/heroes_dao/heroes_dao.dart';
import 'package:marvelhero/infraestructure/data_services/heroes_data_service/heroes_data_service.dart';
import 'package:marvelhero/remote/characters/characters_api_service.dart';
import 'package:sembast/sembast.dart';

class HeroesDataServiceImpl extends HeroesDataService {
  final CharactersMarvelApiService _marvelApiService;
  final HeroesDao _heroesDao;
  bool _allHeroesDownloaded = false;

  HeroesDataServiceImpl(this._marvelApiService, this._heroesDao)
      : assert(_marvelApiService != null && _heroesDao != null);

  @override
  Future<List<MarvelCharacter>> getHeroes(int take, int skip) async {
    return await _heroesDao.get(Finder(limit: take, offset: skip));
  }

  @override
  Future<List<MarvelCharacter>> getAllHeroesFromBackendAndInsert() async {
    List<MarvelCharacter> heroes = List<MarvelCharacter>();
    while (!_allHeroesDownloaded) {
      var heroesFromBackend =
          await _marvelApiService.getCharacters(100, heroes.length);
      if (heroesFromBackend.isNotEmpty) {
        heroes += heroesFromBackend;
        _heroesDao.insertAll(heroesFromBackend);
      } else {
        _allHeroesDownloaded = true;
      }
    }
    return heroes;
  }

  @override
  Future<List<MarvelCharacter>> searchHeroes(
      String name) async {
    var storedHeroes = await _heroesDao.getAllSortedByName();
    var filtered = storedHeroes
        .where((element) =>
            element.name.toLowerCase().contains(name.toLowerCase()))
        .toList();
    return filtered;
  }

  @override
  Future<MarvelCharacter> getHero(Finder finder) async {
    var heroes = await _heroesDao.get(finder);
    if (heroes != null && heroes.isNotEmpty) {
      return heroes.first;
    }
    return null;
  }

  @override
  Future<int> heroesCount() async => await _heroesDao.count();
}
