import 'package:flutter/material.dart';
import '../../../domain/models/issue/issue.dart';

/// Issue 一覧の各行を表示するリストアイテム Widget
class IssueListTile extends StatelessWidget {
  /// 表示する Issue
  final Issue issue;

  /// タップ時のコールバック
  final VoidCallback onTap;

  const IssueListTile({super.key, required this.issue, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isOpen = issue.state == 'open';

    return ListTile(
      onTap: onTap,
      leading: Text(
        '#${issue.number}',
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: Theme.of(context).colorScheme.outline,
        ),
      ),
      title: Text(issue.title, maxLines: 2, overflow: TextOverflow.ellipsis),
      trailing: Chip(
        label: Text(
          isOpen ? 'open' : 'closed',
          style: const TextStyle(color: Colors.white, fontSize: 12),
        ),
        // open は緑、closed は紫のバッジ
        backgroundColor: isOpen ? Colors.green : Colors.deepPurple,
        padding: const EdgeInsets.symmetric(horizontal: 4),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );
  }
}
