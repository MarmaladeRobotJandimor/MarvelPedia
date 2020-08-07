import 'package:equatable/equatable.dart';
import 'package:marvelhero/core/models/base.dart';
import 'package:marvelhero/data/shared_models/thumbnail/thumbnail.dart';

class MarvelCharacter extends Equatable implements BaseModel {
  final int id;
  final String name;
  final String description;
  final Thumbnail thumbnail;
  final HeroItems comics;
  final HeroItems events;
  final HeroItems series;
  final HeroItems stories;
  @override
  final bool isFavourite;

  MarvelCharacter(this.id, this.name, this.thumbnail, this.description,
      this.comics, this.events, this.series, this.stories,this.isFavourite);

  MarvelCharacter.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        thumbnail = json['thumbnail'] != null
            ? Thumbnail.fromJson(json['thumbnail'])
            : null,
        comics =
            json['comics'] != null ? HeroItems.fromJson(json['comics']) : null,
        series =
            json['series'] != null ? HeroItems.fromJson(json['series']) : null,
        stories = json['stories'] != null
            ? HeroItems.fromJson(json['stories'])
            : null,
        events =
            json['events'] != null ? HeroItems.fromJson(json['events']) : null,
        description = json['description'],
        isFavourite = json['isFavourite'],
        name = json['name'];

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    data['comics'] = this.comics.toJson();
    data['events'] = this.events.toJson();
    data['series'] = this.series.toJson();
    data['stories'] = this.stories.toJson();
    data['name'] = this.name;
    data['isFavourite'] = this.isFavourite;
    data['thumbnail'] = this.thumbnail.toJson();
    return data;
  }

  @override
  String toString() => 'Character { Name: $name }';

  @override
  List<Object> get props => [id];
}

class HeroItems extends Equatable {
  final int available;
  final int returned;
  HeroItems(this.available, this.returned);

  HeroItems.fromJson(Map<String, dynamic> json)
      : returned = json['returned'],
        available = json['available'];

  Map<String, dynamic> toJson() =>
      {'available': available, 'returned': returned};

  @override
  List<Object> get props => [];
}
