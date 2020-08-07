import 'package:get_it/get_it.dart';
import 'package:marvelhero/infraestructure/dao/heroes_dao/character_content_dao/character_content_dao.dart';
import 'package:marvelhero/infraestructure/data_services/heroes_data_service/heroes_data_service.dart';
import 'package:marvelhero/logic/application/home/pages/comics/bloc/comics_bloc.dart';
import 'package:marvelhero/logic/application/home/pages/comics/pages/comic_detail/bloc/comic_detail_bloc.dart';
import 'package:marvelhero/logic/application/home/pages/heroes/bloc/heroes_bloc.dart';
import 'package:marvelhero/logic/application/home/pages/heroes/pages/hero_detail/bloc/hero_detail_bloc.dart';
import 'package:marvelhero/logic/services/data_services/comics/comics_data_service.dart';
import 'package:marvelhero/logic/services/data_services/heroes/character_content/character_content_dataservice.dart';
import 'package:marvelhero/logic/services/data_services/heroes/heroes_data_service.dart';
import 'package:marvelhero/remote/characters/characters_api_service.dart';
import 'package:marvelhero/remote/comics/comics_api_service.dart';

import 'dao/comics_dao/comics_dao.dart';
import 'dao/heroes_dao/heroes_dao.dart';

GetIt sl = GetIt.instance;

Future<void> init() async {
  //!Bloc
  sl.registerLazySingleton(() => HeroesBloc(sl()));
  sl.registerFactory(() => HeroDetailBloc(sl()));
  sl.registerLazySingleton(() => ComicsBloc(sl()));
  sl.registerLazySingleton(() => ComicDetailBloc(sl(),sl()));

  //!Remote Services
  sl.registerLazySingleton(() => CharactersMarvelApiService());
  sl.registerLazySingleton(() => ComicsMarvelApiService());

  //DAO
  sl.registerLazySingleton(() => HeroesDao());
  sl.registerLazySingleton(() => ComicsDao());
  sl.registerLazySingleton(() => CharacterContentDao());

  //DataServices
  sl.registerLazySingleton<HeroesDataService>(
      () => HeroesDataServiceImpl(sl(), sl()));
  sl.registerLazySingleton(() => ComicsDataService(sl(), sl()));
  sl.registerLazySingleton(() => CharacterContentDataService(sl(), sl()));
}
