import 'package:freezed_annotation/freezed_annotation.dart';
import 'user.dart';

part 'comment.freezed.dart';
part 'comment.g.dart';

/// GitHub コメントモデル
@freezed
abstract class Comment with _$Comment {
  const factory Comment({
    required int id,
    required String body,
    required User user,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
    @JsonKey(name: 'html_url') required String htmlUrl,
  }) = _Comment;

  factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);
}

/// コメント作成・更新リクエスト用モデル
@freezed
abstract class CommentRequest with _$CommentRequest {
  const factory CommentRequest({
    required String body,
  }) = _CommentRequest;

  factory CommentRequest.fromJson(Map<String, dynamic> json) =>
      _$CommentRequestFromJson(json);
}