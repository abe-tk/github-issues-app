import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

/// GitHubユーザーモデル
@freezed
abstract class User with _$User {
  const factory User({
    required int id,
    required String login,
    @JsonKey(name: 'avatar_url') required String avatarUrl,
    required String url,
    @JsonKey(name: 'html_url') required String htmlUrl,
    String? name,
    String? email,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}