import 'package:equatable/equatable.dart';
import 'package:marvelhero/core/models/base.dart';
import 'package:marvelhero/data/shared_models/thumbnail/thumbnail.dart';

class Series extends Equatable implements BaseModel {
  final int id;
  final String title;
  final String description;
  final String resourceURI;
  //List<Urls> urls;
  final int startYear;
  final int endYear;
  final String rating;
  final String type;
  final String modified;
  final Thumbnail thumbnail;
  // Creators creators;
  // Creators characters;
  // Creators stories;
  // Creators comics;
  // Events events;
  // final int next;
  // final int previous;
  @override
  final bool isFavourite;
  Series(
      this.id,
      this.title,
      this.description,
      this.resourceURI,
      // this.urls,
      this.startYear,
      this.endYear,
      this.rating,
      this.type,
      this.modified,
      this.thumbnail,
      this.isFavourite
      // this.creators,
      // this.characters,
      // this.stories,
      // this.comics,
      // this.events,
      // this.next,
      // this.previous
      );

  Series.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        description = json['description'],
        resourceURI = json['resourceURI'],
        // if (json['urls'] != null) {
        //   urls = new List<Urls>();
        //   json['urls'].forEach((v) {
        //     urls.add(new Urls.fromJson(v));
        //   });
        // }
        startYear = json['startYear'],
        endYear = json['endYear'],
        isFavourite = json['isFavourite'],
        rating = json['rating'],
        type = json['type'],
        modified = json['modified'],
        thumbnail = json['thumbnail'] != null
            ? new Thumbnail.fromJson(json['thumbnail'])
            : null;
  // creators = json['creators'] != null
  //     ? new Creators.fromJson(json['creators'])
  //     : null;
  // characters = json['characters'] != null
  //     ? new Creators.fromJson(json['characters'])
  //     : null;
  // stories =
  //     json['stories'] != null ? new Creators.fromJson(json['stories']) : null;
  // comics =
  //     json['comics'] != null ? new Creators.fromJson(json['comics']) : null;
  // events =
  //     json['events'] != null ? new Events.fromJson(json['events']) : null;
  // next = json['next'],
  // previous = json['previous'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'resourceURI': resourceURI,
        'isFavourite': isFavourite,
        'thumbnail': thumbnail.toJson()
      };

  @override
  List<Object> get props => [];
}
