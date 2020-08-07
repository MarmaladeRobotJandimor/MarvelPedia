import 'package:equatable/equatable.dart';

class Thumbnail extends Equatable {
  final String path;
  final String ext;

  Thumbnail(this.path, this.ext);

  Thumbnail.fromJson(Map<String, dynamic> json)
      : path = json['path'],
        ext = json['extension'];

  Map<String, dynamic> toJson() => {'path': path, 'extension': ext};

  @override
  List<Object> get props => [path, ext];

  @override
  String toString() {
    return path + '.' + ext;
  }
}
