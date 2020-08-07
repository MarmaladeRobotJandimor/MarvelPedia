import 'package:equatable/equatable.dart';
import 'package:marvelhero/data/models/base/marvel_base.dart';
import 'package:marvelhero/data/models/comics/comics.dart';

class CharacterContent extends Equatable {
  final MarvelBase<Comic> heroComics;
  final int heroId;

  CharacterContent(this.heroComics, this.heroId);

  CharacterContent.fromJson(Map<String, dynamic> json)
      : heroId = json['heroId'],
        heroComics = MarvelBase<Comic>.fromJson(json['heroComics']);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['heroComics'] = this.heroComics.toJson();
    data['heroId'] = this.heroId;
    return data;
  }

  @override
  List<Object> get props => [];
}
