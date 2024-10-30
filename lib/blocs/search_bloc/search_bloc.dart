import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cities_of_the_world/common/base_state.dart';
import '../../common/models/city.dart';
import 'search_event.dart';
import 'package:cities_of_the_world/common/repository/city_repository.dart';

class SearchBloc extends Bloc<SearchEvent, BaseState> {
  final CityRepository cityRepository;

  SearchBloc(this.cityRepository) : super(LoadingState()) {
    on<SearchCitiesEvent>((event, emit) async {
      emit(LoadingState());
      try {
        // Fetch cities from the repository based on the query
        final List<City> cities = await cityRepository.searchCitiesByName(event.query);
        emit(SuccessState<List<City>>(cities));
      } catch (e) {
        emit(FailureState("Failed to load search results."));
      }
    });
  }
}
