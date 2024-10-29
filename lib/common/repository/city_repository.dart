import 'package:hive/hive.dart';
import 'package:cities_of_the_world/app/services/api_service.dart';
import '../models/city_adapter.dart';

class CityRepository {
  final ApiService apiService;
  final Box cityBox;

  CityRepository({required this.apiService, required this.cityBox});

  Future<List<City>> fetchCities({int page = 1, String? filter}) async {
    try {
      final cityResponse = await apiService.fetchCities(page: page, filter: filter);
      final cities = cityResponse.items;  // Extract the list of cities
      await _cacheCities(cities);
      return cities;
    } catch (e) {
      return _getCachedCities();
    }
  }

  Future<List<City>> searchCitiesByName(String query) async {
    try {
      final cityResponse = await apiService.fetchCities(filter: query);
      return cityResponse.items;
    } catch (e) {
      return cityBox.values
          .cast<City>()
          .where((city) => city.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

  Future<void> _cacheCities(List<City> cities) async {
    await cityBox.clear();
    for (var city in cities) {
      await cityBox.put(city.id, city);
    }
  }

  List<City> _getCachedCities() {
    return cityBox.values.cast<City>().toList();
  }
}
