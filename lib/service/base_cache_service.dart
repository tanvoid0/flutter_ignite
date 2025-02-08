import 'package:flutter_ignite/flutter_ignite.dart';
import 'package:get/get.dart';

abstract class BaseCacheService<S extends Serializable> extends GetxService {
  late final CacheService service;
  late final CacheModel<Serializable> cache;
  final data = RxList<S>([]);
  late final S model;

  // List<S> get data => _data();
  // void set data(List<S> newData) {
  //   _data(newData);
  //   service.writeList(key, newData);
  // }

  S get item => data().isEmpty ? defaultGenerator() : data().first;

  set item(final S model) {
    data.clear();
    data.add(model);
    data.refresh();
  }

  late final S Function() defaultGenerator;

  late final String key;

  BaseCacheService(this.service, this.model) {
    this.defaultGenerator = model.defaultObject as S Function();
    this.key = model.key;
    this.cache = service.getCacheByKey<S>(model.key);

    ever(data, (List<S> value) async {
      Pen.write("Cache data for $key changed. Rewriting the cache");
      if (model.isList) {
        await service.writeList(key, value);
      } else {
        await service.write(item);
      }
    });
    if (model.isList) {
      data(service.readList<S>(cache));
    } else {
      item = service.read<S>(cache);
    }
    data.refresh();
  }

  // List<S> readItems() {
  //   data(service.readList<S>(cache));
  //   data.refresh();
  //   return data();
  // }
  //
  // S readItem() {
  //   return service.read(cache);
  // }
  //
  // Future<void> writeItems() async {
  //   await service.writeList(data());
  //   data.refresh();
  // }

  Future<void> clear() async {
    data.clear();
    service.clear(key);
  }
}
