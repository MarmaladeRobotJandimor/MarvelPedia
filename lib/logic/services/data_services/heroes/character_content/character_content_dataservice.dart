import 'package:marvelhero/data/models/base/marvel_base.dart';
import 'package:marvelhero/data/models/character/character_content.dart';
import 'package:marvelhero/data/models/comics/comics.dart';
import 'package:marvelhero/infraestructure/dao/heroes_dao/character_content_dao/character_content_dao.dart';
import 'package:marvelhero/remote/characters/characters_api_service.dart';
import 'package:sembast/sembast.dart';

class CharacterContentDataService {
  final CharactersMarvelApiService _marvelApiService;
  final CharacterContentDao _characterContentDao;

  CharacterContentDataService(this._marvelApiService, this._characterContentDao)
      : assert(_marvelApiService != null);

  Future<CharacterContent> getCharacterContent(int heroId,int take, int skip) async {
    try {
      var characterContent = await _characterContentDao
          .find(Finder(filter: Filter.equals('heroId', heroId)));
      if (characterContent != null) {
        return characterContent;
      } else {
        MarvelBase<Comic> comics =
            await _marvelApiService.getCharacterComics(heroId, take, skip);
        var characterContentNew = CharacterContent(comics, heroId);
        await _characterContentDao.insert(characterContentNew);
        return characterContentNew;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<CharacterContent> getMoreCharacterComics(int heroId,int take, int skip) async {
    try {
        MarvelBase<Comic> comics =
            await _marvelApiService.getCharacterComics(heroId, take, skip);
        var characterContentNew = CharacterContent(comics, heroId);
        await _characterContentDao.insert(characterContentNew);
        return characterContentNew;
    } catch (e) {
      throw Exception(e);
    }
  }
}
