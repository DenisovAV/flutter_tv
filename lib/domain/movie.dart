import 'package:json_annotation/json_annotation.dart';

part 'movie.g.dart';

@JsonSerializable()
class Movie {
  final String name;
  final String image;
  final String synopsis;
  final String meta;
  final String rating;

  const Movie({
    required this.name,
    required this.image,
    required this.synopsis,
    required this.meta,
    required this.rating,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Movie &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          image == other.image &&
          synopsis == other.synopsis &&
          meta == other.meta &&
          rating == other.rating;

  @override
  int get hashCode =>
      name.hashCode ^ image.hashCode ^ synopsis.hashCode ^ meta.hashCode ^ rating.hashCode;

  @override
  String toString() {
    return 'Movie{name: $name, meta: $meta, rating: $rating}';
  }

  factory Movie.fromJson(Map<String, dynamic> data) => _$MovieFromJson(data);

  Map<String, dynamic> toJson() => _$MovieToJson(this);

  static const fromJsonFactory = _$MovieFromJson;
}
