import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final String id;
  final String name;
  final String image;

  const User({
    required this.id,
    required this.name,
    required this.image,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          id == other.id &&
          image == other.image;

  @override
  int get hashCode =>
      name.hashCode ^
      id.hashCode ^
      image.hashCode;

  @override
  String toString() {
    return 'User{name: $name}';
  }

  factory User.fromJson(Map<String, dynamic> data) => _$UserFromJson(data);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  static const fromJsonFactory = _$UserFromJson;
}
