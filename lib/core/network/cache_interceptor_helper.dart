import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:http_cache_hive_store/http_cache_hive_store.dart';

abstract final class CacheInterceptorHelper {
  static DioCacheInterceptor getCacheInterceptor({required HiveCacheStore hiveCacheStore}) {
    final cacheOptions = CacheOptions(
      store: hiveCacheStore,
      policy: CachePolicy.request,
      maxStale: const Duration(days: 7),
      priority: CachePriority.normal,
      hitCacheOnErrorCodes: [401, 403],
    );
    return DioCacheInterceptor(options: cacheOptions);
  }
}
