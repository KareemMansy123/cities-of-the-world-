import 'package:dio/dio.dart';
import '../../common/models/city_response.dart';
import 'chunked_logInterceptor.dart';
import 'error_handler.dart';

class ApiService {
  final Dio dio;

  ApiService(this.dio) {
    dio.interceptors.add(ChunkedLogInterceptor());
  }

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
    } catch (error) {
      ErrorHandler.handleError(error, onRetry: () => fetchCities(page: page, filter: filter));
      throw Exception('Failed to load cities');
    }
  }
}
