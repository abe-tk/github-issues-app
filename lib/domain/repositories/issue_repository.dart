import '../../data/models/issue.dart';
import '../../data/models/comment.dart';

/// Issueリポジトリのインターフェース
abstract class IssueRepository {
  /// Issues一覧取得
  Future<List<Issue>> getIssues(
    String owner,
    String repo, {
    String state = 'open',
    int perPage = 30,
    int page = 1,
  });

  /// 特定Issue取得
  Future<Issue> getIssue(String owner, String repo, int number);

  /// Issue作成
  Future<Issue> createIssue(String owner, String repo, IssueRequest request);

  /// Issue更新
  Future<Issue> updateIssue(
    String owner,
    String repo,
    int number,
    IssueRequest request,
  );

  /// Issue削除（クローズ）
  Future<Issue> closeIssue(String owner, String repo, int number);

  /// Issue コメント一覧取得
  Future<List<Comment>> getComments(
    String owner,
    String repo,
    int number, {
    int perPage = 30,
    int page = 1,
  });

  /// コメント作成
  Future<Comment> createComment(
    String owner,
    String repo,
    int number,
    CommentRequest request,
  );

  /// コメント更新
  Future<Comment> updateComment(
    String owner,
    String repo,
    int commentId,
    CommentRequest request,
  );

  /// コメント削除
  Future<void> deleteComment(String owner, String repo, int commentId);
}