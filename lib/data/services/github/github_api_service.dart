import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'model/issue_api_model.dart';

part 'github_api_service.g.dart';

/// GitHub REST API クライアント（Retrofit 自動生成）
@RestApi(baseUrl: 'https://api.github.com')
abstract class GithubApiService {
  factory GithubApiService(Dio dio, {String baseUrl}) = _GithubApiService;

  /// Issue 一覧を取得する
  ///
  /// [owner] リポジトリのオーナー名
  /// [repo] リポジトリ名
  @GET('/repos/{owner}/{repo}/issues')
  Future<List<IssueApiModel>> getIssues(
    @Path('owner') String owner,
    @Path('repo') String repo,
  );
}
