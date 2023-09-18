import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tv/domain/movie.dart';
import 'package:flutter_tv/services/services.dart';
import 'package:image_picker/image_picker.dart';

class AddBloc extends Bloc<AddEvent, AddState> {
  AddBloc() : super(AddInitialState());

  @override
  Stream<AddState> mapEventToState(AddEvent event) async* {
    switch (event) {
      case (AddUploadEvent event):
        yield AddUploadingState();
        try {
          final storage = getStorageService();
          final id = event.name.toLowerCase();
          final image = await storage.uploadImage(event.image, 'images/$id.png');
          final video = await storage.uploadVideo(event.video, 'videos/$id.mp4');
          await getMoviesService().addMovie(
            Movie(
              id: id,
              name: event.name,
              synopsis: event.synopsis,
              rating: event.rating,
              meta: event.meta,
              image: image,
              trailer: video,
            ),
          );
          yield AddUploadedState(success: true);
        } catch (e) {
          print("Error: $e");
          yield AddUploadedState(success: false);
        }
    }
  }
}

abstract class AddEvent {}

class AddInitializeEvent extends AddEvent {}

class AddUploadEvent extends AddEvent {
  final XFile video;
  final XFile image;
  final String name;
  final String synopsis;
  final String rating;
  final String meta;

  AddUploadEvent({
    required this.video,
    required this.image,
    required this.name,
    required this.synopsis,
    required this.rating,
    required this.meta,
  });
}

abstract class AddState {}

class AddInitialState extends AddState {}

class AddUploadingState extends AddState {}

class AddUploadedState extends AddState {
  final bool success;

  AddUploadedState({required this.success});
}
