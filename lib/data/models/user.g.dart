// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_User _$UserFromJson(Map<String, dynamic> json) => _User(
  id: (json['id'] as num).toInt(),
  login: json['login'] as String,
  avatarUrl: json['avatar_url'] as String,
  url: json['url'] as String,
  htmlUrl: json['html_url'] as String,
  name: json['name'] as String?,
  email: json['email'] as String?,
);

Map<String, dynamic> _$UserToJson(_User instance) => <String, dynamic>{
  'id': instance.id,
  'login': instance.login,
  'avatar_url': instance.avatarUrl,
  'url': instance.url,
  'html_url': instance.htmlUrl,
  'name': instance.name,
  'email': instance.email,
};
