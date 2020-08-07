import 'package:flutter/material.dart';
import 'package:marvelhero/logic/application/home/pages/comics/ui/comics_page.dart';
import 'package:marvelhero/logic/application/home/pages/heroes/ui/heroes_page.dart';
import 'package:marvelhero/logic/application/shared/behaviours/remove_list_glow.dart';

class HomeContent extends StatefulWidget {
  final PageController pageController;
  final ValueChanged<int> onPageChanged;

  HomeContent({@required this.pageController, @required this.onPageChanged});

  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
        behavior: RemoveGlowListBehavior(),
        child: PageView(
            onPageChanged: widget.onPageChanged,
            controller: widget.pageController,
            children: <Widget>[
              HeroesPage(),
              ComicsPage(),
            ]));
  }
}
