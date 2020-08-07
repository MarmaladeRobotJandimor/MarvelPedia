import 'package:equatable/equatable.dart';

import 'comics.dart';

class HeroComics extends Equatable {
  final int offset;
  final int limit;
  final int total;
  final int count;
  final int heroId;
  final List<Comic> results;

  HeroComics(this.count, this.heroId, this.limit, this.offset, this.results,
      this.total);

  HeroComics.fromJson(Map<String, dynamic> json)
      : heroId = json['heroId'],
        limit = json['limit'],
        total = json['total'],
        count = json['count'],
        offset = json['offset'],
        results = json['results'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['offset'] = this.offset;
    data['limit'] = this.limit;
    data['total'] = this.total;
    data['count'] = this.count;
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  List<Object> get props => [];
}
