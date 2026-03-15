import 'package:dio/dio.dart';
import '../../../config/constants.dart' as constants;
import '../../../core/result.dart';
import '../../../domain/models/issue/issue.dart';
import '../../../core/exception/app_exception.dart';
import '../../services/dio_exception_handler.dart';
import '../../services/github/github_api_service.dart';
import 'issue_repository.dart';

/// IssueRepository の具体実装
class IssueRepositoryRemote implements IssueRepository {
  final GithubApiService _service;

  IssueRepositoryRemote({required GithubApiService service})
    : _service = service;

  /// Issue 一覧を取得する
  ///
  /// 環境変数から取得した owner・repo を使用して API を呼び出す。
  /// IssueApiModel をドメインモデル Issue に変換して返す。
  /// DioException が発生した場合は handleDioException() で AppException に変換し
  /// Failure として返す。例外は throw しない。
  @override
  Future<Result<List<Issue>>> getIssues() async {
    try {
      final apiModels = await _service.getIssues(
        constants.githubOwner,
        constants.githubRepo,
      );
      // API モデルをドメインモデルにマッピングする
      final issues = apiModels
          .map(
            (m) => Issue(
              number: m.number,
              title: m.title,
              state: m.state,
              body: m.body,
              createdAt: m.createdAt,
              updatedAt: m.updatedAt,
            ),
          )
          .toList();
      return Result.success(issues);
    } on DioException catch (e) {
      // DioException を AppException に変換して Failure として返す
      return Result.failure(handleDioException(e));
    } catch (e) {
      // 予期しない例外（マッピングエラー等）も Failure として返す
      return Result.failure(UnknownException(e.toString()));
    }
  }
}
