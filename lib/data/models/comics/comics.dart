import 'package:equatable/equatable.dart';
import 'package:marvelhero/core/models/base.dart';
import 'package:marvelhero/data/models/comics/comic_characters.dart';
import 'package:marvelhero/data/shared_models/thumbnail/thumbnail.dart';
import 'package:marvelhero/data/shared_models/urls/marvel_url.dart';

class Comic extends Equatable implements BaseModel {
  final int id;
  final String title;
  final String description;
  final Thumbnail thumbnail;
  final String format;
  final List<MarvelUrl> urls;
  final ComicCharacters characters;
  @override
  final bool isFavourite;

  Comic(this.id, this.title, this.thumbnail, this.description, this.format,
      this.urls, this.isFavourite, this.characters);

  Comic.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        format = json['format'],
        thumbnail = Thumbnail.fromJson(json['thumbnail']),
        urls = json['urls'] != null ? _deserializeList(json) : null,
        description = json['description'],
        isFavourite = json['isFavourite'],
        characters = ComicCharacters.fromJson(json['characters']),
        title = json['title'];

  Comic copyWith(
      {int id,
      String format,
      String thumbnail,
      List<MarvelUrl> urls,
      String description,
      bool isFavourite,
      ComicCharacters characters,
      String title}) {
    return Comic(
        id ?? this.id,
        title ?? this.title,
        thumbnail ?? this.thumbnail,
        description ?? this.description,
        format ?? this.format,
        urls ?? this.urls,
        isFavourite ?? this.isFavourite,
        characters ?? this.characters);
  }

  static List<MarvelUrl> _deserializeList(Map<String, dynamic> json) {
    var list = List<MarvelUrl>();
    json['urls'].forEach((v) => list.add(MarvelUrl.fromJson(v)));
    return list;
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['description'] = description;
    data['title'] = title;
    data['format'] = format;
    data['format'] = format;
    data['isFavourite'] = isFavourite;
    data['thumbnail'] = thumbnail.toJson();
    data['characters'] = characters.toJson();
    if (this.urls != null) {
      data['urls'] = this.urls.map((v) => v.toJson()).toList();
    }
    // 'id': id,
    // 'description': description,
    // 'title': title,
    // 'format': format,
    // 'thumbnail': thumbnail.toJson(),
    return data;
  }

  @override
  String toString() => 'Comics { title: $title }';

  @override
  List<Object> get props => [id];
}
