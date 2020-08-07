import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:marvelhero/data/models/comics/comics.dart';
import 'package:marvelhero/data/models/series/series.dart';

abstract class HeroeDetailState extends Equatable {
  const HeroeDetailState();

  @override
  List<Object> get props => [];
}

class ComicsUnitialized extends HeroeDetailState {}

class HeroContentLoading extends HeroeDetailState {}

class HeroContentLoaded extends HeroeDetailState {
  final List<Comic> comics;
  final List<Series> series;

  HeroContentLoaded({this.comics, this.series});

  HeroContentLoaded copyWith({
    List<Comic> heroes,
    List<Series> series,
  }) {
    return HeroContentLoaded(
      comics: comics ?? this.comics,
      series: series ?? this.series,
    );
  }

  @override
  List<Object> get props => [comics, series];
}

class HeroContentLoadedError extends HeroeDetailState {
  final String errorMessage;

  HeroContentLoadedError({@required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
