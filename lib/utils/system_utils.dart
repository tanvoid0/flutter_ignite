import 'dart:io';

import 'package:path_provider/path_provider.dart';

import 'file_utils.dart';

class SystemUtils {
  static Future<File> generateFile({final String? path}) async {
    if (path == null) {
      return File("$path");
    }
    final directory = await getApplicationDocumentsDirectory();
    return File("$directory/$path");
  }

  static Future<File> save(final String data,
      {final String? path, final FileMode mode = FileMode.write, final FileType type = FileType.text}) async {
    final file = await generateFile(path: path);

    await file.writeAsString(data, mode: mode, flush: true);
    return file;
  }

  static File saveAsBytes(final String data,
      {required final String path, final FileMode mode = FileMode.write, final FileType type = FileType.text})  {
    final file = File(path);

    file.writeAsBytesSync(data.codeUnits, flush: true);
    return file;
  }
}