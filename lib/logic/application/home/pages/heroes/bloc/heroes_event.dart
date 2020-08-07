import 'package:equatable/equatable.dart';

abstract class HeroesEvent extends Equatable {
  const HeroesEvent();

  @override
  List<Object> get props => [];
}

class SearchHeroes extends HeroesEvent {
  final String heroName;

  SearchHeroes(this.heroName);

  @override
  List<Object> get props => [heroName];

  @override
  String toString() => 'Search hero $heroName';
}

class GetHeroes extends HeroesEvent {
  final int take;
  final int skip;
  final bool returnFromNoConnectivity;

  GetHeroes(this.take, this.skip, this.returnFromNoConnectivity);

  @override
  List<Object> get props => [take, skip];

  @override
  String toString() => 'GetHeroes Take : $take Skip : $skip';
}
