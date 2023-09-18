import 'package:image_picker/image_picker.dart';

abstract class StorageService {
  Future<String> uploadImage(XFile path, String id);

  Future<String> uploadVideo(XFile path, String id);
}
