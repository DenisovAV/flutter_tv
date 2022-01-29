import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_tv/domain/movie.dart';

part 'movies_list.g.dart';

@JsonSerializable()
class MoviesList {
  final List<Movie> movies;

  const MoviesList({
    required this.movies,
  });

  @override
  String toString() {
    return 'Movies: $movies';
  }

  factory MoviesList.fromJson(Map<String, dynamic> data) => _$MoviesListFromJson(data);

  Map<String, dynamic> toJson() => _$MoviesListToJson(this);

  static const fromJsonFactory = _$MoviesListFromJson;
}
