import 'dart:convert';

import 'package:flutter_ignite/flutter_ignite.dart';
import 'package:yaml/yaml.dart';

class FileFormatUtils {
  static String format(final data, {required final FileType type}) {
    try {
      if (type == FileType.json) {
        final dynamic jsonObject = jsonDecode(data);
        return const JsonEncoder.withIndent('  ').convert(jsonObject);
      } else if (type == FileType.yaml) {
        final yamlObject = loadYaml(data);
        final jsonCompatible = jsonDecode(jsonEncode(yamlObject));
        final formattedYaml =
            const JsonEncoder.withIndent('  ').convert(jsonCompatible);
        return formattedYaml;
      } else {
        throw AppException.fromFormatException(type);
      }
    } on FormatException {
      throw AppException.fromFormatException(type);
    }
  }
}

enum FileType { json, yaml, text }
