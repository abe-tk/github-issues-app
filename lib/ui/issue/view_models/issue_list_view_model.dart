import 'package:flutter/foundation.dart';
import '../../../data/models/issue.dart';
import '../../../domain/usecases/issue_usecase.dart';

/// Issues一覧画面のViewModel
class IssueListViewModel extends ChangeNotifier {
  final IssueUsecase _usecase;

  IssueListViewModel(this._usecase);

  /// Issues一覧
  List<Issue> _issues = [];
  List<Issue> get issues => _issues;

  /// ローディング状態
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  /// エラーメッセージ
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  /// リポジトリ情報
  String _owner = '';
  String _repo = '';

  /// フィルタリング状態
  String _currentState = 'open';
  String get currentState => _currentState;

  /// ページネーション
  int _currentPage = 1;
  bool _hasMore = true;
  bool get hasMore => _hasMore;

  /// リポジトリ情報を設定
  void setRepository(String owner, String repo) {
    _owner = owner;
    _repo = repo;
    _clearAndRefresh();
  }

  /// Issues一覧取得
  Future<void> fetchIssues({bool refresh = false}) async {
    if (_owner.isEmpty || _repo.isEmpty) return;
    
    if (refresh) {
      _clearAndRefresh();
    }

    if (_isLoading) return;

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final newIssues = await _usecase.getIssues(
        _owner,
        _repo,
        state: _currentState,
        page: _currentPage,
      );

      if (refresh || _currentPage == 1) {
        _issues = newIssues;
      } else {
        _issues.addAll(newIssues);
      }

      _hasMore = newIssues.length == 30; // GitHub APIのデフォルトは30件
      if (_hasMore) _currentPage++;

    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// 状態フィルタを変更
  Future<void> changeState(String state) async {
    if (_currentState == state) return;
    
    _currentState = state;
    _clearAndRefresh();
    await fetchIssues();
  }

  /// 次のページを読み込み
  Future<void> loadMore() async {
    if (_hasMore && !_isLoading) {
      await fetchIssues();
    }
  }

  /// リフレッシュ
  Future<void> refresh() async {
    await fetchIssues(refresh: true);
  }

  /// クリアして初期化
  void _clearAndRefresh() {
    _issues = [];
    _currentPage = 1;
    _hasMore = true;
    _errorMessage = null;
  }

  /// エラーをクリア
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  /// Issue削除（クローズ）
  Future<void> closeIssue(int number) async {
    if (_owner.isEmpty || _repo.isEmpty) return;

    try {
      await _usecase.closeIssue(_owner, _repo, number);
      
      // ローカルの状態を更新
      final index = _issues.indexWhere((issue) => issue.number == number);
      if (index != -1) {
        _issues[index] = _issues[index].copyWith(state: 'closed');
        
        // 現在のフィルタがopenの場合は削除
        if (_currentState == 'open') {
          _issues.removeAt(index);
        }
        
        notifyListeners();
      }
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }
}