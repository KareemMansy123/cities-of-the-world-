import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class ChunkedLogInterceptor extends Interceptor {
  final Logger logger = Logger();

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _logLongString(response.data.toString());
    super.onResponse(response, handler);
  }

  void _logLongString(String message) {
    const int chunkSize = 800; // Adjust the chunk size as needed
    for (int i = 0; i < message.length; i += chunkSize) {
      logger.d(message.substring(i, i + chunkSize > message.length ? message.length : i + chunkSize));
    }
  }
}
