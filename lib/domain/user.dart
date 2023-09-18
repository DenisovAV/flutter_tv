import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class MoviesUser {
  final String name;
  final String avatarURL;
  final bool admin;

  const MoviesUser({
    required this.name,
    required this.avatarURL,
    required this.admin,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MoviesUser &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          admin == other.admin &&
          avatarURL == other.avatarURL;

  @override
  int get hashCode =>
      name.hashCode ^
      admin.hashCode ^
      avatarURL.hashCode;

  @override
  String toString() {
    return 'User{name: $name, admin: $admin}';
  }

  factory MoviesUser.fromJson(Map<String, dynamic> data) => _$UserFromJson(data);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  static const fromJsonFactory = _$UserFromJson;
}
