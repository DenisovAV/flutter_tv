import 'package:flutter_tv/services/dummy_movies_service.dart';
import 'package:flutter_tv/services/movies_service.dart';

MoviesService getMoviesService() {
  return DummyMoviesService();
}
