import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {}

class SearchMovieEvent extends SearchEvent {
  final title;
  SearchMovieEvent(this.title);
  @override
  List<Object> get props => [title];
}

class ResetSearchEvent extends SearchEvent {
  @override
  List<Object> get props => null;
}
