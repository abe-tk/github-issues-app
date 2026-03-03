import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/issue_form_view_model.dart';
import '../view_models/issue_detail_view_model.dart';
import '../../core/widgets/loading_widget.dart';
import '../../core/widgets/error_widget.dart';
import '../../../routing/app_router.dart';

/// Issue作成・編集画面
class IssueFormPage extends StatefulWidget {
  final String owner;
  final String repo;
  final int? issueNumber; // null の場合は新規作成

  const IssueFormPage({
    super.key,
    required this.owner,
    required this.repo,
    this.issueNumber,
  });

  @override
  State<IssueFormPage> createState() => _IssueFormPageState();
}

class _IssueFormPageState extends State<IssueFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();

  bool get isEditing => widget.issueNumber != null;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final formViewModel = context.read<IssueFormViewModel>();
      
      if (isEditing) {
        // 編集モードの場合、Issue詳細を取得
        final detailViewModel = context.read<IssueDetailViewModel>();
        detailViewModel.fetchIssue(widget.owner, widget.repo, widget.issueNumber!);
      } else {
        // 新規作成モードで初期化
        formViewModel.initializeForCreate(widget.owner, widget.repo);
      }
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Issue編集' : 'Issue作成'),
        actions: [
          Consumer<IssueFormViewModel>(
            builder: (context, viewModel, child) {
              return TextButton(
                onPressed: viewModel.isLoading ? null : _onSubmit,
                child: Text(isEditing ? '更新' : '作成'),
              );
            },
          ),
        ],
      ),
      body: Consumer2<IssueFormViewModel, IssueDetailViewModel>(
        builder: (context, formViewModel, detailViewModel, child) {
          // 編集モードで Issue 詳細をロード中
          if (isEditing && detailViewModel.isLoading && detailViewModel.issue == null) {
            return const LoadingWidget(message: 'Issue を読み込み中...');
          }

          // 編集モードで Issue 詳細の読み込みエラー
          if (isEditing && detailViewModel.errorMessage != null && detailViewModel.issue == null) {
            return ErrorDisplayWidget(
              message: detailViewModel.errorMessage!,
              onRetry: () => detailViewModel.refresh(),
            );
          }

          // 編集モードで初回データ設定
          if (isEditing && detailViewModel.issue != null && formViewModel.editingIssue == null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              formViewModel.initializeForEdit(
                widget.owner,
                widget.repo,
                detailViewModel.issue!,
              );
              _titleController.text = formViewModel.title;
              _bodyController.text = formViewModel.body;
            });
          }

          return _buildForm(formViewModel);
        },
      ),
    );
  }

  Widget _buildForm(IssueFormViewModel viewModel) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // エラー表示
          if (viewModel.errorMessage != null)
            ErrorCard(
              message: viewModel.errorMessage!,
              onRetry: () => viewModel.clearError(),
            ),
          
          const SizedBox(height: 16),
          
          // タイトル入力
          TextFormField(
            controller: _titleController,
            decoration: const InputDecoration(
              labelText: 'タイトル *',
              hintText: 'Issue のタイトルを入力してください',
              prefixIcon: Icon(Icons.title),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'タイトルを入力してください';
              }
              return null;
            },
            onChanged: viewModel.updateTitle,
            enabled: !viewModel.isLoading,
          ),
          
          const SizedBox(height: 16),
          
          // 本文入力
          TextFormField(
            controller: _bodyController,
            decoration: const InputDecoration(
              labelText: '本文',
              hintText: 'Issue の詳細を入力してください（任意）',
              prefixIcon: Icon(Icons.description),
              alignLabelWithHint: true,
            ),
            maxLines: 10,
            onChanged: viewModel.updateBody,
            enabled: !viewModel.isLoading,
          ),
          
          const SizedBox(height: 24),
          
          // プレビューカード
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.preview, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        'プレビュー',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Divider(),
                  const SizedBox(height: 8),
                  if (viewModel.title.trim().isNotEmpty) ...[
                    Text(
                      viewModel.title.trim(),
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    if (viewModel.body.trim().isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Text(
                        viewModel.body.trim(),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ] else
                    Text(
                      'タイトルを入力してください',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 24),
          
          // 送信ボタン
          if (viewModel.isLoading)
            const LoadingCard(message: 'Issue を保存中...')
          else
            ElevatedButton.icon(
              onPressed: viewModel.isValid ? _onSubmit : null,
              icon: Icon(isEditing ? Icons.update : Icons.add),
              label: Text(isEditing ? 'Issue を更新' : 'Issue を作成'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          
          const SizedBox(height: 16),
          
          // リセットボタン
          OutlinedButton.icon(
            onPressed: viewModel.isLoading ? null : _onReset,
            icon: const Icon(Icons.refresh),
            label: const Text('リセット'),
          ),
          
          const SizedBox(height: 32),
          
          // ヘルプテキスト
          Card(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ヒント',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '• タイトルは必須です\n• 本文には Issue の詳細な説明を記載してください\n• Markdown記法が使用できます',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// フォーム送信処理
  void _onSubmit() async {
    if (_formKey.currentState?.validate() ?? false) {
      final formViewModel = context.read<IssueFormViewModel>();
      final result = await formViewModel.submit();
      
      if (result != null) {
        if (mounted) {
          // 成功時は詳細画面に遷移
          context.goToIssueDetail(widget.owner, widget.repo, result.number);
        }
      }
    }
  }

  /// フォームリセット処理
  void _onReset() {
    final formViewModel = context.read<IssueFormViewModel>();
    formViewModel.reset();
    
    _titleController.text = formViewModel.title;
    _bodyController.text = formViewModel.body;
  }
}