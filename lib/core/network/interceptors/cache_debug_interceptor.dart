import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class CacheDebugInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.requestOptions.method != "GET") {
      return super.onResponse(response, handler);
    }

    final isFromNetwork = response.extra['@fromNetwork@'];
    if (isFromNetwork != null) {
      if (isFromNetwork == true) {
        debugPrint('🌐 [NETWORK HIT]  ${response.requestOptions.path}');
      } else {
        debugPrint('📦 [CACHE HIT] ${response.requestOptions.path}');
      }
    } else {
      debugPrint('📦 [NO CACHE]  ${response.requestOptions.path}');
    }

    super.onResponse(response, handler);
  }
}
