import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tv/domain/movie.dart';
import 'package:flutter_tv/services/services.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  MoviesBloc() : super(MoviesInitialState());

  @override
  Stream<MoviesState> mapEventToState(MoviesEvent event) async* {
    if (event == MoviesEvent.initializing) {
      final movies = await getMoviesService().getMovies();
      yield MoviesLoadedState(movies: movies);
    }
  }
}

enum MoviesEvent { initializing }

abstract class MoviesState {}

class MoviesInitialState extends MoviesState {}

class MoviesLoadedState extends MoviesState {
  final List<Movie> movies;

  MoviesLoadedState({this.movies = const []});
}
