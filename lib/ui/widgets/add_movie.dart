import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tv/business/add_bloc.dart';
import 'package:image_picker/image_picker.dart';

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
  XFile? _imageFile;
  XFile? _videoFile;

  bool get _isEnabled =>
      nameController.text.isNotEmpty &&
      synopsisController.text.isNotEmpty &&
      metaController.text.isNotEmpty &&
      ratingController.text.isNotEmpty &&
      _videoFile != null &&
      _imageFile != null;

  @override
  void initState() {
    super.initState();
    nameController.addListener(_textControllerListener);
    synopsisController.addListener(_textControllerListener);
    metaController.addListener(_textControllerListener);
    ratingController.addListener(_textControllerListener);
  }

  void _textControllerListener() {
    setState(() {});
  }

  Future<void> _pickVideo() async {
    XFile? pickedFile = await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _videoFile = pickedFile;
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
            ElevatedButton(
              onPressed: _isEnabled
                  ? () => context.read<AddBloc>().add(AddUploadEvent(
                      video: _videoFile!,
                      image: _imageFile!,
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

  @override
  void dispose() {
    nameController.removeListener(_textControllerListener);
    synopsisController.removeListener(_textControllerListener);
    metaController.removeListener(_textControllerListener);
    ratingController.removeListener(_textControllerListener);
    super.dispose();
  }
}
