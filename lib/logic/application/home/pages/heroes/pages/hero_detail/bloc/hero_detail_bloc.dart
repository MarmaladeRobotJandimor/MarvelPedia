import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvelhero/data/models/character/character_content.dart';
import 'package:marvelhero/data/models/series/series.dart';
import 'package:marvelhero/logic/application/home/pages/heroes/pages/hero_detail/bloc/hero_detail_state.dart';
import 'package:marvelhero/logic/services/data_services/heroes/character_content/character_content_dataservice.dart';

import 'hero_detail_event.dart';

class HeroDetailBloc extends Bloc<HeroeDetailEvent, HeroeDetailState> {
  CharacterContentDataService _characterContentDataService;
  CharacterContent characterContent;

  HeroDetailBloc(this._characterContentDataService)
      : assert(_characterContentDataService != null),super(ComicsUnitialized());

  @override
  Stream<HeroeDetailState> mapEventToState(event) async* {
    try {
      if (event is GetHeroContent) {
        yield HeroContentLoading();
        characterContent = await _characterContentDataService
            .getCharacterContent(event.idHero, event.take, event.skip);
        yield HeroContentLoaded(
            comics: characterContent.heroComics.results,
            series: List<Series>());
      } else if (event is GetMoreHerComics) {
        yield HeroContentLoading();
        var newCharContent = await _characterContentDataService
            .getMoreCharacterComics(event.idHero, event.take, event.skip);
        characterContent.heroComics.results
            .addAll(newCharContent.heroComics.results);
        yield HeroContentLoaded(
            comics: characterContent.heroComics.results,
            series: List<Series>());
      }
    } catch (_) {
      yield HeroContentLoadedError(errorMessage: 'Error message');
    }
  }

  void getHeroesContent(int idHero, int take, int skip) {
    add(GetHeroContent(idHero, take, skip));
  }

  void getMoreHeroesComics(int idHero, int take, int skip) {
    add(GetMoreHerComics(idHero, take, skip));
  }
}
