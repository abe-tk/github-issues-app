import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:app/core/exception/app_exception.dart';
import 'package:app/domain/models/issue/issue.dart';
import 'package:app/ui/issue/view_models/issue_list_view_model.dart';
import 'package:app/ui/issue/widgets/issue_list_screen.dart';
import 'package:app/ui/issue/widgets/issue_list_tile.dart';
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
  body: null,
  createdAt: DateTime(2024, 2, 1),
  updatedAt: DateTime(2024, 2, 2),
);

/// テスト用のウィジェットツリーをビルドするヘルパー
///
/// IssueListScreen は go_router の context.go() を使うため、GoRouter を設定する。
/// Provider を GoRouter の外側に配置することで、ビルドフェーズ中の
/// notifyListeners() 競合を防ぐ。
Widget buildTestWidget(IssueListViewModel viewModel) {
  final router = GoRouter(
    initialLocation: '/issues',
    routes: [
      GoRoute(
        path: '/issues',
        builder: (context, state) => const IssueListScreen(),
      ),
      // 詳細画面のダミールート（タップ遷移の受け皿）
      GoRoute(
        path: '/issues/:number',
        builder: (context, state) => const Scaffold(body: Text('詳細画面')),
      ),
    ],
  );

  return ChangeNotifierProvider<IssueListViewModel>.value(
    value: viewModel,
    child: MaterialApp.router(routerConfig: router),
  );
}

void main() {
  group('IssueListScreen ウィジェットテスト', () {
    late FakeIssueRepository fakeRepository;

    setUp(() {
      fakeRepository = FakeIssueRepository();
    });

    testWidgets('ローディング中は CircularProgressIndicator が表示されること', (
      WidgetTester tester,
    ) async {
      // Arrange: getIssues() が完了しないよう手動制御モードを有効化
      fakeRepository.enableManualComplete();
      final viewModel = IssueListViewModel(repository: fakeRepository);

      // Act: ウィジェットをビルドし、loadIssues() が開始された直後の状態を確認
      await tester.pumpWidget(buildTestWidget(viewModel));
      // ルーティングとフレーム処理をすすめる（Completer は未完了のまま）
      await tester.pump();
      await tester.pump();

      // Assert: ローディングインジケーターが表示されていること
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      // 後始末: Completer を完了させてリソースをクリーンアップ
      fakeRepository.complete();
      await tester.pumpAndSettle();
      viewModel.dispose();
    });

    testWidgets('データあり: IssueListTile が Issue の件数分表示されること', (
      WidgetTester tester,
    ) async {
      // Arrange
      fakeRepository.issuesToReturn = [_testIssue1, _testIssue2];
      final viewModel = IssueListViewModel(repository: fakeRepository);

      // Act
      await tester.pumpWidget(buildTestWidget(viewModel));
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(IssueListTile), findsNWidgets(2));

      viewModel.dispose();
    });

    testWidgets('データあり: Issue のタイトルが表示されること', (WidgetTester tester) async {
      // Arrange
      fakeRepository.issuesToReturn = [_testIssue1];
      final viewModel = IssueListViewModel(repository: fakeRepository);

      // Act
      await tester.pumpWidget(buildTestWidget(viewModel));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('テスト Issue 1'), findsOneWidget);

      viewModel.dispose();
    });

    testWidgets('エラー時: エラーメッセージが表示されること', (WidgetTester tester) async {
      // Arrange: Failure（NetworkException）を返すよう設定
      fakeRepository.shouldFail = true;
      fakeRepository.exception = const NetworkException('通信エラー: 接続に失敗しました');
      final viewModel = IssueListViewModel(repository: fakeRepository);

      // Act
      await tester.pumpWidget(buildTestWidget(viewModel));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('通信エラー: 接続に失敗しました'), findsOneWidget);
      // CircularProgressIndicator が非表示であること
      expect(find.byType(CircularProgressIndicator), findsNothing);

      viewModel.dispose();
    });

    testWidgets('Issue が 0 件のとき「Issue がありません」と表示されること', (
      WidgetTester tester,
    ) async {
      // Arrange
      fakeRepository.issuesToReturn = [];
      final viewModel = IssueListViewModel(repository: fakeRepository);

      // Act
      await tester.pumpWidget(buildTestWidget(viewModel));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Issue がありません'), findsOneWidget);

      viewModel.dispose();
    });

    testWidgets('AppBar に "Issues" タイトルが表示されること', (WidgetTester tester) async {
      // Arrange
      fakeRepository.issuesToReturn = [];
      final viewModel = IssueListViewModel(repository: fakeRepository);

      // Act
      await tester.pumpWidget(buildTestWidget(viewModel));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Issues'), findsOneWidget);

      viewModel.dispose();
    });

    testWidgets('Issue タイルをタップすると詳細画面へ遷移すること', (WidgetTester tester) async {
      // Arrange
      fakeRepository.issuesToReturn = [_testIssue1];
      final viewModel = IssueListViewModel(repository: fakeRepository);

      // Act
      await tester.pumpWidget(buildTestWidget(viewModel));
      await tester.pumpAndSettle();

      // Issue タイルをタップ
      await tester.tap(find.byType(IssueListTile).first);
      await tester.pumpAndSettle();

      // Assert: 詳細画面のダミーテキストが表示されること
      expect(find.text('詳細画面'), findsOneWidget);

      viewModel.dispose();
    });
  });
}
