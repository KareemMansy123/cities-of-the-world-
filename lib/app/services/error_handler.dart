import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class ErrorHandler {
  static void handleError(dynamic error, {VoidCallback? onRetry}) {

    if (error is DioException) {
      // Handle different DioExceptions
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.receiveTimeout:
          _showErrorDialog(
            'Connection Timeout',
            'Please check your internet connection and try again.',
            onRetry: onRetry,
          );
          break;
        case DioExceptionType.sendTimeout:
          _showErrorDialog(
            'Send Timeout',
            'The request took too long to send. Please try again.',
            onRetry: onRetry,
          );
          break;
        case DioExceptionType.badResponse:
          final statusCode = error.response?.statusCode;
          final statusMessage = error.response?.statusMessage ?? 'An unexpected error occurred.';
          _showErrorDialog('Error $statusCode', statusMessage);
          break;
        case DioExceptionType.cancel:
          _showErrorDialog('Request Cancelled', 'The request was cancelled.');
          break;
        case DioExceptionType.unknown:
        default:
          _showErrorDialog(
            'Unexpected Error',
            'An unexpected error occurred. Please try again.',
            onRetry: onRetry,
          );
          break;
      }
    } else {
      _showErrorDialog('Error', 'An unexpected error occurred. Please try again.', onRetry: onRetry);
    }
  }

  static void _showErrorDialog(String title, String message, {VoidCallback? onRetry}) {
    final navigatorContext = GetIt.I<GlobalKey<NavigatorState>>().currentContext;
    if (navigatorContext != null) {
      showDialog(
        context: navigatorContext,
        builder: (context) => AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
            if (onRetry != null)
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  onRetry(); // Retry the API call
                },
                child: const Text('Retry'),
              ),
          ],
        ),
      );
    }
  }
}
