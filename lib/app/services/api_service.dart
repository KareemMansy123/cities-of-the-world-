import 'package:dio/dio.dart';
import '../config/app_config.dart';
import 'chunked_logInterceptor.dart';
import 'error_handler.dart';

class ApiService {
  final Dio dio;

  ApiService(this.dio) {
    dio.options.baseUrl = baseUrl;
    dio.interceptors.add(ChunkedLogInterceptor());
  }

  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) async {
    return _makeRequest(
      path: path,
      method: 'GET',
      queryParameters: queryParameters,
    );
  }

  Future<Response> post(String path, {Map<String, dynamic>? data}) async {
    return _makeRequest(
      path: path,
      method: 'POST',
      data: data,
    );
  }

  Future<Response> put(String path, {Map<String, dynamic>? data}) async {
    return _makeRequest(
      path: path,
      method: 'PUT',
      data: data,
    );
  }

  Future<Response> delete(String path, {Map<String, dynamic>? data}) async {
    return _makeRequest(
      path: path,
      method: 'DELETE',
      data: data,
    );
  }

  Future<Response> _makeRequest({
    required String path,
    required String method,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
  }) async {
    try {
      final options = Options(method: method);
      final response = await dio.request(
        path,
        options: options,
        queryParameters: queryParameters,
        data: data,
      );
      return response;
    } catch (error) {
      ErrorHandler.handleError(error, onRetry: () => _makeRequest(
        path: path,
        method: method,
        queryParameters: queryParameters,
        data: data,
      ));
      rethrow;
    }
  }
}
