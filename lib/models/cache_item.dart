class CacheModel<S extends Serializable> {
  final Type cls = S;
  Serializable value;
  final List<Serializable> items = [];

  CacheModel({required this.value});

  String get key => this.value.key;

  setItems(List<Serializable> items) {
    this.items.clear();
    this.items.addAll(items);
  }
}

abstract class Serializable<T> {
  String get key;
  bool get isList => false;

  T fromJson(Map<String, dynamic> json); // Doesn't work as expected
  Map<String, dynamic> toJson();

  T defaultObject();
}
