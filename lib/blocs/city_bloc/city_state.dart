import 'package:equatable/equatable.dart';

import '../../common/models/city_adapter.dart';

abstract class CityState extends Equatable {
  const CityState();

  @override
  List<Object?> get props => [];
}

class CityLoadingState extends CityState {}

class CityLoadedState extends CityState {
  final List<City> cities;

  const CityLoadedState(this.cities);

  @override
  List<Object?> get props => [cities];
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
