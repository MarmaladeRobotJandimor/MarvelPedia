import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvelhero/data/models/comics/comics.dart';
import 'package:marvelhero/infraestructure/injection_container.dart';
import 'package:marvelhero/logic/application/home/pages/comics/pages/comic_detail/bloc/comic_detail_bloc.dart';
import 'package:marvelhero/logic/application/home/pages/comics/pages/comic_detail/bloc/comic_detail_state.dart';
import 'package:marvelhero/logic/application/home/pages/comics/pages/comic_detail/ui/widgets/url_selection.dart';
import 'package:marvelhero/logic/application/home/pages/heroes/pages/hero_detail/ui/hero_detail.dart';
import 'package:marvelhero/logic/application/shared/behaviours/remove_list_glow.dart';
import 'package:url_launcher/url_launcher.dart';

class ComicDetailContent extends StatelessWidget {
  final Comic comic;
  final TextStyle titleStyle =
      const TextStyle(fontFamily: 'marvel', fontSize: 25);
  final TextStyle btnStyle =
      const TextStyle(fontFamily: 'marvel', fontSize: 20, color: Colors.white);
  final TextStyle heroName =
      const TextStyle(fontFamily: 'marvel', color: Colors.black);

  ComicDetailContent(this.comic);

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return BlocBuilder<ComicDetailBloc, ComicDetailState>(
        cubit: sl.get<ComicDetailBloc>()..getDetail(comic),
        builder: (context, state) {
          if (state is ComicDetailLoaded) {
            var backButton = BackButton();

            var rowComicContent = Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(width: 30),
                  Stack(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              blurRadius: 10.0,
                              spreadRadius: 0.1,
                              offset: Offset(5.0, 10.0))
                        ]),
                        height: size.height / 3.7,
                        width: size.width / 2.7,
                      ),
                      SizedBox(
                          height: size.height / 3.5,
                          width: size.width / 2.5,
                          child: CachedNetworkImage(
                              imageUrl: state.comic.thumbnail.toString(),
                              fit: BoxFit.contain)),
                    ],
                  ),
                  Spacer(),
                  Container(
                    height: size.height / 3.5,
                    width: size.width / 2.5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        AutoSizeText(state.comic.title.toUpperCase(),
                            style: titleStyle,
                            maxLines: 5,
                            minFontSize: 15,
                            maxFontSize: 25),
                        state.comic.urls.length > 1
                            ? UrlSelection(comic.urls)
                            : SizedBox(
                                height: 50,
                                child: FlatButton(
                                    color: Colors.black,
                                    onPressed: () =>
                                        _launchURL(state.comic.urls[0].url),
                                    child: Text(
                                        state.comic.urls[0].type.toUpperCase(),
                                        style: btnStyle)))
                      ],
                    ),
                  ),
                  SizedBox(width: 30)
                ]);

            var listWidgets = <Widget>[];

            if (state.comic.description != null &&
                state.comic.description.isNotEmpty) {
              listWidgets.add(Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0),
                child: AutoSizeText(state.comic.description,
                    maxLines: 10000,
                    maxFontSize: 15,
                    minFontSize: 13,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontFamily: 'marvel')),
              ));
            }

            if (state.heroes.isNotEmpty) {
              listWidgets.add(Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Container(
                  height: 100,
                  width: double.infinity,
                  child: ScrollConfiguration(
                    behavior: RemoveGlowListBehavior(),
                    child: ListView.builder(
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        scrollDirection: Axis.horizontal,
                        itemCount: state.heroes.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        HeroDetail(hero: state.heroes[index]))),
                            child: Container(
                              height: 80,
                              width: 80,
                              child: Column(
                                children: <Widget>[
                                  Card(
                                      clipBehavior: Clip.antiAlias,
                                      shape: StadiumBorder(),
                                      child: CachedNetworkImage(
                                          height: 50,
                                          width: 50,
                                          fit: BoxFit.cover,
                                          imageUrl: state
                                              .heroes[index]?.thumbnail
                                              .toString())),
                                  AutoSizeText(
                                    state.heroes[index].name,
                                    style: heroName,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    minFontSize: 13,
                                    maxFontSize: 17,
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                ),
              ));
            }

            listWidgets.add(SizedBox(height: 60));
            var container = ScrollConfiguration(
                behavior: RemoveGlowListBehavior(),
                child: ListView(children: listWidgets));

            return SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  backButton,
                  SizedBox(height: 10),
                  Container(child: rowComicContent),
                  SizedBox(height: 20),
                  Expanded(child: container),
                ],
              ),
            );
          } else {
            return Container();
          }
        });
  }
}
