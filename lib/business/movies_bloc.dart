import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tv/domain/movie.dart';
import 'package:flutter_tv/services/services.dart';

class MoviesBloc extends Cubit<MoviesState> {
  MoviesBloc() : super(MoviesInitialState());

  Future<void> init() async {
    final movies = await getMoviesService().getMovies();
    emit(MoviesLoadedState(movies: movies));
  }
}

enum MoviesEvent { initializing }

abstract class MoviesState {}

class MoviesInitialState extends MoviesState {}

class MoviesLoadedState extends MoviesState {
  final List<Movie> movies;

  MoviesLoadedState({this.movies = const []});
}
