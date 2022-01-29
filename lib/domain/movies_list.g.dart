// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movies_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MoviesList _$MoviesListFromJson(Map<String, dynamic> json) {
  return MoviesList(
    movies: (json['movies'] as List<dynamic>)
        .map((e) => Movie.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$MoviesListToJson(MoviesList instance) => <String, dynamic>{
      'movies': instance.movies,
    };
