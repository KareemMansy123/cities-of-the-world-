// fetch_cities_usecase.dart
import '../models/city_response.dart';
import '../repository/city_repository.dart';

class FetchCitiesUseCase {
  final CityRepository cityRepository;

  FetchCitiesUseCase(this.cityRepository);

  Future<CityResponse> call({int page = 1, String? filter}) {
    return cityRepository.fetchCities(page: page, filter: filter);
  }
}
