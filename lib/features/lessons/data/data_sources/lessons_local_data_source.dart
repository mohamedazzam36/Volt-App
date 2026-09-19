import 'package:volt/core/network/network_cache_manager.dart';

abstract class LessonsLocalDataSource {
  Future<void> clearHomeCache();
}

class LessonsLocalDataSourceImpl implements LessonsLocalDataSource {
  final NetworkCacheManager _cacheManager;

  LessonsLocalDataSourceImpl(this._cacheManager);

  @override
  Future<void> clearHomeCache() async {
    await _cacheManager.clearHomeCache();
  }
}
