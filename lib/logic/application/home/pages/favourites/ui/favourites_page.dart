import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/fa_icon.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FavouritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(color: Colors.black),
          backgroundColor: Colors.white,
          brightness: Brightness.light,
          elevation: 0,
          bottom: TabBar(
            indicatorColor: Colors.black,
            tabs: [
              Tab(icon: FaIcon(FontAwesomeIcons.users, color: Colors.black)),
              Tab(icon: FaIcon(FontAwesomeIcons.bookOpen, color: Colors.black)),
            ],
          ),
          title: Text(
            'FAVOURITES',
            style: TextStyle(fontFamily: 'marvel', color: Colors.black),
          ),
        ),
        body: TabBarView(children: <Widget>[
          Icon(Icons.directions_car),
          Icon(Icons.directions_transit),
        ]),
      ),
      length: 2,
    );
  }
}
