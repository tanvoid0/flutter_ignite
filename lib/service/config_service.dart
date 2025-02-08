import 'package:flutter_ignite/flutter_ignite.dart';
import 'package:flutter_ignite/service/base_cache_service.dart';

class ConfigService extends BaseCacheService<ConfigModel> {
  late final CacheModel<Serializable> configCache;

  ConfigService(final CacheService cacheService)
      : super(cacheService, ConfigModel());

  Future<void> setConfig(final ConfigModel model) async {
    item = model;
  }
}
