import 'package:flutter/material.dart';
import 'package:marvelhero/data/models/comics/comics.dart';
import 'package:marvelhero/logic/application/home/pages/comics/pages/comic_detail/ui/widgets/comic_detail_app_bar.dart';
import 'package:marvelhero/logic/application/home/pages/comics/pages/comic_detail/ui/widgets/comic_detail_content.dart';

class ComicDetail extends StatelessWidget {
  final Comic comic;

  ComicDetail(this.comic);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: ComicDetailAppBar(comic: comic),
        body: ComicDetailContent(comic));
  }
}
