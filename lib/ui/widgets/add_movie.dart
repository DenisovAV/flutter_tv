import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tv/business/add_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

import 'dart:io' if (dart.library.html) 'dart:html';

class AddMovieWidget extends StatefulWidget {
  const AddMovieWidget({Key? key}) : super(key: key);

  @override
  _AddMovieWidgetState createState() => _AddMovieWidgetState();
}

class _AddMovieWidgetState extends State<AddMovieWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController synopsisController = TextEditingController();
  TextEditingController metaController = TextEditingController();
  TextEditingController ratingController = TextEditingController();
  VideoPlayerController? _videoPlayerController;
  XFile? _imageFile;
  XFile? _videoFile;

  Future<void> _pickVideo() async {
    _videoFile = await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (_videoFile != null) {
      _videoPlayerController = VideoPlayerController.file(File(_videoFile!.path))
        ..initialize().then((_) {
          setState(() {});
        });
    }
  }

  Future<void> _pickImage() async {
    XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = pickedFile;
      });
    }
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    super.dispose();
  }

  bool get _isEnabled =>
      nameController.text.isNotEmpty &&
          synopsisController.text.isNotEmpty &&
          metaController.text.isNotEmpty &&
          ratingController.text.isNotEmpty &&
          _videoFile != null &&
          _imageFile != null;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: synopsisController,
              decoration: InputDecoration(labelText: 'Synopsis'),
            ),
            TextField(
              controller: metaController,
              decoration: InputDecoration(labelText: 'Meta'),
            ),
            TextField(
              controller: ratingController,
              decoration: InputDecoration(labelText: 'Rating'),
            ),
            SizedBox(height: 10),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              ElevatedButton(
                onPressed: _pickVideo,
                child: Text('Pick Video'),
              ),
              ElevatedButton(
                onPressed: _pickImage,
                child: Text('Pick Image'),
              ),
            ]),
            if (_videoPlayerController != null)
              AspectRatio(
                aspectRatio: _videoPlayerController!.value.aspectRatio,
                child: VideoPlayer(_videoPlayerController!),
              ),
            if (_imageFile != null)
              Image.file(
                File(_imageFile!.path),
              ),
            ElevatedButton(
              onPressed: _isEnabled
                  ? () => context.read<AddBloc>().add(AddUploadEvent(
                  video: File(_videoFile!.path),
                  image: File(_imageFile!.path),
                  name: nameController.text,
                  synopsis: synopsisController.text,
                  rating: ratingController.text,
                  meta: metaController.text))
                  : null,
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
