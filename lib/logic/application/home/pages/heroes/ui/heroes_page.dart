import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvelhero/infraestructure/injection_container.dart';
import 'package:marvelhero/logic/application/home/pages/heroes/bloc/heroes_bloc.dart';
import 'package:marvelhero/logic/application/home/pages/heroes/bloc/heroes_state.dart';
import 'package:marvelhero/logic/application/home/pages/heroes/ui/widgets/heroes_loaded.dart';
import 'package:marvelhero/logic/application/home/ui/wdigets/home_error.dart';
import 'package:marvelhero/logic/application/shared/util/admob_manager.dart';
import 'package:marvelhero/logic/application/shared/util/marvel_assets.dart';
import 'package:marvelhero/logic/application/shared/widgets/hero_loading.dart';

class HeroesPage extends StatefulWidget {
  @override
  _HeroesPageState createState() => _HeroesPageState();
}

class _HeroesPageState extends State<HeroesPage>
    with AutomaticKeepAliveClientMixin {
  BannerAd _bannerAd;

  @override
  void initState() {
    super.initState();
    // _bannerAd = BannerAd(
    //     adUnitId: AdManager.bannerAdUnitId,
    //     size: AdSize.fullBanner);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // _bannerAd
    //   ..load()
    //   ..show(
    //       anchorType: AnchorType.bottom,
    //       anchorOffset: -MediaQuery.of(context).padding.bottom);
    return BlocProvider(
        create: (_) => sl<HeroesBloc>()..getHeroes(),
        child: BlocBuilder<HeroesBloc, HeroesState>(builder: (context, state) {
          if (state is HeroesUnitialized || state is HeroesLoading)
            return HeroLoading(MarvelAssets.ironMan,
                'Iron Man is gathering all the heroes this might take a while...');
          else if (state is HeroesLoaded)
            return HeroesLoadedContent(
                heroes: state.heroes, hasReachedMax: state.hasReachedMax);
          else if (state is HeroesError) {
            return HomeError(state.errorMessage);
          }
          return Container(); //Si todo va mal...
        }));
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
