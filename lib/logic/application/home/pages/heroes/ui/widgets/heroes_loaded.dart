import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:marvelhero/data/models/character/marvel_character.dart';
import 'package:marvelhero/logic/application/home/pages/heroes/bloc/heroes_bloc.dart';
import 'package:marvelhero/logic/application/home/pages/heroes/bloc/heroes_state.dart';
import 'package:marvelhero/logic/application/home/pages/heroes/pages/hero_detail/ui/hero_detail.dart';
import 'package:marvelhero/logic/application/shared/behaviours/remove_list_glow.dart';
import 'package:marvelhero/logic/application/shared/widgets/hero_image.dart';

class HeroesLoadedContent extends StatefulWidget {
  final List<MarvelCharacter> heroes;
  final bool hasReachedMax;

  HeroesLoadedContent({this.heroes, this.hasReachedMax: false});

  @override
  _HeroesLoadedContentState createState() => _HeroesLoadedContentState();
}

class _HeroesLoadedContentState extends State<HeroesLoadedContent> {
  ScrollController _scrollController;
  StreamSubscription<ConnectivityResult> subscription;
  final _scrollThreshold = 200.0;

  _HeroesLoadedContentState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      BlocProvider.of<HeroesBloc>(context).getHeroes();
    }
  }

  @override
  initState() {
    super.initState();
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result != ConnectivityResult.none)
        BlocProvider.of<HeroesBloc>(context)
            .getHeroes(returnFromNoConnectivity: true);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HeroesBloc, HeroesState>(
      listener: (context, state) {},
      child: AnimationLimiter(
        child: Container(
          color: Colors.white,
          child: ScrollConfiguration(
            behavior: RemoveGlowListBehavior(),
            child: ListView.builder(
                padding: EdgeInsets.only(bottom: 65),
                controller: _scrollController,
                itemCount: widget.hasReachedMax
                    ? widget.heroes.length
                    : widget.heroes.length + 1,
                itemBuilder: (context, index) {
                  return index >= widget.heroes.length
                      ? BottomLoader()
                      : HeroeListTile(index, widget.heroes[index]);
                }),
          ),
        ),
      ),
    );
  }
}

class HeroeListTile extends StatelessWidget {
  final int index;
  final MarvelCharacter hero;
  final Radius border = Radius.circular(35.0);
  HeroeListTile(this.index, this.hero);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return AnimationConfiguration.staggeredList(
      position: index,
      duration: const Duration(milliseconds: 375),
      child: SlideAnimation(
        horizontalOffset: 250.0,
        child: FadeInAnimation(
          child: GestureDetector(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => HeroDetail(
                        hero: hero,
                        key: UniqueKey(),
                      ))),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 30, 0, 0),
                child: Container(
                  height: size.height / 4,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[300],
                        blurRadius: 20.0,
                        spreadRadius: 0.5,
                        offset: Offset(size.width / 3, 20),
                      )
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: border,
                      bottomLeft: border,
                    ),
                  ),
                  child: Row(
                    children: <Widget>[
                      HeroImage(
                        id: hero.id,
                        width: (size.width / 2),
                        height: size.height,
                        radius: border,
                        image: hero.thumbnail.toString(),
                      ),
                      SizedBox(width: 20),
                      Container(
                        width: (size.width / 2) - 60,
                        height: (size.height / 4),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            AutoSizeText(
                              hero.name,
                              style: TextStyle(
                                  fontFamily: 'marvel',
                                  fontWeight: FontWeight.w800,
                                  fontSize: 25),
                              maxFontSize: 25,
                              minFontSize: 16,
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                              child: AutoSizeText(
                                hero.description.isEmpty
                                    ? 'No description available'
                                    : hero.description,
                                style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 14,
                                    fontFamily: 'marvel'),
                                maxLines: 5,
                                presetFontSizes: [17, 15, 13],
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                AutoSizeText(
                                  'More info',
                                  style: TextStyle(fontFamily: 'marvel'),
                                  maxFontSize: 20,
                                  minFontSize: 13,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Spacer(),
                                Icon(Icons.keyboard_arrow_right)
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 20),
                    ],
                  ),
                ),
              )),
        ),
      ),
    );
  }
}

class BottomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: SizedBox(
          width: 70,
          height: 70,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          ),
        ),
      ),
    );
  }
}
