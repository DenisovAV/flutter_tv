import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider_ios/path_provider_ios.dart';

/// Loads a file from the assets folder and caches it
/// in the temporary directory.
/// Returns the cached file.
Future<File> loadAssetFile(String assetPath) async {
  final getTemporaryPath = PathProviderIOS();
  final cacheDirectory = await getTemporaryPath.getTemporaryPath();
  final cachedFilePath = join(cacheDirectory!, assetPath);
  final cachedFile = File(cachedFilePath);
  if (cachedFile.existsSync()) return cachedFile;

  // Create intermediate directories
  final cachedFileDirectoryPath = dirname(cachedFilePath);
  final cachedFileDirectory = Directory(cachedFileDirectoryPath);
  if (!cachedFileDirectory.existsSync()) {
    cachedFileDirectory.createSync(recursive: true);
  }

  cachedFile.createSync();
  final data = await rootBundle.load(assetPath);
  final bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  cachedFile.writeAsBytesSync(bytes);

  return cachedFile;
}
