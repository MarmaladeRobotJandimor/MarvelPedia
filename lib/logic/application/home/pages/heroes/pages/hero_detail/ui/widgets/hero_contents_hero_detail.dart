import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marvelhero/data/models/character/marvel_character.dart';
import 'package:marvelhero/logic/application/shared/widgets/hero_information.dart';

class HeroContentsHeroDetail extends StatelessWidget {
  final MarvelCharacter hero;

  HeroContentsHeroDetail({@required this.hero});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        HeroInformation(
            color: Theme.of(context).textTheme.bodyText1.color,
            icon: FontAwesomeIcons.bookOpen,
            name: '${hero.comics.available} COMICS'),
        HeroInformation(
            color:  Theme.of(context).textTheme.bodyText1.color,
            icon: FontAwesomeIcons.tv,
            name: '${hero.series.available} SERIES'),
        HeroInformation(
            color:  Theme.of(context).textTheme.bodyText1.color,
            icon: FontAwesomeIcons.book,
            name: '${hero.stories.available} STORIES'),
        HeroInformation(
            color:  Theme.of(context).textTheme.bodyText1.color,
            icon: FontAwesomeIcons.calendar,
            name: '${hero.events.available} EVENTS'),
      ],
    );
  }
}
