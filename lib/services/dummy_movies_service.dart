import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_tv/domain/movie.dart';
import 'package:flutter_tv/domain/movies_list.dart';
import 'package:flutter_tv/services/movies_service.dart';

class DummyMoviesService implements MoviesService {
  @override
  Future<List<Movie>> getMovies() async {
    return MoviesList.fromJson(await rootBundle
            .loadString('assets/service.json')
            .then((movies) => json.decode(movies)))
        .movies;
  }
}
