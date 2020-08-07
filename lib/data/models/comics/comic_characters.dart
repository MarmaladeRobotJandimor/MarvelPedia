import 'package:equatable/equatable.dart';

class ComicCharacters extends Equatable {
  final int available;
  final String collectionURI;
  final List<Items> items;
  final int returned;

  ComicCharacters(
      {this.available, this.collectionURI, this.items, this.returned});

  ComicCharacters.fromJson(Map<String, dynamic> json)
      : collectionURI = json['collectionURI'],
        returned = json['returned'],
        items = _deserializeList(json),
        available = json['available'];

  static List<Items> _deserializeList(Map<String, dynamic> json) {
    var list = List<Items>();
    json['items'].forEach((v) => list.add(Items.fromJson(v)));
    return list;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['available'] = this.available;
    data['collectionURI'] = this.collectionURI;
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    data['returned'] = this.returned;
    return data;
  }

  @override
  List<Object> get props => [];
}

class Items {
  String resourceURI;
  String name;

  Items({this.resourceURI, this.name});

  Items.fromJson(Map<String, dynamic> json) {
    resourceURI = json['resourceURI'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['resourceURI'] = this.resourceURI;
    data['name'] = this.name;
    return data;
  }
}
