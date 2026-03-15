import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../routing/routes.dart';
import '../view_models/issue_list_view_model.dart';
import 'issue_list_tile.dart';

/// Issue 一覧画面
class IssueListScreen extends StatefulWidget {
  const IssueListScreen({super.key});

  @override
  State<IssueListScreen> createState() => _IssueListScreenState();
}

class _IssueListScreenState extends State<IssueListScreen> {
  @override
  void initState() {
    super.initState();
    // ビルドフェーズ完了後に loadIssues() を実行することで、
    // ビルド中に notifyListeners() が呼ばれる競合を防ぐ
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        // listen: false で不要な再ビルドを防ぐ
        context.read<IssueListViewModel>().loadIssues();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Issues'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Consumer<IssueListViewModel>(
        builder: (context, viewModel, child) {
          // ローディング中はインジケーターを中央表示
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // エラー発生時はエラーメッセージを中央表示
          final errorMessage = viewModel.errorMessage;
          if (errorMessage != null) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  errorMessage,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          // Issue がゼロ件の場合のメッセージ
          if (viewModel.issues.isEmpty) {
            return const Center(child: Text('Issue がありません'));
          }

          // Issue 一覧を表示
          return ListView.separated(
            itemCount: viewModel.issues.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final issue = viewModel.issues[index];
              return IssueListTile(
                issue: issue,
                onTap: () {
                  // 詳細画面へ遷移
                  context.go(Routes.issueDetail(issue.number));
                },
              );
            },
          );
        },
      ),
    );
  }
}
