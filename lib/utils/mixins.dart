import 'dart:io';

extension ProcessResultExtensions on ProcessResult {
  String toFormattedString() {
    return 'ProcessResult: exitCode=$exitCode, stdout=$stdout, stderr=$stderr';
  }
}

extension StringExtension on String {
  String toFirstUppercase() {
    if (isEmpty) {
      return this;
    }
    return split(" ").map((word) {
      if (word.isEmpty) {
        return word;
      }
      return word[0].toUpperCase() + word.substring((1));
    }).join();
  }
}

extension EnumExtension<T extends Enum> on T {
  static List<String> toList<T extends Enum>(final List<T> values) {
    return values.map((e) => e.name.toFirstUppercase()).toList();
  }
}

extension MapExtension on Map {
  bool isEqual(final Map map) {
    if (!map.keys.toSet().containsAll(keys.toSet()) ||
        !keys.toSet().containsAll(map.keys.toSet())) return false;
    for (final key in keys) {
      if (map[key] != this[key]) {
        return false;
      }
    }
    return true;
  }
}
