import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:marvelhero/data/models/character/marvel_character.dart';
import 'package:marvelhero/data/models/comics/comics.dart';

abstract class ComicDetailState extends Equatable {}

class ComicDetailUnitialized extends ComicDetailState {
  @override
  List<Object> get props => [];
}

class ComicDetailLoaded extends ComicDetailState {
  final Comic comic;
  final List<MarvelCharacter> heroes;

  ComicDetailLoaded({@required this.comic, @required this.heroes});

  @override
  List<Object> get props => [comic];
}
