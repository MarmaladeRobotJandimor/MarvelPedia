import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'delegates/heroes_search_delegate.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Row(
          children: <Widget>[
            Text('MARVEL', style: Theme.of(context).textTheme.headline4),
            Text('PEDIA',
                style: Theme.of(context).textTheme.headline4.copyWith(
                    color: Color.fromRGBO(237, 29, 36, 1),
                    fontWeight: FontWeight.bold)),
          ],
        ),
        actions: <Widget>[
          IconButton(
              icon: FaIcon(FontAwesomeIcons.search),
              onPressed: () {
                showSearch(context: context, delegate: HeroSearchDelegate());
              })
        ],
        centerTitle: false,
        elevation: 0);
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
