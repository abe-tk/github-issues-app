import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app/domain/models/issue/issue.dart';
import 'package:app/ui/issue/widgets/issue_list_tile.dart';

/// テスト用ダミーデータ
final _openIssue = Issue(
  number: 1,
  title: 'テスト Issue（open）',
  state: 'open',
  body: 'テスト本文',
  createdAt: DateTime(2024, 1, 1),
  updatedAt: DateTime(2024, 1, 2),
);

final _closedIssue = Issue(
  number: 2,
  title: 'テスト Issue（closed）',
  state: 'closed',
  body: null,
  createdAt: DateTime(2024, 2, 1),
  updatedAt: DateTime(2024, 2, 2),
);

/// テスト用のウィジェットツリーをビルドするヘルパー
Widget buildTile({required Issue issue, VoidCallback? onTap}) {
  return MaterialApp(
    home: Scaffold(
      body: IssueListTile(issue: issue, onTap: onTap ?? () {}),
    ),
  );
}

void main() {
  group('IssueListTile ウィジェットテスト', () {
    group('表示内容', () {
      testWidgets('Issue 番号がシャープ付きで表示されること', (WidgetTester tester) async {
        // Act
        await tester.pumpWidget(buildTile(issue: _openIssue));

        // Assert: #1 のように表示されること
        expect(find.text('#1'), findsOneWidget);
      });

      testWidgets('Issue のタイトルが表示されること', (WidgetTester tester) async {
        // Act
        await tester.pumpWidget(buildTile(issue: _openIssue));

        // Assert
        expect(find.text('テスト Issue（open）'), findsOneWidget);
      });
    });

    group('open 状態のバッジ', () {
      testWidgets('open 状態のバッジに "open" ラベルが表示されること', (
        WidgetTester tester,
      ) async {
        // Act
        await tester.pumpWidget(buildTile(issue: _openIssue));

        // Assert
        expect(find.text('open'), findsOneWidget);
      });

      testWidgets('open 状態のバッジが緑色（Colors.green）で表示されること', (
        WidgetTester tester,
      ) async {
        // Act
        await tester.pumpWidget(buildTile(issue: _openIssue));

        // Assert: Chip の backgroundColor が緑色であることを確認
        final chip = tester.widget<Chip>(find.byType(Chip));
        expect(chip.backgroundColor, Colors.green);
      });
    });

    group('closed 状態のバッジ', () {
      testWidgets('closed 状態のバッジに "closed" ラベルが表示されること', (
        WidgetTester tester,
      ) async {
        // Act
        await tester.pumpWidget(buildTile(issue: _closedIssue));

        // Assert
        expect(find.text('closed'), findsOneWidget);
      });

      testWidgets('closed 状態のバッジが紫色（Colors.deepPurple）で表示されること', (
        WidgetTester tester,
      ) async {
        // Act
        await tester.pumpWidget(buildTile(issue: _closedIssue));

        // Assert: Chip の backgroundColor が deepPurple であることを確認
        final chip = tester.widget<Chip>(find.byType(Chip));
        expect(chip.backgroundColor, Colors.deepPurple);
      });
    });

    group('タップ操作', () {
      testWidgets('タイルをタップすると onTap が呼ばれること', (WidgetTester tester) async {
        // Arrange: タップ検知フラグ
        var tapped = false;

        // Act
        await tester.pumpWidget(
          buildTile(
            issue: _openIssue,
            onTap: () {
              tapped = true;
            },
          ),
        );
        await tester.tap(find.byType(ListTile));
        await tester.pump();

        // Assert
        expect(tapped, isTrue);
      });

      testWidgets('タップが複数回呼ばれた場合もそれぞれ検知できること', (WidgetTester tester) async {
        // Arrange
        var tapCount = 0;

        // Act
        await tester.pumpWidget(
          buildTile(
            issue: _openIssue,
            onTap: () {
              tapCount++;
            },
          ),
        );
        await tester.tap(find.byType(ListTile));
        await tester.pump();
        await tester.tap(find.byType(ListTile));
        await tester.pump();

        // Assert
        expect(tapCount, 2);
      });
    });
  });
}
