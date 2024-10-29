import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SearchCitiesEvent extends SearchEvent {
  final String query;

  SearchCitiesEvent(this.query);

  @override
  List<Object> get props => [query];
}
