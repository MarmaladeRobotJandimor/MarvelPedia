import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvelhero/infraestructure/injection_container.dart';
import 'package:marvelhero/logic/application/home/pages/heroes/bloc/heroes_bloc.dart';
import 'package:marvelhero/logic/application/home/pages/heroes/bloc/heroes_state.dart';
import 'package:marvelhero/logic/application/home/pages/heroes/ui/widgets/heroes_loaded.dart';
import 'package:marvelhero/logic/application/shared/util/marvel_assets.dart';
import 'package:marvelhero/logic/application/shared/widgets/hero_loading.dart';

class HeroSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.length < 3) {
      return HeroLoading(MarvelAssets.wolverine,
          "Search term must be longer than two letters.");
    }

    //ignore: close_sinks
    var bloc = HeroesBloc(sl());

    return BlocProvider(
        create: (_) => bloc..searchHeroes(query),
        child: BlocBuilder<HeroesBloc, HeroesState>(builder: (context, state) {
          if (state is HeroesUnitialized) {
            return Center(child: Text(''));
          } else if (state is HeroesLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is SearchHeroesLoaded) {
            return HeroesLoadedContent(
                heroes: state.heroes, hasReachedMax: state.hasReachedMax);
          } else if (state is SearchHeroesEmpty) {
            return Center(
              child: HeroLoading(
                  MarvelAssets.drStrange, "Dr.Strange can´t find that hero."),
            );
          } else if (state is HeroesError) {
            return Center(child: Text(state.errorMessage));
          }
          return Container();
        }));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // This method is called everytime the search term changes.
    // If you want to add search suggestions as the user enters their search term, this is the place to do that.
    return Column();
  }
}
