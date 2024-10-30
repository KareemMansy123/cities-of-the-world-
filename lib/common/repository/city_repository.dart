import 'package:hive/hive.dart';
import 'package:cities_of_the_world/app/services/api_service.dart';
import '../models/city.dart';
import '../models/city_response.dart';

class CityRepository {
  final ApiService apiService;
  final Box<City> cityBox;

  CityRepository({required this.apiService, required this.cityBox});

  Future<CityResponse> fetchCities({int page = 1, String? filter}) async {
    try {
      final cityResponse = await apiService.fetchCities(page: page, filter: filter);
      final cities = cityResponse.items ?? [];

      // Cache the 10 most recent cities in Hive
      await _cacheRecentCities(cities);

      return cityResponse;
    } catch (e) {
      print("Error fetching cities from API: $e");

      // Load cached cities if there's an error
      return CityResponse(items: _getCachedCities());
    }
  }

  Future<List<City>> searchCitiesByName(String query) async {
    try {
      final cityResponse = await apiService.fetchCities(filter: query);
      return cityResponse.items ?? [];
    } catch (e) {
      print("Error during search: $e");
      // Fallback to cached data if online search fails
      return cityBox.values
          .where((city) => city.name?.toLowerCase().contains(query.toLowerCase()) ?? false)
          .toList();
    }
  }

  Future<void> _cacheRecentCities(List<City> cities) async {
    // Limit the cache to the 10 most recent cities
    final recentCities = cities.take(10).toList();
    await cityBox.clear();
    for (var city in recentCities) {
      await cityBox.put(city.id, city);
    }
    print("Total Cities Cached: ${cityBox.length}");
  }

  List<City> _getCachedCities() {
    final cachedCities = cityBox.values.toList();
    print("Loaded ${cachedCities.length} cities from cache.");
    return cachedCities;
  }
}