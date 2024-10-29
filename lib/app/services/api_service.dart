import 'package:dio/dio.dart';
import '../../common/models/city_response.dart';

class ApiService {
  final Dio dio;

  ApiService(this.dio);

  Future<CityResponse> fetchCities({int page = 1, String? filter}) async {
    try {
      final response = await dio.get(
        'http://connect-demo.mobile1.io/square1/connect/v1/city',
        queryParameters: {
          'page': page,
          'filter[0][name][contains]': filter,
          'include': 'country'
        },
      );

      return CityResponse.fromJson(response.data['data']);
    } catch (e) {
      throw Exception('Failed to load cities');
    }
  }
}
