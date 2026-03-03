import '../repositories/issue_repository.dart';
import '../../data/models/issue.dart';
import '../../data/models/comment.dart';

/// Issue関連のビジネスロジック
class IssueUsecase {
  final IssueRepository _repository;

  IssueUsecase(this._repository);

  /// Issues一覧取得
  Future<List<Issue>> getIssues(
    String owner,
    String repo, {
    String state = 'open',
    int perPage = 30,
    int page = 1,
  }) async {
    return await _repository.getIssues(
      owner,
      repo,
      state: state,
      perPage: perPage,
      page: page,
    );
  }

  /// 特定Issue取得
  Future<Issue> getIssue(String owner, String repo, int number) async {
    return await _repository.getIssue(owner, repo, number);
  }

  /// Issue作成
  Future<Issue> createIssue(
    String owner,
    String repo,
    String title,
    String? body, {
    List<String>? labels,
    List<String>? assignees,
  }) async {
    final request = IssueRequest(
      title: title,
      body: body,
      labels: labels,
      assignees: assignees,
    );
    return await _repository.createIssue(owner, repo, request);
  }

  /// Issue更新
  Future<Issue> updateIssue(
    String owner,
    String repo,
    int number,
    String title,
    String? body, {
    List<String>? labels,
    List<String>? assignees,
    String? state,
  }) async {
    final request = IssueRequest(
      title: title,
      body: body,
      labels: labels,
      assignees: assignees,
      state: state,
    );
    return await _repository.updateIssue(owner, repo, number, request);
  }

  /// Issue削除（クローズ）
  Future<Issue> closeIssue(String owner, String repo, int number) async {
    return await _repository.closeIssue(owner, repo, number);
  }

  /// Issue コメント一覧取得
  Future<List<Comment>> getComments(
    String owner,
    String repo,
    int number, {
    int perPage = 30,
    int page = 1,
  }) async {
    return await _repository.getComments(
      owner,
      repo,
      number,
      perPage: perPage,
      page: page,
    );
  }

  /// コメント作成
  Future<Comment> createComment(
    String owner,
    String repo,
    int number,
    String body,
  ) async {
    final request = CommentRequest(body: body);
    return await _repository.createComment(owner, repo, number, request);
  }

  /// コメント更新
  Future<Comment> updateComment(
    String owner,
    String repo,
    int commentId,
    String body,
  ) async {
    final request = CommentRequest(body: body);
    return await _repository.updateComment(owner, repo, commentId, request);
  }

  /// コメント削除
  Future<void> deleteComment(String owner, String repo, int commentId) async {
    await _repository.deleteComment(owner, repo, commentId);
  }
}