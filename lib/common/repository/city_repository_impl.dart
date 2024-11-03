import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import '../../app/services/api_service.dart';
import '../models/city.dart';
import '../models/city_response.dart';
import 'city_repository.dart';

class CityRepositoryImpl implements CityRepository {
  final ApiService apiService = GetIt.I<ApiService>();
  final Box<City> cityBox;

  CityRepositoryImpl({required this.cityBox});

  @override
  Future<CityResponse> fetchCities({int page = 1, String? filter}) async {
    try {
      final response = await apiService.get(
        '/city',
        queryParameters: {
          'page': page,
          'filter[0][name][contains]': filter,
          'include': 'country',
        },
      );

      final cityResponse = CityResponse.fromJson(response.data['data']);
      final cities = cityResponse.items ?? [];
      await _cacheRecentCities(cities);

      return cityResponse;
    } catch (e) {
      // Return cached cities on error
      return CityResponse(items: _getCachedCities());
    }
  }

  @override
  Future<List<City>> searchCitiesByName(String query) async {
    try {
      final response = await apiService.get(
        '/city',
        queryParameters: {
          'filter[0][name][contains]': query,
          'include': 'country',
        },
      );

      final cityResponse = CityResponse.fromJson(response.data['data']);
      return cityResponse.items ?? [];
    } catch (e) {
      return cityBox.values
          .where((city) => city.name?.toLowerCase().contains(query.toLowerCase()) ?? false)
          .toList();
    }
  }

  Future<void> _cacheRecentCities(List<City> cities) async {
    final recentCities = cities.take(10).toList();
    await cityBox.clear();
    for (var city in recentCities) {
      await cityBox.put(city.id, city);
    }
  }

  List<City> _getCachedCities() {
    return cityBox.values.toList();
  }
}
