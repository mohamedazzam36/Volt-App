import 'package:dio/dio.dart';

class CacheHeaderInjectorInterceptor extends Interceptor {
  final List<String> _cacheableEndpoints = [
    'api/content/lessons/',
    'api/quizzes/for-lesson/',
  ];

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final currentPath = response.requestOptions.path;
    final shouldCache = _cacheableEndpoints.any((endpoint) => currentPath.contains(endpoint));

    if (shouldCache) {
      if (response.headers.value('cache-control') == null) {
        response.headers.add('cache-control', 'public, max-age=604800'); // 7 أيام
      }
    }

    super.onResponse(response, handler);
  }
}
