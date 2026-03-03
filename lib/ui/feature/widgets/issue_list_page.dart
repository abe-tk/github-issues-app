import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/issue_list_view_model.dart';
import '../../core/widgets/loading_widget.dart';
import '../../core/widgets/error_widget.dart';
import '../../../routing/app_router.dart';
import '../../../data/models/issue.dart';

/// Issues一覧画面
class IssueListPage extends StatefulWidget {
  final String owner;
  final String repo;

  const IssueListPage({
    super.key,
    required this.owner,
    required this.repo,
  });

  @override
  State<IssueListPage> createState() => _IssueListPageState();
}

class _IssueListPageState extends State<IssueListPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = context.read<IssueListViewModel>();
      viewModel.setRepository(widget.owner, widget.repo);
      viewModel.fetchIssues(refresh: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Issues'),
            Text(
              '${widget.owner}/${widget.repo}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        leading: Navigator.of(context).canPop()
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).maybePop(),
              )
            : null,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              final viewModel = context.read<IssueListViewModel>();
              viewModel.changeState(value);
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'open', child: Text('Open')),
              const PopupMenuItem(value: 'closed', child: Text('Closed')),
              const PopupMenuItem(value: 'all', child: Text('All')),
            ],
            child: const Icon(Icons.filter_list),
          ),
        ],
      ),
      body: Consumer<IssueListViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading && viewModel.issues.isEmpty) {
            return const LoadingWidget(
              message: 'Issues を読み込み中...',
            );
          }

          if (viewModel.errorMessage != null && viewModel.issues.isEmpty) {
            return ErrorDisplayWidget(
              message: viewModel.errorMessage!,
              onRetry: () => viewModel.fetchIssues(refresh: true),
            );
          }

          if (viewModel.issues.isEmpty) {
            return const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.inbox, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text('Issues がありません'),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: viewModel.refresh,
            child: ListView.builder(
              itemCount: viewModel.issues.length + (viewModel.hasMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == viewModel.issues.length) {
                  // 追加読み込み
                  if (viewModel.isLoading) {
                    return const Padding(
                      padding: EdgeInsets.all(16),
                      child: LoadingWidget(),
                    );
                  } else {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      viewModel.loadMore();
                    });
                    return const SizedBox.shrink();
                  }
                }

                final issue = viewModel.issues[index];
                return IssueListItem(
                  issue: issue,
                  onTap: () => context.goToIssueDetail(
                    widget.owner,
                    widget.repo,
                    issue.number,
                  ),
                  onClose: () => _showCloseDialog(issue, viewModel),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.goToCreateIssue(widget.owner, widget.repo),
        icon: const Icon(Icons.add),
        label: const Text('Issue作成'),
      ),
    );
  }

  /// Issue クローズ確認ダイアログ
  void _showCloseDialog(Issue issue, IssueListViewModel viewModel) {
    showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Issue をクローズしますか？'),
        content: Text('Issue #${issue.number}: ${issue.title}'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('キャンセル'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(true);
              viewModel.closeIssue(issue.number);
            },
            child: const Text('クローズ'),
          ),
        ],
      ),
    );
  }
}

/// Issue リストアイテム
class IssueListItem extends StatelessWidget {
  final Issue issue;
  final VoidCallback onTap;
  final VoidCallback? onClose;

  const IssueListItem({
    super.key,
    required this.issue,
    required this.onTap,
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final isOpen = issue.state == 'open';
    
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    isOpen ? Icons.error_outline : Icons.check_circle_outline,
                    color: isOpen ? Colors.green : Colors.purple,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      issue.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (isOpen && onClose != null)
                    IconButton(
                      icon: const Icon(Icons.close, size: 20),
                      onPressed: onClose,
                      tooltip: 'Issue をクローズ',
                    ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    '#${issue.number}',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'by ${issue.user.login}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const Spacer(),
                  if (issue.comments != null && issue.comments! > 0) ...[
                    const Icon(Icons.comment_outlined, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      '${issue.comments}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ],
              ),
              if (issue.labels?.isNotEmpty ?? false) ...[
                const SizedBox(height: 8),
                Wrap(
                  spacing: 4,
                  runSpacing: 4,
                  children: issue.labels!.take(3).map((label) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Color(int.parse('0xFF${label.color}')),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        label.name,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: _getContrastColor(label.color),
                          fontSize: 10,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  /// ラベル色に対するコントラスト色を取得
  Color _getContrastColor(String hexColor) {
    final color = Color(int.parse('0xFF$hexColor'));
    final luminance = color.computeLuminance();
    return luminance > 0.5 ? Colors.black : Colors.white;
  }
}