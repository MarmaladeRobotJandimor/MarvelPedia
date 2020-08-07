import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:marvelhero/data/models/comics/comics.dart';

abstract class ComicDetailEvent extends Equatable {}

class LoadComic extends ComicDetailEvent {
  final Comic comic;

  LoadComic({@required this.comic});

  @override
  List<Object> get props => [comic];
}

class FavouriteComic extends ComicDetailEvent {
  final bool isFavourite;
  final int comicId;
  FavouriteComic({@required this.isFavourite, @required this.comicId});

  @override
  List<Object> get props => [];
}
