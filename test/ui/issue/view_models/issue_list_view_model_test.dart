import 'package:flutter_test/flutter_test.dart';
import 'package:app/core/exception/app_exception.dart';
import 'package:app/domain/models/issue/issue.dart';
import 'package:app/ui/issue/view_models/issue_list_view_model.dart';
import '../../../fakes/issue/fake_issue_repository.dart';

/// テスト用ダミーデータ
final _testIssue1 = Issue(
  number: 1,
  title: 'テスト Issue 1',
  state: 'open',
  body: 'テスト本文 1',
  createdAt: DateTime(2024, 1, 1),
  updatedAt: DateTime(2024, 1, 2),
);

final _testIssue2 = Issue(
  number: 2,
  title: 'テスト Issue 2',
  state: 'closed',
  body: 'テスト本文 2',
  createdAt: DateTime(2024, 2, 1),
  updatedAt: DateTime(2024, 2, 2),
);

void main() {
  group('IssueListViewModel テスト', () {
    late FakeIssueRepository fakeRepository;
    late IssueListViewModel viewModel;

    setUp(() {
      fakeRepository = FakeIssueRepository();
      viewModel = IssueListViewModel(repository: fakeRepository);
    });

    tearDown(() {
      viewModel.dispose();
    });

    group('初期状態', () {
      test('初期状態では issues が空・isLoading が false・errorMessage が null', () {
        expect(viewModel.issues, isEmpty);
        expect(viewModel.isLoading, isFalse);
        expect(viewModel.errorMessage, isNull);
      });
    });

    group('loadIssues() 成功時', () {
      test('取得した Issue が issues に格納されること', () async {
        // Arrange: リポジトリが返すデータを設定
        fakeRepository.issuesToReturn = [_testIssue1, _testIssue2];

        // Act
        await viewModel.loadIssues();

        // Assert
        expect(viewModel.issues, hasLength(2));
        expect(viewModel.issues[0].number, 1);
        expect(viewModel.issues[1].number, 2);
      });

      test('成功後は isLoading が false になること', () async {
        // Arrange
        fakeRepository.issuesToReturn = [_testIssue1];

        // Act
        await viewModel.loadIssues();

        // Assert
        expect(viewModel.isLoading, isFalse);
      });

      test('成功後は errorMessage が null のままであること', () async {
        // Arrange
        fakeRepository.issuesToReturn = [_testIssue1];

        // Act
        await viewModel.loadIssues();

        // Assert
        expect(viewModel.errorMessage, isNull);
      });

      test('Issue が 0 件のときは issues が空リストになること', () async {
        // Arrange
        fakeRepository.issuesToReturn = [];

        // Act
        await viewModel.loadIssues();

        // Assert
        expect(viewModel.issues, isEmpty);
        expect(viewModel.isLoading, isFalse);
        expect(viewModel.errorMessage, isNull);
      });
    });

    group('loadIssues() 失敗時', () {
      test('Failure 時に errorMessage が設定されること', () async {
        // Arrange: Failure を返すよう設定
        fakeRepository.shouldFail = true;
        fakeRepository.exception = const NetworkException('通信エラー: テスト用エラー');

        // Act
        await viewModel.loadIssues();

        // Assert
        expect(viewModel.errorMessage, isNotNull);
        expect(viewModel.errorMessage, contains('通信エラー: テスト用エラー'));
      });

      test('Failure 時に isLoading が false になること', () async {
        // Arrange
        fakeRepository.shouldFail = true;
        fakeRepository.exception = const NetworkException('通信エラー');

        // Act
        await viewModel.loadIssues();

        // Assert
        expect(viewModel.isLoading, isFalse);
      });

      test('Failure 時に issues が空リストになること', () async {
        // Arrange
        fakeRepository.shouldFail = true;
        fakeRepository.exception = const NetworkException('通信エラー');

        // Act
        await viewModel.loadIssues();

        // Assert
        expect(viewModel.issues, isEmpty);
      });

      test('AuthException のメッセージが errorMessage に設定されること', () async {
        // Arrange
        fakeRepository.shouldFail = true;
        fakeRepository.exception = const AuthException('認証エラー: トークンが無効です');

        // Act
        await viewModel.loadIssues();

        // Assert
        expect(viewModel.errorMessage, contains('認証エラー'));
      });
    });

    group('loadIssues() 実行中', () {
      test('loadIssues() 呼び出し後に notifyListeners() が呼ばれること', () async {
        // Arrange: 通知を検知するリスナーを登録
        final notifyCount = <int>[];
        viewModel.addListener(() => notifyCount.add(notifyCount.length));
        fakeRepository.issuesToReturn = [_testIssue1];

        // Act
        await viewModel.loadIssues();

        // Assert: ローディング開始と終了の 2 回通知されること
        expect(notifyCount, hasLength(2));
      });

      test('loadIssues() 実行中は isLoading が true になること', () async {
        // Arrange: Completer で完了を手動制御し、ローディング中の状態を検証する
        fakeRepository.enableManualComplete();
        fakeRepository.issuesToReturn = [_testIssue1];

        // isLoading が true になった瞬間をキャプチャするリスナーを登録
        bool? isLoadingDuringFetch;
        viewModel.addListener(() {
          // 最初の通知（ローディング開始）のみキャプチャ
          if (isLoadingDuringFetch == null) {
            isLoadingDuringFetch = viewModel.isLoading;
          }
        });

        // Act: loadIssues() を開始するが await しない
        final loadFuture = viewModel.loadIssues();

        // Assert: ローディング開始時に isLoading が true であること
        expect(isLoadingDuringFetch, isTrue);

        // 後処理: Completer を完了させて Future を終わらせる
        fakeRepository.complete();
        await loadFuture;

        // Assert: 完了後は isLoading が false に戻ること
        expect(viewModel.isLoading, isFalse);
      });
    });
  });
}
