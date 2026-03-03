import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/issue_detail_view_model.dart';
import '../../core/widgets/loading_widget.dart';
import '../../core/widgets/error_widget.dart';
import '../../../routing/app_router.dart';
import '../../../data/models/comment.dart';

/// Issue詳細画面
class IssueDetailPage extends StatefulWidget {
  final String owner;
  final String repo;
  final int issueNumber;

  const IssueDetailPage({
    super.key,
    required this.owner,
    required this.repo,
    required this.issueNumber,
  });

  @override
  State<IssueDetailPage> createState() => _IssueDetailPageState();
}

class _IssueDetailPageState extends State<IssueDetailPage> {
  final _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = context.read<IssueDetailViewModel>();
      viewModel.fetchIssue(widget.owner, widget.repo, widget.issueNumber);
    });
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<IssueDetailViewModel>(
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Issue #${widget.issueNumber}'),
            actions: [
              if (viewModel.issue != null)
                PopupMenuButton<String>(
                  onSelected: (value) {
                    switch (value) {
                      case 'edit':
                        context.goToEditIssue(
                          widget.owner,
                          widget.repo,
                          widget.issueNumber,
                        );
                        break;
                      case 'close':
                        _showCloseDialog(viewModel);
                        break;
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'edit',
                      child: ListTile(
                        leading: Icon(Icons.edit),
                        title: Text('編集'),
                      ),
                    ),
                    if (viewModel.issue?.state == 'open')
                      const PopupMenuItem(
                        value: 'close',
                        child: ListTile(
                          leading: Icon(Icons.close),
                          title: Text('クローズ'),
                        ),
                      ),
                  ],
                ),
            ],
          ),
          body: _buildBody(viewModel),
        );
      },
    );
  }

  Widget _buildBody(IssueDetailViewModel viewModel) {
    if (viewModel.isLoading && viewModel.issue == null) {
      return const LoadingWidget(message: 'Issue を読み込み中...');
    }

    if (viewModel.errorMessage != null && viewModel.issue == null) {
      return ErrorDisplayWidget(
        message: viewModel.errorMessage!,
        onRetry: () => viewModel.refresh(),
      );
    }

    final issue = viewModel.issue;
    if (issue == null) {
      return const ErrorDisplayWidget(
        message: 'Issue が見つかりませんでした',
      );
    }

    return RefreshIndicator(
      onRefresh: viewModel.refresh,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Issue 情報
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // タイトルと状態
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: issue.state == 'open' 
                              ? Colors.green 
                              : Colors.purple,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          issue.state.toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          issue.title,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // 作成者情報
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundImage: NetworkImage(issue.user.avatarUrl),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${issue.user.login} が ${_formatDate(issue.createdAt)} に作成',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                  
                  if (issue.body?.isNotEmpty ?? false) ...[
                    const SizedBox(height: 16),
                    const Divider(),
                    const SizedBox(height: 16),
                    Text(
                      issue.body!,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                  
                  // ラベル
                  if (issue.labels?.isNotEmpty ?? false) ...[
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: issue.labels!.map((label) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Color(int.parse('0xFF${label.color}')),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            label.name,
                            style: TextStyle(
                              color: _getContrastColor(label.color),
                              fontSize: 12,
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
          
          const SizedBox(height: 16),
          
          // コメント一覧
          Text(
            'コメント (${viewModel.comments.length})',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          
          const SizedBox(height: 8),
          
          ...viewModel.comments.map((comment) => CommentWidget(
            comment: comment,
            onEdit: (commentId, body) => viewModel.updateComment(commentId, body),
            onDelete: (commentId) => viewModel.deleteComment(commentId),
          )),
          
          // コメント入力
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'コメントを追加',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _commentController,
                    decoration: const InputDecoration(
                      hintText: 'コメントを入力してください...',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (viewModel.isCommentLoading)
                        const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: viewModel.isCommentLoading 
                            ? null 
                            : _onAddComment,
                        child: const Text('コメント'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 100), // フローティングボタンの余白
        ],
      ),
    );
  }

  /// コメント追加処理
  void _onAddComment() {
    final body = _commentController.text.trim();
    if (body.isNotEmpty) {
      final viewModel = context.read<IssueDetailViewModel>();
      viewModel.addComment(body).then((_) {
        _commentController.clear();
      });
    }
  }

  /// Issue クローズ確認ダイアログ
  void _showCloseDialog(IssueDetailViewModel viewModel) {
    showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Issue をクローズしますか？'),
        content: Text(viewModel.issue?.title ?? ''),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('キャンセル'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              viewModel.closeIssue();
            },
            child: const Text('クローズ'),
          ),
        ],
      ),
    );
  }

  /// 日付フォーマット
  String _formatDate(DateTime date) {
    return '${date.year}/${date.month}/${date.day}';
  }

  /// ラベル色に対するコントラスト色を取得
  Color _getContrastColor(String hexColor) {
    final color = Color(int.parse('0xFF$hexColor'));
    final luminance = color.computeLuminance();
    return luminance > 0.5 ? Colors.black : Colors.white;
  }
}

/// コメントウィジェット
class CommentWidget extends StatelessWidget {
  final Comment comment;
  final Function(int, String)? onEdit;
  final Function(int)? onDelete;

  const CommentWidget({
    super.key,
    required this.comment,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ユーザー情報
            Row(
              children: [
                CircleAvatar(
                  radius: 12,
                  backgroundImage: NetworkImage(comment.user.avatarUrl),
                ),
                const SizedBox(width: 8),
                Text(
                  comment.user.login,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  _formatDate(comment.createdAt),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 8),
            
            // コメント内容
            Text(
              comment.body,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}/${date.month}/${date.day}';
  }
}