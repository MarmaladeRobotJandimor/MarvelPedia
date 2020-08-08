import 'package:bloc/bloc.dart';
import 'package:marvelhero/data/models/character/marvel_character.dart';
import 'package:marvelhero/data/models/comics/comics.dart';
import 'package:marvelhero/infraestructure/data_services/heroes_data_service/heroes_data_service.dart';
import 'package:marvelhero/logic/application/home/pages/comics/pages/comic_detail/bloc/comic_detail_event.dart';
import 'package:marvelhero/logic/services/data_services/comics/comics_data_service.dart';
import 'package:sembast/sembast.dart';

import 'comic_detail_state.dart';

class ComicDetailBloc extends Bloc<ComicDetailEvent, ComicDetailState> {
  final HeroesDataService heroesDataService;
  final ComicsDataService comicsDataService;

  ComicDetailBloc(this.heroesDataService, this.comicsDataService)
      : assert(heroesDataService != null && comicsDataService != null) , super(ComicDetailUnitialized());

  @override
  Stream<ComicDetailState> mapEventToState(ComicDetailEvent event) async* {
    try {
      if (event is LoadComic) {
        var heroes = await getHeroes(event);
        yield ComicDetailLoaded(comic: event.comic, heroes: heroes);
      } else if (event is FavouriteComic) {
        await comicsDataService.setFvouriteComic(event.comicId, event.isFavourite);
      }
    } catch (e) {}
  }

  Future<List<MarvelCharacter>> getHeroes(LoadComic event) async {
    var heroes = List<MarvelCharacter>();
    for (final item in event.comic.characters.items) {
      var hero = await heroesDataService
          .getHero(Finder(filter: Filter.equals('name', item.name)));
      if (hero != null) {
        heroes.add(hero);
      }
    }
    return heroes;
  }

  void getDetail(Comic comic) {
    add(LoadComic(comic: comic));
  }

  void favouriteComic(bool isFavourtie, int comicId) {
    add(FavouriteComic(isFavourite: isFavourtie, comicId: comicId));
  }
}
