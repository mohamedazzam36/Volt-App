import 'package:dio/dio.dart';

import '../env/app_env.dart';

class ApiService {
  final Dio _dio;

  ApiService([Dio? dio])
    : _dio =
          dio ??
          Dio(
            BaseOptions(
              baseUrl: AppEnv.baseUrl,
              connectTimeout: const Duration(seconds: 30),
              receiveTimeout: const Duration(seconds: 30),
              sendTimeout: const Duration(seconds: 30),
              headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json',
              },
            ),
          );

  // GET Request
  Future<dynamic> get({
    required String endpoint,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    final response = await _dio.get(
      endpoint,
      queryParameters: queryParameters,
      options: options,
    );
    return response.data;
  }

  // POST Request
  Future<dynamic> post({
    required String endpoint,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    final response = await _dio.post(
      endpoint,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
    return response.data;
  }

  // PUT Request
  Future<dynamic> put({
    required String endpoint,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    final response = await _dio.put(
      endpoint,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
    return response.data;
  }

  // DELETE Request
  Future<dynamic> delete({
    required String endpoint,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    final response = await _dio.delete(
      endpoint,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
    return response.data;
  }
}
