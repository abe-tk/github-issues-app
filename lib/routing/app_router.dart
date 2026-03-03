import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../config/constants.dart';
import '../ui/issue/widgets/issue_list_page.dart';
import '../ui/issue/widgets/issue_detail_page.dart';
import '../ui/issue/widgets/issue_form_page.dart';

/// アプリケーションのルーター設定
class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation:
        '/issues?owner=${AppConstants.defaultOwner}&repo=${AppConstants.defaultRepo}',
    routes: [
      // Issues一覧画面
      GoRoute(
        path: '/issues',
        name: 'issues',
        builder: (context, state) {
          final owner = state.uri.queryParameters['owner'] ?? '';
          final repo = state.uri.queryParameters['repo'] ?? '';
          return IssueListPage(owner: owner, repo: repo);
        },
        routes: [
          // Issue作成画面
          GoRoute(
            path: 'new',
            name: 'issue-create',
            builder: (context, state) {
              final owner = state.uri.queryParameters['owner'] ?? '';
              final repo = state.uri.queryParameters['repo'] ?? '';
              return IssueFormPage(owner: owner, repo: repo);
            },
          ),

          // Issue詳細画面
          GoRoute(
            path: ':number',
            name: 'issue-detail',
            builder: (context, state) {
              final owner = state.uri.queryParameters['owner'] ?? '';
              final repo = state.uri.queryParameters['repo'] ?? '';
              final number = int.tryParse(state.pathParameters['number'] ?? '') ?? 0;
              return IssueDetailPage(
                owner: owner,
                repo: repo,
                issueNumber: number,
              );
            },
          ),
          
          // Issue編集画面
          GoRoute(
            path: ':number/edit',
            name: 'issue-edit',
            builder: (context, state) {
              final owner = state.uri.queryParameters['owner'] ?? '';
              final repo = state.uri.queryParameters['repo'] ?? '';
              final number = int.tryParse(state.pathParameters['number'] ?? '') ?? 0;
              return IssueFormPage(
                owner: owner,
                repo: repo,
                issueNumber: number,
              );
            },
          ),
        ],
      ),
    ],
  );
}

/// ルート拡張メソッド
extension AppRoutes on BuildContext {
  /// Issues一覧画面に遷移
  void goToIssues(String owner, String repo) =>
      go('/issues?owner=$owner&repo=$repo');

  /// Issue詳細画面に遷移
  void goToIssueDetail(String owner, String repo, int number) =>
      go('/issues/$number?owner=$owner&repo=$repo');

  /// Issue作成画面に遷移
  void goToCreateIssue(String owner, String repo) =>
      go('/issues/new?owner=$owner&repo=$repo');

  /// Issue編集画面に遷移
  void goToEditIssue(String owner, String repo, int number) =>
      go('/issues/$number/edit?owner=$owner&repo=$repo');
}