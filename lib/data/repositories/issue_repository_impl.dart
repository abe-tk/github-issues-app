import 'package:dio/dio.dart';
import '../../domain/repositories/issue_repository.dart';
import '../models/issue.dart';
import '../models/comment.dart';
import '../services/github_api_service.dart';

/// IssueRepository の実装
class IssueRepositoryImpl implements IssueRepository {
  final GitHubApiService _apiService;

  IssueRepositoryImpl(this._apiService);

  @override
  Future<List<Issue>> getIssues(
    String owner,
    String repo, {
    String state = 'open',
    int perPage = 30,
    int page = 1,
  }) async {
    try {
      return await _apiService.getIssues(
        owner,
        repo,
        state: state,
        perPage: perPage,
        page: page,
      );
    } catch (e) {
      throw Exception('Issues取得に失敗しました: $e');
    }
  }

  @override
  Future<Issue> getIssue(String owner, String repo, int number) async {
    try {
      return await _apiService.getIssue(owner, repo, number);
    } catch (e) {
      throw Exception('Issue取得に失敗しました: $e');
    }
  }

  @override
  Future<Issue> createIssue(
    String owner,
    String repo,
    IssueRequest request,
  ) async {
    try {
      return await _apiService.createIssue(
        owner,
        repo,
        _buildIssueRequestPayload(request, includeState: false),
      );
    } on DioException catch (e) {
      throw Exception('Issue作成に失敗しました: ${_formatDioError(e)}');
    } catch (e) {
      throw Exception('Issue作成に失敗しました: $e');
    }
  }

  @override
  Future<Issue> updateIssue(
    String owner,
    String repo,
    int number,
    IssueRequest request,
  ) async {
    try {
      return await _apiService.updateIssue(
        owner,
        repo,
        number,
        _buildIssueRequestPayload(request, includeState: true),
      );
    } on DioException catch (e) {
      throw Exception('Issue更新に失敗しました: ${_formatDioError(e)}');
    } catch (e) {
      throw Exception('Issue更新に失敗しました: $e');
    }
  }

  @override
  Future<Issue> closeIssue(String owner, String repo, int number) async {
    try {
      return await _apiService.closeIssue(
        owner,
        repo,
        number,
        {'state': 'closed'},
      );
    } on DioException catch (e) {
      throw Exception('Issueクローズに失敗しました: ${_formatDioError(e)}');
    } catch (e) {
      throw Exception('Issueクローズに失敗しました: $e');
    }
  }

  @override
  Future<List<Comment>> getComments(
    String owner,
    String repo,
    int number, {
    int perPage = 30,
    int page = 1,
  }) async {
    try {
      return await _apiService.getComments(
        owner,
        repo,
        number,
        perPage: perPage,
        page: page,
      );
    } catch (e) {
      throw Exception('コメント取得に失敗しました: $e');
    }
  }

  @override
  Future<Comment> createComment(
    String owner,
    String repo,
    int number,
    CommentRequest request,
  ) async {
    try {
      return await _apiService.createComment(owner, repo, number, request);
    } catch (e) {
      throw Exception('コメント作成に失敗しました: $e');
    }
  }

  @override
  Future<Comment> updateComment(
    String owner,
    String repo,
    int commentId,
    CommentRequest request,
  ) async {
    try {
      return await _apiService.updateComment(owner, repo, commentId, request);
    } catch (e) {
      throw Exception('コメント更新に失敗しました: $e');
    }
  }

  @override
  Future<void> deleteComment(String owner, String repo, int commentId) async {
    try {
      await _apiService.deleteComment(owner, repo, commentId);
    } on DioException catch (e) {
      throw Exception('コメント削除に失敗しました: ${_formatDioError(e)}');
    } catch (e) {
      throw Exception('コメント削除に失敗しました: $e');
    }
  }

  String _formatDioError(DioException e) {
    final status = e.response?.statusCode;
    final data = e.response?.data;

    if (data is Map<String, dynamic>) {
      final message = data['message']?.toString();
      final errors = data['errors'];
      if (errors is List && errors.isNotEmpty) {
        final details = errors.map((err) => err.toString()).join(', ');
        return '[HTTP $status] $message ($details)';
      }
      if (message != null && message.isNotEmpty) {
        return '[HTTP $status] $message';
      }
    }

    return '[HTTP $status] ${e.message}';
  }

  Map<String, dynamic> _buildIssueRequestPayload(
    IssueRequest request, {
    required bool includeState,
  }) {
    final payload = <String, dynamic>{
      'title': request.title,
    };

    if (request.body != null) payload['body'] = request.body;
    if (request.assignees != null) payload['assignees'] = request.assignees;
    if (request.labels != null) payload['labels'] = request.labels;
    if (includeState && request.state != null) payload['state'] = request.state;

    return payload;
  }
}