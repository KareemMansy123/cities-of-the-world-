import '../../../common/models/city.dart';
import '../repository/city_repository.dart';

class SearchCitiesUseCase {
  final CityRepository cityRepository;

  SearchCitiesUseCase(this.cityRepository);

  Future<List<City>> call(String query) {
    return cityRepository.searchCitiesByName(query);
  }
}
