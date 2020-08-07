import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvelhero/data/models/character/marvel_character.dart';
import 'package:marvelhero/data/models/comics/comics.dart';
import 'package:marvelhero/infraestructure/injection_container.dart';
import 'package:marvelhero/logic/application/home/pages/comics/pages/comic_detail/ui/comic_detail.dart';
import 'package:marvelhero/logic/application/home/pages/heroes/pages/hero_detail/bloc/hero_detail_bloc.dart';
import 'package:marvelhero/logic/application/home/pages/heroes/pages/hero_detail/bloc/hero_detail_state.dart';
import 'package:marvelhero/logic/application/home/pages/heroes/pages/hero_detail/ui/widgets/fade_hero_icon_hero_detail.dart';
import 'package:marvelhero/logic/application/shared/behaviours/remove_list_glow.dart';
import 'package:marvelhero/logic/application/shared/util/marvel_util.dart';
import 'package:marvelhero/logic/application/shared/widgets/hero_image.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class HeroDetail extends StatefulWidget {
  final MarvelCharacter hero;
  final Key key;

  HeroDetail({@required this.hero, this.key});

  @override
  _HeroDetailState createState() => _HeroDetailState();
}

class _HeroDetailState extends State<HeroDetail> with TickerProviderStateMixin {
  PaletteGenerator paletteGenerator;
  ScrollController scrollController = ScrollController();
  RoundedLoadingButtonController _btnController =
      new RoundedLoadingButtonController();

  //ignore: close_sinks
  HeroDetailBloc _heroDetailBloc;
  double heightOfAppBar;
  List<Comic> comics = List<Comic>();
  bool isLoading = true;
  bool canShowLoadMore = false;
  int take = 20;
  int skip = 0;

  @override
  initState() {
    super.initState();
    _heroDetailBloc = sl.get<HeroDetailBloc>()
      ..getHeroesContent(widget.hero.id, take, skip);
  }

  void _loadMoreComics() async {
    skip = take;
    take = take + 20;
    _heroDetailBloc.getMoreHeroesComics(widget.hero.id, take, skip);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var imageSize = size.height * 0.4;
    var topMaring = MediaQuery.of(context).viewPadding.top;
    heightOfAppBar = imageSize + topMaring;
    var mainColor = Colors.white;

    //var heroContents = HeroContentsHeroDetail(hero: this.widget.hero);

    var heroDescription = HeroDescription(widget.hero.description);
    var comicTitle = HeroComicTitle(widget.hero.comics.available);

    var mainColumn = Column(
        crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[]);

    if (widget.hero.description.isNotEmpty) {
      mainColumn.children.insert(0, heroDescription);
    }

    if (widget.hero.comics.available > 0) {
      mainColumn.children.add(comicTitle);
    }

    var loadMoreButton = HeroLoadMoreButton(_loadMoreComics, _btnController);

    return Scaffold(
        backgroundColor: mainColor,
        body: ScrollConfiguration(
            behavior: RemoveGlowListBehavior(),
            child: BlocBuilder<HeroDetailBloc, HeroeDetailState>(
                bloc: _heroDetailBloc,
                builder: (context, state) {
                  if (state is HeroContentLoaded) {
                    this.comics = state.comics;
                    isLoading = false;
                    try {
                      _btnController?.reset();
                    } catch (e) {}
                    if (widget.hero.comics.available > 20) {
                      canShowLoadMore = true;
                      if (this.comics.length >= widget.hero.comics.available) {
                        canShowLoadMore = false;
                      }
                    }
                  }
                  return CustomScrollView(
                      controller: scrollController,
                      slivers: <Widget>[
                        SliverAppBar(
                            pinned: true,
                            automaticallyImplyLeading: false,
                            brightness: Brightness.light,
                            backgroundColor: mainColor,
                            expandedHeight: imageSize,
                            elevation: 2,
                            titleSpacing: 0.0,
                            customExtent: true,
                            leading: HeroDetailFadeHeroIcon(
                                scrollController,
                                widget.hero.thumbnail.toString(),
                                heightOfAppBar),
                            flexibleSpace: FlexibleSpaceBar(
                                collapseMode: CollapseMode.pin,
                                centerTitle: true,
                                background: HeroImage(
                                    color: mainColor,
                                    id: widget.hero.id,
                                    height: double.infinity,
                                    width: size.width,
                                    image: widget.hero.thumbnail.toString(),
                                    fit: BoxFit.cover),
                                title: HeroDetailTitle(widget.hero.name,
                                    scrollController, heightOfAppBar))),
                        SliverToBoxAdapter(child: heroDescription),
                        SliverToBoxAdapter(
                            child: widget.hero.comics.available > 0
                                ? comicTitle
                                : Center(
                                    child: Text(
                                    "NOTHING TO SHOW HERE",
                                    style: TextStyle(
                                        fontFamily: 'marvel', fontSize: 30),
                                  ))),
                        SliverGrid(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 1 / 2, crossAxisCount: 3),
                          delegate: SliverChildBuilderDelegate(
                              (context, index) {
                            return widget.hero.comics.available > 0
                                ? AnimatedSwitcher(
                                    duration: Duration(milliseconds: 500),
                                    child: isLoading
                                        ? HeroComicPlaceHolderTile()
                                        : HeroComicTile(this.comics[index]))
                                : Container();
                          },
                              childCount: isLoading
                                  ? widget.hero.comics.available
                                  : this.comics.length),
                        ),
                        canShowLoadMore ? loadMoreButton : SliverToBoxAdapter(),
                        SliverToBoxAdapter(
                            child: Container(
                                height: this.comics != null
                                    ? (this.comics.length >= 10
                                        ? 0
                                        : MediaQuery.of(context).size.height /
                                            2)
                                    : 0)),
                        SliverToBoxAdapter(child: Container(height: 80))
                      ]);
                })));
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}

class HeroDetailTitle extends StatefulWidget {
  final String name;
  final ScrollController scrollController;
  final double heightOfAppBar;

  HeroDetailTitle(this.name, this.scrollController, this.heightOfAppBar);

  @override
  _HeroDetailTitleState createState() => _HeroDetailTitleState();
}

class _HeroDetailTitleState extends State<HeroDetailTitle> {
  double _offset;
  double buttonSize = 40;

  @override
  initState() {
    super.initState();
    widget.scrollController.addListener(_setOffset);
  }

  double _calculateTranslateOnScroll(double distance) {
    if (_offset != null && _offset >= 0 && _offset <= widget.heightOfAppBar) {
      var percentage =
          MarvelUtil.inverserThreeRule(widget.heightOfAppBar, _offset) / 100;
      var moveTo = distance * percentage;
      return moveTo;
    } else if (_offset != null &&
        _offset >= 0 &&
        _offset >= widget.heightOfAppBar) {
      return distance;
    } else {
      return 0.0;
    }
  }

  void _setOffset() {
    setState(() {
      _offset = widget.scrollController.offset;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: _calculateTranslateOnScroll(widget.name.length > 15
              ? (widget.name.length * 2.5).toDouble()
              : 0)),
      child: AutoSizeText(
        widget.name.toUpperCase(),
        minFontSize: 10,
        maxFontSize: 30,
        textAlign: TextAlign.left,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontFamily: 'marvel', color: Colors.black),
      ),
    );
  }
}

class HeroDescription extends StatelessWidget {
  final String description;

  HeroDescription(this.description);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 30),
      child: AutoSizeText(
        this.description,
        style: TextStyle(
            decoration: TextDecoration.none,
            fontFamily: 'marvel',
            fontSize: 15,
            color: Colors.black),
      ),
    );
  }
}

class HeroComicTitle extends StatelessWidget {
  final int comics;

  HeroComicTitle(this.comics);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text('$comics COMICS',
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 25, color: Colors.black, fontFamily: 'marvel')),
        ],
      ),
    );
  }
}

class HeroLoadMoreButton extends StatelessWidget {
  final Function onPressed;
  final RoundedLoadingButtonController roundedLoadingButtonController;
  HeroLoadMoreButton(this.onPressed, this.roundedLoadingButtonController);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: Padding(
      padding: EdgeInsets.fromLTRB(50, 10, 50, 0),
      child: RoundedLoadingButton(
        color: Colors.black,
        child: Text('LOAD MORE',
            style: TextStyle(
                color: Colors.white,
                fontFamily: "marvel",
                fontSize: 22,
                letterSpacing: 2.0)),
        controller: roundedLoadingButtonController,
        onPressed: onPressed,
      ),
    ));
  }
}

class HeroComicTile extends StatelessWidget {
  final Comic comic;

  HeroComicTile(this.comic);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      key: UniqueKey(),
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => ComicDetail(this.comic)));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            child: Column(children: <Widget>[
          SizedBox(
              height: size.height * 0.2,
              child: CachedNetworkImage(
                  imageUrl: comic.thumbnail.toString(),
                  fit: BoxFit.fitHeight,
                  placeholder: (c, b) => Container(
                      height: size.height * 0.2, color: Colors.black26))),
          SizedBox(height: 10),
          AutoSizeText(
            comic.title,
            maxLines: 3,
            textAlign: TextAlign.left,
            minFontSize: 10,
            maxFontSize: 15,
            overflow: TextOverflow.ellipsis,
          ),
        ])),
      ),
    );
  }
}

class HeroComicPlaceHolderTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      key: UniqueKey(),
      padding: const EdgeInsets.all(8.0),
      child: Container(
          child: Column(children: <Widget>[
        SizedBox(
            height: size.height * 0.2,
            child: Container(height: size.height * 0.2, color: Colors.black26)),
        SizedBox(height: 10),
        Container(height: 15, color: Colors.black26),
        SizedBox(height: 4),
        Container(height: 15, color: Colors.black26)
      ])),
    );
  }
}
