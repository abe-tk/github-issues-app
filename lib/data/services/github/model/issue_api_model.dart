import 'package:freezed_annotation/freezed_annotation.dart';

part 'issue_api_model.freezed.dart';
part 'issue_api_model.g.dart';

/// GitHub API レスポンスの Issue DTO（データ転送オブジェクト）
///
/// freezed + json_serializable でイミュータブルに管理する。
/// JSON のフィールド名はスネークケース（snake_case）に変換する。
@freezed
abstract class IssueApiModel with _$IssueApiModel {
  const factory IssueApiModel({
    /// Issue 番号
    required int number,

    /// Issue タイトル
    required String title,

    /// 状態（"open" / "closed"）
    required String state,

    /// Issue 本文（nullable）
    String? body,

    /// 作成日時
    @JsonKey(name: 'created_at') required DateTime createdAt,

    /// 更新日時
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
  }) = _IssueApiModel;

  factory IssueApiModel.fromJson(Map<String, dynamic> json) =>
      _$IssueApiModelFromJson(json);
}
