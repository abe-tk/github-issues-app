import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../models/issue.dart';
import '../models/comment.dart';

part 'github_api_service.g.dart';

/// GitHub API クライアント
@RestApi()
abstract class GitHubApiService {
  factory GitHubApiService(Dio dio, {String baseUrl}) = _GitHubApiService;

  /// Issues一覧取得
  @GET('/repos/{owner}/{repo}/issues')
  Future<List<Issue>> getIssues(
    @Path('owner') String owner,
    @Path('repo') String repo, {
    @Query('state') String state = 'open',
    @Query('per_page') int perPage = 30,
    @Query('page') int page = 1,
  });

  /// 特定Issue取得
  @GET('/repos/{owner}/{repo}/issues/{number}')
  Future<Issue> getIssue(
    @Path('owner') String owner,
    @Path('repo') String repo,
    @Path('number') int number,
  );

  /// Issue作成
  @POST('/repos/{owner}/{repo}/issues')
  Future<Issue> createIssue(
    @Path('owner') String owner,
    @Path('repo') String repo,
    @Body() Map<String, dynamic> request,
  );

  /// Issue更新
  @PATCH('/repos/{owner}/{repo}/issues/{number}')
  Future<Issue> updateIssue(
    @Path('owner') String owner,
    @Path('repo') String repo,
    @Path('number') int number,
    @Body() Map<String, dynamic> request,
  );

  /// Issue削除（クローズ）
  @PATCH('/repos/{owner}/{repo}/issues/{number}')
  Future<Issue> closeIssue(
    @Path('owner') String owner,
    @Path('repo') String repo,
    @Path('number') int number,
    @Body() Map<String, String> request,
  );

  /// Issue コメント一覧取得
  @GET('/repos/{owner}/{repo}/issues/{number}/comments')
  Future<List<Comment>> getComments(
    @Path('owner') String owner,
    @Path('repo') String repo,
    @Path('number') int number, {
    @Query('per_page') int perPage = 30,
    @Query('page') int page = 1,
  });

  /// コメント作成
  @POST('/repos/{owner}/{repo}/issues/{number}/comments')
  Future<Comment> createComment(
    @Path('owner') String owner,
    @Path('repo') String repo,
    @Path('number') int number,
    @Body() CommentRequest request,
  );

  /// コメント更新
  @PATCH('/repos/{owner}/{repo}/issues/comments/{commentId}')
  Future<Comment> updateComment(
    @Path('owner') String owner,
    @Path('repo') String repo,
    @Path('commentId') int commentId,
    @Body() CommentRequest request,
  );

  /// コメント削除
  @DELETE('/repos/{owner}/{repo}/issues/comments/{commentId}')
  Future<void> deleteComment(
    @Path('owner') String owner,
    @Path('repo') String repo,
    @Path('commentId') int commentId,
  );
}