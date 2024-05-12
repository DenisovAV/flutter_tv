// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MoviesUser _$UserFromJson(Map<String, dynamic> json) => MoviesUser(
      name: json['displayName'] as String,
      avatarURL: json['avatarURL'] as String,
      admin: json['admin'] as bool,
    );

Map<String, dynamic> _$UserToJson(MoviesUser instance) => <String, dynamic>{
      'displayName': instance.name,
      'avatarURL': instance.avatarURL,
      'admin': instance.admin,
    };
