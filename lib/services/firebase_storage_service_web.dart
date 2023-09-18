import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';

import 'package:flutter_tv/services/storage_service.dart';
import 'package:image_picker/image_picker.dart';

class FirebaseStorageService implements StorageService {
  Future<String> uploadImage(XFile file, String id) async {
    return _uploadResource(file, 'image/jpeg', 'images/$id.png');
  }

  Future<String> uploadVideo(XFile file, String id) async {
    return _uploadResource(file, 'video/mp4', 'videos/$id.mp4');
  }

  Future<String> _uploadResource(XFile file, String contentType, String path) async {
    try {
      final Reference storageReference = FirebaseStorage.instance.ref().child(path);
      final data = await file.readAsBytes();
      final metadata = SettableMetadata(
          contentType: contentType, customMetadata: {'picked-file-path': file.name});

      await storageReference.putData(Uint8List.fromList(data), metadata);
      return storageReference.getDownloadURL();
    } catch (e) {
      print(e);
      return '';
    }
  }
}
