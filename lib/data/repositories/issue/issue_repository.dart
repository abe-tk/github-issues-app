import '../../../core/result.dart';
import '../../../domain/models/issue/issue.dart';

/// Issue リポジトリのインターフェース（抽象クラス）
///
/// テスト時にモックへの差し替えを可能にする
abstract class IssueRepository {
  /// Issue 一覧を取得する
  ///
  /// 成功時は Success、失敗時は Failure を返す。
  /// 例外は throw せず Result 型でラップして返す。
  Future<Result<List<Issue>>> getIssues();
}
