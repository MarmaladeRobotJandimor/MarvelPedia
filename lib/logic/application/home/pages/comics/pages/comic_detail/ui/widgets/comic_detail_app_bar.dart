import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:like_button/like_button.dart';
import 'package:marvelhero/data/models/comics/comics.dart';
import 'package:marvelhero/infraestructure/injection_container.dart';
import 'package:marvelhero/logic/application/home/pages/comics/pages/comic_detail/bloc/comic_detail_bloc.dart';

class ComicDetailAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Comic comic;

  ComicDetailAppBar({@required this.comic});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: <Widget>[
          // Padding(
          //   padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
          //   child: LikeButton(
          //     circleColor:
          //         CircleColor(start: Colors.red[100], end: Colors.red[300]),
          //     bubblesColor: BubblesColor(
          //       dotPrimaryColor: Colors.purple,
          //       dotSecondaryColor: Colors.pink,
          //     ),
          //     isLiked: comic.isFavourite == null ? false : comic.isFavourite,
          //     onTap: (isLiked) {
          //       sl.get<ComicDetailBloc>()..favouriteComic(!isLiked, comic.id);
          //       return Future.value(!isLiked);
          //     },
          //     likeBuilder: (bool isLiked) {
          //       return Icon(
          //         !isLiked ? FontAwesomeIcons.heart : Icons.favorite,
          //         color: isLiked ? Colors.red : Colors.black,
          //       );
          //     },
          //   ),
          // ),
        
        ],
        leading: BackButton(color: Colors.black));
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
