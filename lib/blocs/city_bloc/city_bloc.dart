import 'package:flutter_bloc/flutter_bloc.dart';
import '../../common/models/city_adapter.dart';
import '../../common/repository/city_repository.dart';
import 'city_event.dart';
import 'city_state.dart';

class CityBloc extends Bloc<CityEvent, CityState> {
  final CityRepository cityRepository;
  bool isListView = true;
  int currentPage = 1;

  CityBloc(this.cityRepository) : super(CityLoadingState()) {
    on<LoadCitiesEvent>((event, emit) async {
      emit(CityLoadingState());
      try {
        final cities = await cityRepository.fetchCities(page: event.page, filter: event.filter);
        currentPage = event.page;
        emit(CityLoadedState(cities));
      } catch (e) {
        emit(CityErrorState("Failed to load cities"));
      }
    });

    on<LoadMoreCitiesEvent>((event, emit) async {
      if (state is CityLoadedState) {
        try {
          currentPage += 1;
          final additionalCities = await cityRepository.fetchCities(page: currentPage);
          final updatedCities = List<City>.from((state as CityLoadedState).cities)..addAll(additionalCities);
          emit(CityLoadedState(updatedCities));
        } catch (e) {
          emit(CityErrorState("Failed to load more cities"));
        }
      }
    });

    on<ToggleViewEvent>((event, emit) {
      if (state is CityLoadedState) {
        final cities = (state as CityLoadedState).cities;
        isListView = !isListView;
        emit(isListView ? CityListViewState(cities) : CityMapViewState(cities));
      }
    });
  }
}
