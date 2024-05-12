import 'package:json_annotation/json_annotation.dart';

part 'movie.g.dart';

@JsonSerializable()
class Movie {
  final String id;
  final String name;
  final String synopsis;
  final String meta;
  final String rating;
  final String image;
  final String trailer;

  const Movie({
    required this.id,
    required this.name,
    required this.synopsis,
    required this.meta,
    required this.rating,
    required this.image,
    required this.trailer,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Movie &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          id == other.id &&
          synopsis == other.synopsis &&
          meta == other.meta &&
          rating == other.rating &&
          image == other.image &&
          trailer == other.trailer;

  @override
  int get hashCode =>
      name.hashCode ^
      id.hashCode ^
      synopsis.hashCode ^
      meta.hashCode ^
      rating.hashCode ^
      image.hashCode ^
      trailer.hashCode;

  @override
  String toString() {
    return 'Movie{name: $name, meta: $meta, rating: $rating}';
  }

  factory Movie.fromJson(Map<String, dynamic> data) => _$MovieFromJson(data);

  Map<String, dynamic> toJson() => _$MovieToJson(this);

  static const fromJsonFactory = _$MovieFromJson;
}
