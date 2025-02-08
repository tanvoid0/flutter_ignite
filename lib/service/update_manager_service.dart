import 'dart:convert';
import 'dart:io';

import 'package:archive/archive.dart';
import 'package:dio/dio.dart';
import 'package:flutter_ignite/flutter_ignite.dart';
import 'package:flutter_ignite/flutter_ignite_package.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class UpdateManagerService extends GetxService {
  // example: 'https://api.github.com/repos/yourusername/yourrepository/releases/latest'
  final String repository;

  UpdateManagerService({required this.repository});

  Dio get dio => FlutterIgnite.dio;

  Future<PackageInfo> getPackageInfo() async =>
      await PackageInfo.fromPlatform();

  Future<void> checkForUpdates() async {
    final response = await dio.get(repository);
    if (response.statusCode == 200) {
      final data = json.decode(response.data);
      Pen.write(data);
      final latestVersion = data['tag_name'];
      final assets = data['assets'];
      final downloadUrl = assets[0]['browser_download_url'];
      final packageInfo = await getPackageInfo();

      if (latestVersion > packageInfo.version) {
        Toast.confirm(
          title: 'There is an Update available',
          message:
          'A newer version of ${FlutterIgnite
              .title} is available. Would you like to update from ${packageInfo
              .version} to $latestVersion?',
          confirm: () => installUpdate(downloadUrl, version: latestVersion),
        );
      }
    }
  }

  Future<void> installUpdate(final String url, {final String? version}) async {
    try {
      final response = await dio.get(url);
      final Directory tempDir = Directory.systemTemp;
      final File tempFile = File(
          '${tempDir.path}/${FlutterIgnite.title}${version != null &&
              version.isNotEmpty ? version : ""}.zip');
      // TODO: make sure the file is extracted, might be invalid data?
      await tempFile.writeAsBytes(response.data);

      // extract and replace the app (this part is  platform-specific)
      final bytes = tempFile.readAsBytesSync();
      final archive = ZipDecoder().decodeBytes(bytes);

      for (final ArchiveFile file in archive.files) {
        final filename = file.name;
        if (file.isFile) {
          final data = file.content as List<int>;
          File('${tempDir.path}/$filename')
            ..createSync(recursive: true)
            ..writeAsBytes(data);
        }
      }

      // move extracted files to the app directory and restart the app
      // TODO: make it current directory
      // final appDir = Directory('/');
      // TODO: make proper testing
      final appDir = Directory.current;
      for (final file in tempDir.listSync()) {
        file.renameSync('${appDir.path}/${file.uri.pathSegments.last}');
      }
      // Restart the app (platform-specific implementation needed)
    } catch (ex) {
      Pen.error("Update install failed");
    }
  }
}
