import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:marvelhero/data/models/comics/comics.dart';

abstract class ComicsState extends Equatable {
  const ComicsState();

  @override
  List<Object> get props => [];
}

class ComicsUnitialized extends ComicsState {}

class ComicsLoading extends ComicsState {}

class SearchComicsEmpty extends ComicsState {}

class ComicsLoaded extends ComicsState {
  final List<Comic> comics;
  final bool hasReachedMax;

  ComicsLoaded({this.comics, this.hasReachedMax});

  ComicsLoaded copyWith({
    List<Comic> comics,
    bool hasReachedMax,
  }) {
    return ComicsLoaded(
      comics: comics ?? this.comics,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [comics, hasReachedMax];
}

class SearchComicsLoaded extends ComicsState {
  final List<Comic> comics;
  final bool hasReachedMax;

  SearchComicsLoaded({this.comics, this.hasReachedMax});

  SearchComicsLoaded copyWith({
    List<Comic> comics,
    bool hasReachedMax,
  }) {
    return SearchComicsLoaded(
      comics: comics ?? this.comics,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [comics, hasReachedMax];
}

class ComicsError extends ComicsState {
  final String errorMessage;

  ComicsError({@required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
