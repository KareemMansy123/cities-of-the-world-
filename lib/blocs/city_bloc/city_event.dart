import 'package:equatable/equatable.dart';

abstract class CityEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadCitiesEvent extends CityEvent {
  final int page;
  final String? filter;

  LoadCitiesEvent({this.page = 1, this.filter});

  @override
  List<Object?> get props => [page, filter];
}

class LoadMoreCitiesEvent extends CityEvent {
  final int page;

   LoadMoreCitiesEvent(this.page);

  @override
  List<Object?> get props => [page];
}


class SearchCitiesEvent extends CityEvent {
  final String query;

  SearchCitiesEvent(this.query);
}

class ToggleViewEvent extends CityEvent {} // Toggle view between list and map but we dont have map key

