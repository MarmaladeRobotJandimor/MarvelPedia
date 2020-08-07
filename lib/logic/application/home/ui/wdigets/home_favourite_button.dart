import 'package:flutter/material.dart';
import 'package:marvelhero/logic/application/home/pages/favourites/ui/favourites_page.dart';

class HomeFavouriteButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => FavouritesPage())),
      tooltip: 'My Favourites',
      backgroundColor: Colors.black,
      child: Icon(Icons.favorite),
      elevation: 10.0,
    );
  }
}
