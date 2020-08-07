import 'package:equatable/equatable.dart';

abstract class ComicsEvent extends Equatable {
  const ComicsEvent();

  @override
  List<Object> get props => [];
}

class SearchComics extends ComicsEvent {
  final String comicName;

  SearchComics(this.comicName);

  @override
  List<Object> get props => [comicName];

  @override
  String toString() => 'Comic  $comicName';
}

class GetComics extends ComicsEvent {
  final int take;
  final int skip;
  final bool returnFromNoConnectivity;

  GetComics(this.take, this.skip, this.returnFromNoConnectivity);

  @override
  List<Object> get props => [take, skip];

  @override
  String toString() => 'GetHeroes Take : $take Skip : $skip';
}
