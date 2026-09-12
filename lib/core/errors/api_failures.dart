import 'package:dio/dio.dart';

import 'failures.dart';

class ApiFailure extends Failure {
  const ApiFailure(super.errMessage);

  factory ApiFailure.fromDioException(DioException dioEx) {
    switch (dioEx.type) {
      case DioExceptionType.connectionTimeout:
        return const ApiFailure("Connection timeout. Please try again later.");

      case DioExceptionType.sendTimeout:
        return const ApiFailure("Send timeout. Check your internet connection.");

      case DioExceptionType.receiveTimeout:
        return const ApiFailure("Receive timeout. Server took too long to respond.");

      case DioExceptionType.badCertificate:
        return const ApiFailure("Bad certificate. Secure connection failed.");

      case DioExceptionType.badResponse:
        final statusCode = dioEx.response?.statusCode ?? 0;
        final responseData = dioEx.response?.data;
        return ApiFailure._fromBadResponse(statusCode, responseData);

      case DioExceptionType.cancel:
        return const ApiFailure("Request was cancelled.");

      case DioExceptionType.connectionError:
        return const ApiFailure("Connection error. Please check your network.");

      case DioExceptionType.unknown:
      default:
        return const ApiFailure("Unexpected error occurred. Please try again.");
    }
  }

  factory ApiFailure._fromBadResponse(int statusCode, dynamic responseData) {
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
      return ApiFailure(serverMessage);
    }

    switch (statusCode) {
      case 400:
        return const ApiFailure("Bad request.");
      case 401:
        return const ApiFailure("Unauthorized. Please login again.");
      case 403:
        return const ApiFailure("Forbidden. You don't have permission.");
      case 404:
        return const ApiFailure("Resource not found.");
      case 409:
        return const ApiFailure("Conflict occurred.");
      case 422:
        return const ApiFailure("Validation error.");
      case 500:
        return const ApiFailure("Internal server error.");
      case 503:
        return const ApiFailure("Service unavailable. Try again later.");
      default:
        return ApiFailure("Received invalid status code: $statusCode");
    }
  }
}
