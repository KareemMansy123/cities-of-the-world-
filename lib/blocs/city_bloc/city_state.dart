import 'package:equatable/equatable.dart';

import '../../common/models/city.dart';

abstract class CityState extends Equatable {
  const CityState();

  @override
  List<Object?> get props => [];
}

class CityErrorState extends CityState {
  final String message;

  const CityErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

class CityListViewState extends CityState {
  final List<City> cities;

  const CityListViewState(this.cities);

  @override
  List<Object?> get props => [cities];
}

class CityMapViewState extends CityState {
  final List<City> cities;

  const CityMapViewState(this.cities);

  @override
  List<Object?> get props => [cities];
}
class CityLoadingState extends CityState {
  CityLoadingState() {}
}

class CityLoadedState extends CityState {
  final List<City> cities;
  final bool isLoadingMore;

  CityLoadedState(this.cities, {this.isLoadingMore = false}) {}

  @override
  List<Object?> get props => [cities, isLoadingMore];
}
