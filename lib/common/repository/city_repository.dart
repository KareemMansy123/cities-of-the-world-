import '../models/city_response.dart';
import '../models/city.dart';

abstract class CityRepository {
  Future<CityResponse> fetchCities({int page = 1, String? filter});
  Future<List<City>> searchCitiesByName(String query);
}
