import 'package:dio/dio.dart';

import 'failures.dart';

class ApiFailures extends Failures {
  const ApiFailures(super.errMessage);

  factory ApiFailures.fromDioException(DioException dioEx) {
    switch (dioEx.type) {
      case DioExceptionType.connectionTimeout:
        return const ApiFailures("Connection timeout. Please try again later.");

      case DioExceptionType.sendTimeout:
        return const ApiFailures("Send timeout. Check your internet connection.");

      case DioExceptionType.receiveTimeout:
        return const ApiFailures("Receive timeout. Server took too long to respond.");

      case DioExceptionType.badCertificate:
        return const ApiFailures("Bad certificate. Secure connection failed.");

      case DioExceptionType.badResponse:
        final statusCode = dioEx.response?.statusCode ?? 0;
        final responseData = dioEx.response?.data;
        return ApiFailures.fromBadResponse(statusCode, responseData);

      case DioExceptionType.cancel:
        return const ApiFailures("Request was cancelled.");

      case DioExceptionType.connectionError:
        return const ApiFailures("Connection error. Please check your network.");

      case DioExceptionType.unknown:
      default:
        return const ApiFailures("Unexpected error occurred. Please try again.");
    }
  }

  factory ApiFailures.fromBadResponse(int statusCode, dynamic responseData) {
    String? serverMessage;
    if (responseData is Map<String, dynamic>) {
      if (responseData['message'] != null) {
        serverMessage = responseData['message'].toString();
      } else if (responseData['error'] != null) {
        serverMessage = responseData['error'].toString();
      } else if (responseData['errors'] != null) {
        serverMessage = responseData['errors'].toString();
      }
    }

    if (serverMessage != null && serverMessage.isNotEmpty) {
      return ApiFailures(serverMessage);
    }

    switch (statusCode) {
      case 400:
        return const ApiFailures("Bad request.");
      case 401:
        return const ApiFailures("Unauthorized. Please login again.");
      case 403:
        return const ApiFailures("Forbidden. You don't have permission.");
      case 404:
        return const ApiFailures("Resource not found.");
      case 409:
        return const ApiFailures("Conflict occurred.");
      case 422:
        return const ApiFailures("Validation error.");
      case 500:
        return const ApiFailures("Internal server error.");
      case 503:
        return const ApiFailures("Service unavailable. Try again later.");
      default:
        return ApiFailures("Received invalid status code: $statusCode");
    }
  }
}
