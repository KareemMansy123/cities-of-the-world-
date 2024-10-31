// city_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../common/user_case/city.dart';
import '../../common/user_case/search.dart';
import 'city_event.dart';
import 'city_state.dart';

class CityBloc extends Bloc<CityEvent, CityState> {
  final FetchCitiesUseCase fetchCitiesUseCase;
  final SearchCitiesUseCase searchCitiesUseCase;
  int currentPage = 1;
  int? totalPages;

  CityBloc({required this.fetchCitiesUseCase, required this.searchCitiesUseCase}) : super(CityLoadingState()) {
    on<LoadCitiesEvent>(_onLoadCities);
    on<LoadMoreCitiesEvent>(_onLoadMoreCities);
    on<SearchCitiesEvent>(_onSearchCities);
  }

  void _onLoadCities(LoadCitiesEvent event, Emitter<CityState> emit) async {
    emit(CityLoadingState());
    currentPage = 1;
    final cityResponse = await fetchCitiesUseCase(page: currentPage);
    totalPages = cityResponse.pagination?.total;
    emit(CityLoadedState(cityResponse.items ?? []));
  }

  void _onLoadMoreCities(LoadMoreCitiesEvent event, Emitter<CityState> emit) async {
    if (currentPage < (totalPages ?? 1) && state is CityLoadedState) {
      currentPage++;
      final cityResponse = await fetchCitiesUseCase(page: currentPage);
      final updatedCities = [...(state as CityLoadedState).cities, ...?cityResponse.items];
      emit(CityLoadedState(updatedCities));
    }
  }

  void _onSearchCities(SearchCitiesEvent event, Emitter<CityState> emit) async {
    emit(CityLoadingState());
    final searchResults = await searchCitiesUseCase(event.query);
    emit(CityLoadedState(searchResults));
  }
}
