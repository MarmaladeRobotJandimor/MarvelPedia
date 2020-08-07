import 'package:equatable/equatable.dart';

class MarvelUrl extends Equatable {
  final String type;
  final String url;

  MarvelUrl(this.type, this.url);

  MarvelUrl.fromJson(Map<String, dynamic> json)
      : type = json['type'],
        url = json['url'];

  Map<String, dynamic> toJson() => {'type': type, 'url': url};

  @override
  List<Object> get props => [type, url];

  @override
  String toString() => type;
}
