import 'package:dio/dio.dart';

class ResponseUnwrapperInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.data is Map<String, dynamic>) {
      final responseData = response.data as Map<String, dynamic>;

      if (!responseData.containsKey('success')) {
        return handler.next(response);
      }

      if (responseData['success'] == true) {
        response.data = responseData['data'];
        return handler.next(response);
      } else {
        return handler.reject(
          DioException(
            requestOptions: response.requestOptions,
            error: responseData['message'] ?? 'حدث خطأ غير متوقع',
            response: response,
            type: DioExceptionType.badResponse,
          ),
        );
      }
    }
    return handler.next(response);
  }
}
