import 'package:freezed_annotation/freezed_annotation.dart';

part 'issue.freezed.dart';

/// Issue ドメインモデル
///
/// API レスポンスから変換されたビジネスロジック層のエンティティ。
/// JSON シリアライズは不要（APIモデルから変換して使用する）。
@freezed
abstract class Issue with _$Issue {
  const factory Issue({
    /// Issue 番号
    required int number,

    /// Issue タイトル
    required String title,

    /// 状態（"open" / "closed"）
    required String state,

    /// Issue 本文（nullable）
    String? body,

    /// 作成日時
    required DateTime createdAt,

    /// 更新日時
    required DateTime updatedAt,
  }) = _Issue;
}
