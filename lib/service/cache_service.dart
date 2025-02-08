import 'package:flutter_ignite/flutter_ignite.dart';
import 'package:flutter_ignite/flutter_ignite_package.dart';
import 'package:flutter_ignite/utils/mixins.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CacheService extends GetxService {
  late GetStorage _box;
  final List<CacheModel> data = [];
  GetStorage get storage => _box;
  bool log = true;

  Future<CacheService> init({final List<Serializable> items = const []}) async {
    await GetStorage.init(FlutterIgnite.title);
    _box = GetStorage(FlutterIgnite.title);
    for (final Serializable item in items) {
      final CacheModel<Serializable> itemModel = await _buildCache(
          _box, item.defaultObject(),
          resetMode: FlutterIgnite.cacheReset);
      data.add(itemModel);
    }
    Pen.write(
        "Cache Initialized. Reset Cache Mode: ${FlutterIgnite.cacheReset}");
    return this;
  }

  Future<CacheModel<S>> _buildCache<S extends Serializable>(
      final GetStorage storage, final S s,
      {bool resetMode = false}) async {
    final item = CacheModel<S>(value: s);
    if (resetMode) {
      clear(item.key);
    }
    if (item.value.isList) {
      item.items.addAll(readList(item));
    } else {
      item.value = read<S>(item);
    }
    return item;
  }

  Future<void> save(final String key, final data) async {
    await storage.write(key, data);
  }

  dynamic load(final String key) {
    return storage.read(key);
  }

  CacheModel getCacheByKey<S>(final String key) {
    return data.firstWhere((CacheModel item) => item.key == key);
  }

  void _log(final String key, final String str, {type = PenType.info}) {
    if (log) {
      Pen.write("\t\tCacheItem[$key]\t: $str", type: type);
    }
  }

  S read<S>(final CacheModel model) {
    if (model.value.isList) {
      throw AppException(
          message:
              "Invalid Cache for '${model.key}'. Item is an array, use readList() instead");
    }
    final cacheData = storage.read(model.key);
    if (cacheData == null) {
      return model.value.defaultObject();
    }
    _log(model.key,
        "Reading cache [${model.key}: ${cacheData.runtimeType}]: $cacheData");
    if (cacheData.runtimeType == List && (cacheData as List).isNotEmpty) {
      return model.value.fromJson((cacheData).first);
      // throw AppException(
      //     message: "Invalid Cache value for ${model.key}",
      //     description:
      //         "cache value for ${model.key} is list. Use readList instead");
    }
    return model.value.fromJson(cacheData);
  }

  List<S> readList<S>(final CacheModel model) {
    _log(model.key, "Reading Cache data for list ${model.key}");
    final cacheData = storage.read(model.key);
    if (cacheData == null) {
      return [];
    }
    if (cacheData.runtimeType != List) {
      throw AppException(
          message:
              "Invalid Runtime Type. Expected type: List. Actual: ${cacheData.runtimeType}");
    }
    return (cacheData as List)
        .map<S>((item) => model.value.fromJson(item))
        .toList();
  }

  // updating the value of config sounds a bit more tricky than passing it here.
  // This forces the user to update the value instead of using the old value...
  Future<void> write(final Serializable value) async {
    final Map<String, dynamic> existingData = storage.read(value.key);
    if (existingData.isEqual(value.toJson())) {
      _log(value.key, "Similar entry. Skipping save data for ${value.key}");
      return;
    }
    _log(value.key, "Saved data ${value.toJson()}", type: PenType.success);
    await storage.write(value.key, value.toJson());
  }

  Future<void> writeList(
      final String key, final List<Serializable> value) async {
    final List<Map<String, dynamic>> map =
        value.map((item) => item.toJson()).toList();
    final existingValue = storage.read(key);
    if (existingValue != map) {
      _log(key, "Saved List data", type: PenType.success);
      await storage.write(key, map);
    }
  }

  void clear(final String key) {
    _log(key, "Removed cache for $key", type: PenType.warning);
    storage.remove(key);
  }
}
