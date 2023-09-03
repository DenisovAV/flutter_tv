import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tv/domain/movie.dart';
import 'package:flutter_tv/services/services.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  MoviesBloc() : super(MoviesInitialState());

  StreamSubscription<List<Movie>>? _moviesSubscription;

  @override
  Stream<MoviesState> mapEventToState(MoviesEvent event) async* {
    switch (event) {
      case (MoviesInitializeEvent _):
        _moviesSubscription = getMoviesService().getMovies().listen(
          (movies) {
            add(LoadedEvent(movies: movies));
          },
        );
      case (LoadedEvent event):
        yield MoviesLoadedState(movies: event.movies);
    }
  }

  @override
  Future<void> close() {
    _moviesSubscription?.cancel();
    return super.close();
  }
}

abstract class MoviesEvent {}

class MoviesInitializeEvent extends MoviesEvent {}

class LoadedEvent extends MoviesEvent {
  final List<Movie> movies;

  LoadedEvent({this.movies = const []});
}

abstract class MoviesState {}

class MoviesInitialState extends MoviesState {}

class MoviesLoadedState extends MoviesState {
  final List<Movie> movies;

  MoviesLoadedState({this.movies = const []});
}
