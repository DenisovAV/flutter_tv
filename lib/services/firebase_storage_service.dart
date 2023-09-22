import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

import 'package:flutter_tv/services/storage_service.dart';
import 'package:image_picker/image_picker.dart';

class FirebaseStorageService implements StorageService {
  Future<String> uploadImage(XFile file, String id) async {
    return _uploadResource(file, id);
  }

  Future<String> uploadVideo(XFile file, String id) async {
    return _uploadResource(file, id);
  }

  Future<String> _uploadResource(XFile file, String path) async {
    try {
      final Reference storageReference = FirebaseStorage.instance.ref().child(path);
      await storageReference.putFile(File(file.path));
      return storageReference.getDownloadURL();
    } catch (e) {
      print("Error: $e");
      return '';
    }
  }
}
