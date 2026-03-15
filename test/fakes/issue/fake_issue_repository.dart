import 'dart:async';

import 'package:app/core/result.dart';
import 'package:app/data/repositories/issue/issue_repository.dart';
import 'package:app/domain/models/issue/issue.dart';

/// テスト用の IssueRepository Fake 実装
///
/// Fake はシンプルな戻り値の制御のみを行い、
/// モックライブラリなしでテストを記述できる。
/// Completer を使って非同期の完了タイミングも制御可能。
class FakeIssueRepository implements IssueRepository {
  /// getIssues() が返すデータ（テストから外部設定可能）
  List<Issue> issuesToReturn = [];

  /// Failure を返すかどうかのフラグ
  bool shouldFail = false;

  /// Failure 時に使用する AppException
  AppException exception = const NetworkException('通信エラー: テスト用エラー');

  /// 非同期完了を制御するための Completer
  /// null の場合は即座に返す
  Completer<Result<List<Issue>>>? _completer;

  /// 呼び出し完了を手動制御するモードを有効化する
  void enableManualComplete() {
    _completer = Completer<Result<List<Issue>>>();
  }

  /// 手動制御モードで成功結果を返す
  void complete() {
    if (_completer != null && !_completer!.isCompleted) {
      _completer!.complete(Result.success(issuesToReturn));
    }
  }

  @override
  Future<Result<List<Issue>>> getIssues() async {
    if (_completer != null) {
      return _completer!.future;
    }
    if (shouldFail) {
      return Result.failure(exception);
    }
    return Result.success(issuesToReturn);
  }
}
