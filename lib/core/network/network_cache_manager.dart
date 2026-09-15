import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:http_cache_hive_store/http_cache_hive_store.dart';
import 'package:volt/core/network/api_endpoints.dart';

import '../env/app_env.dart';

class NetworkCacheManager {
  final HiveCacheStore _cacheStore;

  NetworkCacheManager(this._cacheStore);

  Future<void> clearCacheForEndpoint(String endpoint) async {
    final key = CacheOptions.defaultCacheKeyBuilder(
      url: Uri.parse('${AppEnv.baseUrl}$endpoint'),
    );
    await _cacheStore.delete(key);
  }

  Future<void> clearHomeCache() async {
    await clearCacheForEndpoint(ApiEndpoints.publishedLessons);
  }
}
