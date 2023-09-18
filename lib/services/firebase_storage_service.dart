import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

import 'package:flutter_tv/services/storage_service.dart';

class FirebaseStorageService implements StorageService {
  Future<String> uploadImage(File file, String id) async {
    return _uploadResourse(file, 'images/$id.png');
  }

  Future<String> uploadVideo(File file, String id) async {
    return _uploadResourse(file, 'videos/$id.mp4');
  }

  Future<String> _uploadResourse(File file, String path) async {
    try {
      final Reference storageReference = FirebaseStorage.instance.ref().child(path);
      await storageReference.putFile(file);
      return storageReference.getDownloadURL();
    } catch (e) {
      print("Error: $e");
      return '';
    }
  }
}
