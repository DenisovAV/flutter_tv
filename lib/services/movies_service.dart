import 'package:flutter_tv/domain/movie.dart';

abstract class MoviesService {
  Future<List<Movie>> getMovies();
}
