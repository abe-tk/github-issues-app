import 'package:flutter/foundation.dart';
import '../../../data/models/issue.dart';
import '../../../domain/usecases/issue_usecase.dart';

/// Issue作成・編集画面のViewModel
class IssueFormViewModel extends ChangeNotifier {
  final IssueUsecase _usecase;

  IssueFormViewModel(this._usecase);

  /// 編集対象のIssue（新規作成の場合はnull）
  Issue? _editingIssue;
  Issue? get editingIssue => _editingIssue;

  /// フォーム入力値
  String _title = '';
  String _body = '';
  
  String get title => _title;
  String get body => _body;

  /// ローディング状態
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  /// エラーメッセージ
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  /// リポジトリ情報
  String _owner = '';
  String _repo = '';

  /// 新規作成モードで初期化
  void initializeForCreate(String owner, String repo) {
    _owner = owner;
    _repo = repo;
    _editingIssue = null;
    _title = '';
    _body = '';
    _errorMessage = null;
    notifyListeners();
  }

  /// 編集モードで初期化
  void initializeForEdit(String owner, String repo, Issue issue) {
    _owner = owner;
    _repo = repo;
    _editingIssue = issue;
    _title = issue.title;
    _body = issue.body ?? '';
    _errorMessage = null;
    notifyListeners();
  }

  /// タイトルを更新
  void updateTitle(String title) {
    _title = title;
    notifyListeners();
  }

  /// 本文を更新
  void updateBody(String body) {
    _body = body;
    notifyListeners();
  }

  /// フォームバリデーション
  bool get isValid => _title.trim().isNotEmpty;

  /// Issue作成・更新を実行
  Future<Issue?> submit() async {
    if (!isValid) return null;
    if (_owner.isEmpty || _repo.isEmpty) return null;

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final Issue result;
      
      if (_editingIssue == null) {
        // 新規作成
        result = await _usecase.createIssue(
          _owner,
          _repo,
          _title.trim(),
          _body.trim().isEmpty ? null : _body.trim(),
        );
      } else {
        // 編集
        result = await _usecase.updateIssue(
          _owner,
          _repo,
          _editingIssue!.number,
          _title.trim(),
          _body.trim().isEmpty ? null : _body.trim(),
        );
      }

      return result;
    } catch (e) {
      _errorMessage = e.toString();
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// エラーをクリア
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  /// フォームをリセット
  void reset() {
    if (_editingIssue != null) {
      _title = _editingIssue!.title;
      _body = _editingIssue!.body ?? '';
    } else {
      _title = '';
      _body = '';
    }
    _errorMessage = null;
    notifyListeners();
  }
}