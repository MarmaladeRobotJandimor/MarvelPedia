import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:marvelhero/data/models/comics/comics.dart';
import 'package:marvelhero/logic/application/home/pages/comics/pages/comic_detail/ui/comic_detail.dart';
import 'package:marvelhero/logic/application/shared/widgets/platform_image.dart';

class ComicsLoadedContent extends StatelessWidget {
  final List<Comic> comics;
  ComicsLoadedContent(this.comics);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GridView.count(
        crossAxisCount: 3,
        childAspectRatio: ((size.width / 3) / (size.height / 3)),
        children: List.generate(comics.length, (index) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ComicDetail(comics[index])));
            },
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 20, 8.0, 10),
                  child: Hero(
                    tag: comics[index].id,
                    child: Container(
                      decoration:
                          BoxDecoration(shape: BoxShape.rectangle, boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            blurRadius: 4.0,
                            spreadRadius: 0.5,
                            offset: Offset(2.0, 3.0))
                      ]),
                      child: PlatformImage(
                        height: size.height * 0.25,
                        fit: BoxFit.cover,
                        url: comics[index].thumbnail.toString(),
                        placeholder: Container(
                          height: size.height * 0.25,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                    width: size.width / 4,
                    child: AutoSizeText(
                      comics[index].title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          fontFamily: 'marvel',
                          color: Colors.black,
                          fontSize: 13),
                    ))
              ],
            ),
          );
        }));
  }
}
