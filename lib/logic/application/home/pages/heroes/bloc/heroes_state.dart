import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:marvelhero/data/models/character/marvel_character.dart';

abstract class HeroesState extends Equatable {
  const HeroesState();

  @override
  List<Object> get props => [];
}

class HeroesUnitialized extends HeroesState {}

class HeroesLoading extends HeroesState {}

class SearchHeroesEmpty extends HeroesState {}

class HeroesLoaded extends HeroesState {
  final List<MarvelCharacter> heroes;
  final bool hasReachedMax;

  HeroesLoaded({@required this.heroes, @required this.hasReachedMax});

  HeroesLoaded copyWith({
    List<MarvelCharacter> heroes,
    bool hasReachedMax,
  }) {
    return HeroesLoaded(
      heroes: heroes ?? this.heroes,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [heroes, hasReachedMax];
}

class SearchHeroesLoaded extends HeroesState {
  final List<MarvelCharacter> heroes;
  final bool hasReachedMax;

  SearchHeroesLoaded({this.heroes, this.hasReachedMax});

  SearchHeroesLoaded copyWith({
    List<MarvelCharacter> heroes,
    bool hasReachedMax,
  }) {
    return SearchHeroesLoaded(
      heroes: heroes ?? this.heroes,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [heroes, hasReachedMax];
}

class HeroesError extends HeroesState {
  final String errorMessage;

  HeroesError({@required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
