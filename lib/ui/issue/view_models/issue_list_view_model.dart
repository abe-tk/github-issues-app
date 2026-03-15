import 'package:flutter/foundation.dart';
import '../../../core/result.dart';
import '../../../data/repositories/issue/issue_repository.dart';
import '../../../domain/models/issue/issue.dart';

/// Issue 一覧画面の状態管理 ViewModel
class IssueListViewModel extends ChangeNotifier {
  final IssueRepository _repository;

  IssueListViewModel({required IssueRepository repository})
    : _repository = repository;

  /// 取得した Issue 一覧（プライベートフィールド）
  List<Issue> _issues = [];

  /// 取得した Issue 一覧
  List<Issue> get issues => _issues;

  /// ローディング中フラグ（プライベートフィールド）
  bool _isLoading = false;

  /// ローディング中フラグ
  bool get isLoading => _isLoading;

  /// エラーメッセージ（プライベートフィールド）
  String? _errorMessage;

  /// エラーメッセージ（エラーがない場合は null）
  String? get errorMessage => _errorMessage;

  /// Issue 一覧を読み込む
  ///
  /// ローディング状態の管理・リポジトリ呼び出し・結果反映・エラーハンドリングを行う。
  /// Result 型のパターンマッチで成功・失敗を処理する。
  Future<void> loadIssues() async {
    // ローディング開始
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await _repository.getIssues();

    // Result 型でパターンマッチしてエラー処理する
    switch (result) {
      case Success(:final value):
        _issues = value;
      case Failure(:final exception):
        _errorMessage = exception.message;
        _issues = [];
    }

    // ローディング終了
    _isLoading = false;
    notifyListeners();
  }
}
