import 'package:flutter/foundation.dart';
import '../../../data/models/issue.dart';
import '../../../data/models/comment.dart';
import '../../../domain/usecases/issue_usecase.dart';

/// Issue詳細画面のViewModel
class IssueDetailViewModel extends ChangeNotifier {
  final IssueUsecase _usecase;

  IssueDetailViewModel(this._usecase);

  /// Issue詳細
  Issue? _issue;
  Issue? get issue => _issue;

  /// コメント一覧
  List<Comment> _comments = [];
  List<Comment> get comments => _comments;

  /// ローディング状態
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  /// コメント送信ローディング状態
  bool _isCommentLoading = false;
  bool get isCommentLoading => _isCommentLoading;

  /// エラーメッセージ
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  /// リポジトリ情報
  String _owner = '';
  String _repo = '';
  int _issueNumber = 0;

  /// Issue詳細を取得
  Future<void> fetchIssue(String owner, String repo, int number) async {
    _owner = owner;
    _repo = repo;
    _issueNumber = number;

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _issue = await _usecase.getIssue(owner, repo, number);
      await _fetchComments();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// コメント一覧を取得
  Future<void> _fetchComments() async {
    if (_owner.isEmpty || _repo.isEmpty || _issueNumber == 0) return;

    try {
      _comments = await _usecase.getComments(_owner, _repo, _issueNumber);
    } catch (e) {
      _errorMessage = e.toString();
    }
  }

  /// コメントを追加
  Future<void> addComment(String body) async {
    if (_owner.isEmpty || _repo.isEmpty || _issueNumber == 0) return;
    if (body.trim().isEmpty) return;

    _isCommentLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final newComment = await _usecase.createComment(
        _owner,
        _repo,
        _issueNumber,
        body.trim(),
      );
      
      _comments.add(newComment);
      
      // Issue のコメント数を更新
      if (_issue != null) {
        _issue = _issue!.copyWith(comments: (_issue!.comments ?? 0) + 1);
      }

    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isCommentLoading = false;
      notifyListeners();
    }
  }

  /// コメントを更新
  Future<void> updateComment(int commentId, String body) async {
    if (_owner.isEmpty || _repo.isEmpty) return;
    if (body.trim().isEmpty) return;

    try {
      final updatedComment = await _usecase.updateComment(
        _owner,
        _repo,
        commentId,
        body.trim(),
      );

      final index = _comments.indexWhere((c) => c.id == commentId);
      if (index != -1) {
        _comments[index] = updatedComment;
        notifyListeners();
      }
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  /// コメントを削除
  Future<void> deleteComment(int commentId) async {
    if (_owner.isEmpty || _repo.isEmpty) return;

    try {
      await _usecase.deleteComment(_owner, _repo, commentId);
      
      _comments.removeWhere((c) => c.id == commentId);
      
      // Issue のコメント数を更新
      if (_issue != null) {
        final currentCount = _issue!.comments ?? 0;
        if (currentCount > 0) {
          _issue = _issue!.copyWith(comments: currentCount - 1);
        }
      }
      
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  /// Issue状態を更新（クローズ）
  Future<void> closeIssue() async {
    if (_owner.isEmpty || _repo.isEmpty || _issueNumber == 0) return;
    if (_issue?.state == 'closed') return;

    try {
      final updatedIssue = await _usecase.closeIssue(_owner, _repo, _issueNumber);
      _issue = updatedIssue;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  /// リフレッシュ
  Future<void> refresh() async {
    if (_owner.isEmpty || _repo.isEmpty || _issueNumber == 0) return;
    await fetchIssue(_owner, _repo, _issueNumber);
  }

  /// エラーをクリア
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}