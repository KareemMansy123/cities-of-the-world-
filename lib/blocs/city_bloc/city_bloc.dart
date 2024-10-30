import 'package:flutter_bloc/flutter_bloc.dart';
import '../../common/models/city.dart';
import '../../common/models/city_response.dart';
import '../../common/repository/city_repository.dart';
import 'city_event.dart';
import 'city_state.dart';

class CityBloc extends Bloc<CityEvent, CityState> {
  final CityRepository cityRepository;
  int currentPage = 1;
  int? totalPages;

  CityBloc(this.cityRepository) : super(CityLoadingState()) {
    on<LoadCitiesEvent>((event, emit) async {
      emit(CityLoadingState());
      currentPage = 1;
      final cityResponse = await _fetchCities(page: currentPage);
      totalPages = cityResponse.pagination?.total;
      emit(CityLoadedState(cityResponse.items ?? []));
    });

    on<LoadMoreCitiesEvent>((event, emit) async {
      if (event.page <= (totalPages ?? 1) && state is CityLoadedState) {
        emit(CityLoadedState((state as CityLoadedState).cities, isLoadingMore: true));

        final cityResponse = await _fetchCities(page: event.page);
        totalPages = cityResponse.pagination?.total;
        final newCities = cityResponse.items ?? [];

        if (state is CityLoadedState) {
          final updatedCities = List<City>.from((state as CityLoadedState).cities)..addAll(newCities);
          emit(CityLoadedState(updatedCities));
        }
      }
    });

    on<SearchCitiesEvent>((event, emit) async {
      emit(CityLoadingState());
      final cities = await cityRepository.searchCitiesByName(event.query);
      emit(CityLoadedState(cities));
    });
  }

  Future<CityResponse> _fetchCities({int page = 1}) async {
    final cityResponse = await cityRepository.fetchCities(page: page);
    print("Fetched Cities: ${cityResponse.items?.map((c) => c.name).toList()}");
    return cityResponse;
  }
}
