// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Movie _$MovieFromJson(Map<String, dynamic> json) => Movie(
      id: json['id'] as String,
      name: json['name'] as String,
      synopsis: json['synopsis'] as String,
      meta: json['meta'] as String,
      rating: json['rating'] as String,
      image: json['image'] as String,
      trailer: json['trailer'] as String,
    );

Map<String, dynamic> _$MovieToJson(Movie instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'synopsis': instance.synopsis,
      'meta': instance.meta,
      'rating': instance.rating,
      'image': instance.image,
      'trailer': instance.trailer,
    };
