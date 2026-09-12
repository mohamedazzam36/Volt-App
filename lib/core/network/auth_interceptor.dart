import 'package:dio/dio.dart';

import '../storage/secure_storage_helper.dart';
import 'api_endpoints.dart';

class AuthInterceptor extends Interceptor {
  final Dio _dio;
  final SecureStorageHelper _secureStorageHelper;
  final void Function() onUnauthorized;

  AuthInterceptor({
    required this._dio,
    required this._secureStorageHelper,
    required this.onUnauthorized,
  });

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final publicEndpoints = [
      ApiEndpoints.login,
      ApiEndpoints.register,
      ApiEndpoints.guest,
      ApiEndpoints.forgotPassword,
      ApiEndpoints.verifyResetOtp,
      ApiEndpoints.resetPassword,
      ApiEndpoints.refresh,
    ];

    final isPublic = publicEndpoints.any((path) => options.path.contains(path));

    if (!isPublic) {
      try {
        final token = await _secureStorageHelper.getAccessToken();
        if (token != null && token.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $token';
        }
      } catch (_) {}
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401 &&
        !err.requestOptions.path.contains(ApiEndpoints.refresh)) {
      if (await _refreshToken()) {
        try {
          final newToken = await _secureStorageHelper.getAccessToken();
          err.requestOptions.headers['Authorization'] = 'Bearer $newToken';
          return handler.resolve(await _dio.fetch(err.requestOptions));
        } on DioException catch (e) {
          return handler.next(e);
        }
      } else {
        await _secureStorageHelper.clearAll();
        onUnauthorized();
      }
    }

    handler.next(err);
  }

  Future<bool> _refreshToken() async {
    try {
      final refreshToken = await _secureStorageHelper.getRefreshToken();
      if (refreshToken == null) {
        return false;
      }
      final tokenDio = Dio(BaseOptions(baseUrl: _dio.options.baseUrl));

      final response = await tokenDio.post(
        ApiEndpoints.refresh,
        data: {'refresh_token': refreshToken},
      );

      if (response.statusCode == 200) {
        final newAccessToken = response.data['data']['access_token'];
        final newRefreshToken = response.data['data']['refresh_token'];

        await _secureStorageHelper.saveAccessToken(newAccessToken);
        await _secureStorageHelper.saveRefreshToken(newRefreshToken);
        return true;
      }
      return false;
    } catch (_) {
      return false;
    }
  }
}
