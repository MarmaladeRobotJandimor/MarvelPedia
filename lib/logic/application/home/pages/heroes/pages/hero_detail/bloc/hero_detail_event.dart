import 'package:equatable/equatable.dart';

abstract class HeroeDetailEvent extends Equatable {
  const HeroeDetailEvent();

  @override
  List<Object> get props => [];
}

class GetHeroContent extends HeroeDetailEvent {
  final int idHero;
  final int take;
  final int skip;

  GetHeroContent(this.idHero,this.take,this.skip);

  @override
  List<Object> get props => [idHero];

  @override
  String toString() => 'Hero : ${idHero.toString()}';
}

class GetMoreHerComics extends HeroeDetailEvent {
  final int idHero;
  final int take;
  final int skip;

  GetMoreHerComics(this.idHero,this.take,this.skip);

  @override
  List<Object> get props => [idHero];

  @override
  String toString() => 'Hero : ${idHero.toString()}';
}

class GetSeries extends HeroeDetailEvent {
  final int characterId;

  GetSeries(this.characterId);

  @override
  List<Object> get props => [characterId];

  @override
  String toString() => 'Get Comics : $characterId';
}