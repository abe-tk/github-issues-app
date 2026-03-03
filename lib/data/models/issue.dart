import 'package:freezed_annotation/freezed_annotation.dart';
import 'user.dart';
import 'label.dart';

part 'issue.freezed.dart';
part 'issue.g.dart';

/// GitHub Issueモデル
@freezed
abstract class Issue with _$Issue {
  const factory Issue({
    required int id,
    required int number,
    required String title,
    String? body,
    required String state,
    required User user,
    List<Label>? labels,
    User? assignee,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
    @JsonKey(name: 'closed_at') DateTime? closedAt,
    @JsonKey(name: 'html_url') required String htmlUrl,
    @JsonKey(name: 'comments_url') required String commentsUrl,
    int? comments,
  }) = _Issue;

  factory Issue.fromJson(Map<String, dynamic> json) => _$IssueFromJson(json);
}

/// Issue作成・更新リクエスト用モデル
@freezed
abstract class IssueRequest with _$IssueRequest {
  const factory IssueRequest({
    required String title,
    @JsonKey(includeIfNull: false) String? body,
    @JsonKey(includeIfNull: false) List<String>? assignees,
    @JsonKey(includeIfNull: false) List<String>? labels,
    @JsonKey(includeIfNull: false) String? state,
  }) = _IssueRequest;

  factory IssueRequest.fromJson(Map<String, dynamic> json) =>
      _$IssueRequestFromJson(json);
}