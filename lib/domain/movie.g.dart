// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Movie _$MovieFromJson(Map<String, dynamic> json) {
  return Movie(
    name: json['name'] as String,
    image: json['image'] as String,
    synopsis: json['synopsis'] as String,
    meta: json['meta'] as String,
    rating: json['rating'] as String,
  );
}

Map<String, dynamic> _$MovieToJson(Movie instance) => <String, dynamic>{
      'name': instance.name,
      'image': instance.image,
      'synopsis': instance.synopsis,
      'meta': instance.meta,
      'rating': instance.rating,
    };
