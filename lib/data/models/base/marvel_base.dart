import 'package:equatable/equatable.dart';
import 'package:marvelhero/core/models/base.dart';
import 'package:marvelhero/data/models/character/marvel_character.dart';
import 'package:marvelhero/data/models/comics/comics.dart';
import 'package:marvelhero/data/models/series/series.dart';

class MarvelBase<T extends BaseModel>  extends Equatable {
  final int offset;
  final int limit;
  final int total;
  final int count;
  final List<T> results;

  MarvelBase(this.offset, this.limit, this.count, this.total, this.results);

  MarvelBase.fromJson(Map<String, dynamic> json)
      : offset = json['offset'],
        limit = json['limit'],
        count = json['count'],
        total = json['total'],
        results = deserializeData(json, T);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['offset'] = offset;
    data['limit'] = limit;
    data['count'] = count;
    data['total'] = total;
    data['results'] = results?.map((r) => r.toJson())?.toList(growable: false);
    return data;
  }

  static List deserializeData(Map<String, dynamic> json, Type t) {
    if (t == MarvelCharacter) {
      return (json['results'] as List)
          .map((i) => MarvelCharacter.fromJson(i))
          .toList();
    } else if (t == Comic) {
      return (json['results'] as List).map((i) => Comic.fromJson(i)).toList();
    } else if (t == Series) {
      return (json['results'] as List).map((i) => Series.fromJson(i)).toList();
    }
    return List();
  }


  @override
  String toString() => 'MarvelBase { results: $results }';

  @override
  List<Object> get props => [results];
}
