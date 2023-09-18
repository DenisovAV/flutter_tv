import 'dart:io';

abstract class StorageService {
  Future<String> uploadImage(File file, String id);

  Future<String> uploadVideo(File file, String id);
}
