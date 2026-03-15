import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:app/core/result.dart';
import 'package:app/data/services/github/model/issue_api_model.dart';
import 'package:app/data/repositories/issue/issue_repository_remote.dart';
import 'package:app/data/services/github/github_api_service.dart';

// Mockito によるモッククラスの自動生成
// 生成後: dart run build_runner build --delete-conflicting-outputs
@GenerateMocks([GithubApiService])
import 'issue_repository_remote_test.mocks.dart';

/// テスト用ダミーデータ（API モデル）
final _testApiIssue1 = IssueApiModel(
  number: 1,
  title: 'テスト Issue 1',
  state: 'open',
  body: 'テスト本文 1',
  createdAt: DateTime(2024, 1, 1),
  updatedAt: DateTime(2024, 1, 2),
);

void main() {
  group('IssueRepositoryRemote テスト', () {
    late MockGithubApiService mockService;
    late IssueRepositoryRemote repository;

    setUp(() {
      mockService = MockGithubApiService();
      repository = IssueRepositoryRemote(service: mockService);
    });

    group('getIssues() 成功時', () {
      test(
        'GithubApiService.getIssues() が呼ばれ、Success<List<Issue>> が返ること',
        () async {
          // Arrange: モックが IssueApiModel を返すよう設定
          when(
            mockService.getIssues(any, any),
          ).thenAnswer((_) async => [_testApiIssue1]);

          // Act
          final result = await repository.getIssues();

          // Assert: Success でドメインモデル Issue に変換されていること
          expect(result, isA<Success<dynamic>>());
          final success = result as Success;
          expect(success.value, hasLength(1));
          expect(success.value.first.number, 1);
          expect(success.value.first.title, 'テスト Issue 1');
          expect(success.value.first.state, 'open');
          // API サービスが呼び出されたことを検証
          verify(mockService.getIssues(any, any)).called(1);
        },
      );

      test('空リストが返ってきた場合も Success で空リストが返ること', () async {
        // Arrange
        when(
          mockService.getIssues(any, any),
        ).thenAnswer((_) async => <IssueApiModel>[]);

        // Act
        final result = await repository.getIssues();

        // Assert
        expect(result, isA<Success<dynamic>>());
        final success = result as Success;
        expect(success.value, isEmpty);
      });
    });

    group('getIssues() エラー時', () {
      test('HTTP 401 エラー時に Failure<AuthException> が返ること', () async {
        // Arrange: 401 レスポンスを持つ DioException を設定
        final dioException = DioException(
          requestOptions: RequestOptions(path: '/repos/owner/repo/issues'),
          response: Response(
            requestOptions: RequestOptions(path: '/repos/owner/repo/issues'),
            statusCode: 401,
          ),
          type: DioExceptionType.badResponse,
        );
        when(mockService.getIssues(any, any)).thenThrow(dioException);

        // Act
        final result = await repository.getIssues();

        // Assert: Failure で AuthException が返ること
        expect(result, isA<Failure<dynamic>>());
        final failure = result as Failure;
        expect(failure.exception, isA<AuthException>());
        expect(failure.exception.message, contains('認証エラー'));
      });

      test('HTTP 404 エラー時に Failure<NotFoundException> が返ること', () async {
        // Arrange: 404 レスポンスを持つ DioException を設定
        final dioException = DioException(
          requestOptions: RequestOptions(path: '/repos/owner/repo/issues'),
          response: Response(
            requestOptions: RequestOptions(path: '/repos/owner/repo/issues'),
            statusCode: 404,
          ),
          type: DioExceptionType.badResponse,
        );
        when(mockService.getIssues(any, any)).thenThrow(dioException);

        // Act
        final result = await repository.getIssues();

        // Assert: Failure で NotFoundException が返ること
        expect(result, isA<Failure<dynamic>>());
        final failure = result as Failure;
        expect(failure.exception, isA<NotFoundException>());
        expect(failure.exception.message, contains('リポジトリが見つかりません'));
      });

      test('その他の HTTP エラー時に Failure<ApiException> が返ること', () async {
        // Arrange: 500 レスポンスを持つ DioException を設定
        final dioException = DioException(
          requestOptions: RequestOptions(path: '/repos/owner/repo/issues'),
          response: Response(
            requestOptions: RequestOptions(path: '/repos/owner/repo/issues'),
            statusCode: 500,
          ),
          type: DioExceptionType.badResponse,
          message: 'Internal Server Error',
        );
        when(mockService.getIssues(any, any)).thenThrow(dioException);

        // Act
        final result = await repository.getIssues();

        // Assert: Failure で ApiException が返ること
        expect(result, isA<Failure<dynamic>>());
        final failure = result as Failure;
        expect(failure.exception, isA<ApiException>());
        expect(failure.exception.message, contains('APIエラー (HTTP 500)'));
        expect((failure.exception as ApiException).statusCode, 500);
      });

      test('ネットワーク接続エラー時に Failure<NetworkException> が返ること', () async {
        // Arrange: response なしの DioException（接続エラー）を設定
        final dioException = DioException(
          requestOptions: RequestOptions(path: '/repos/owner/repo/issues'),
          type: DioExceptionType.connectionError,
          message: 'SocketException',
        );
        when(mockService.getIssues(any, any)).thenThrow(dioException);

        // Act
        final result = await repository.getIssues();

        // Assert: Failure で NetworkException が返ること
        expect(result, isA<Failure<dynamic>>());
        final failure = result as Failure;
        expect(failure.exception, isA<NetworkException>());
        expect(failure.exception.message, contains('通信エラー'));
      });

      test(
        'DioException 以外の例外が発生した場合に Failure<UnknownException> が返ること',
        () async {
          // Arrange: DioException 以外の例外（マッピングエラー等）をスロー
          when(mockService.getIssues(any, any)).thenThrow(Exception('予期しない例外'));

          // Act
          final result = await repository.getIssues();

          // Assert: Failure で UnknownException が返ること
          expect(result, isA<Failure<dynamic>>());
          final failure = result as Failure;
          expect(failure.exception, isA<UnknownException>());
          expect(failure.exception.message, contains('予期しない例外'));
        },
      );
    });
  });
}
