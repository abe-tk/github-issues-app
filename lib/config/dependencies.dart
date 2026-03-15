import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/repositories/issue/issue_repository.dart';
import '../data/repositories/issue/issue_repository_remote.dart';
import '../data/services/github/github_api_service.dart';
import '../ui/issue/view_models/issue_list_view_model.dart';
import 'constants.dart' as constants;

/// アプリ全体の依存関係を一元管理する MultiProvider
///
/// 登録順序は依存関係の順に従う:
/// Dio → GithubApiService → IssueRepository → IssueListViewModel
Widget buildDependencies({required Widget child}) {
  return MultiProvider(
    providers: [
      // 1. 認証ヘッダー付き Dio インスタンス
      Provider<Dio>(
        create: (_) {
          final dio = Dio();
          // Authorization ヘッダーをインターセプターで付与する
          dio.interceptors.add(
            InterceptorsWrapper(
              onRequest: (options, handler) {
                options.headers['Authorization'] =
                    'Bearer ${constants.githubToken}';
                options.headers['Accept'] = 'application/vnd.github+json';
                options.headers['X-GitHub-Api-Version'] = '2022-11-28';
                handler.next(options);
              },
            ),
          );
          return dio;
        },
        dispose: (_, dio) => dio.close(),
      ),

      // 2. GitHub API サービス（Retrofit 生成クライアント）
      ProxyProvider<Dio, GithubApiService>(
        update: (_, dio, previous) => GithubApiService(dio),
      ),

      // 3. IssueRepository（IssueRepositoryRemote を IssueRepository として登録）
      ProxyProvider<GithubApiService, IssueRepository>(
        update: (_, service, previous) =>
            IssueRepositoryRemote(service: service),
      ),

      // 4. Issue 一覧 ViewModel
      ChangeNotifierProxyProvider<IssueRepository, IssueListViewModel>(
        create: (context) =>
            IssueListViewModel(repository: context.read<IssueRepository>()),
        update: (_, repository, previous) =>
            previous ?? IssueListViewModel(repository: repository),
      ),
    ],
    child: child,
  );
}
