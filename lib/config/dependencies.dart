import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../data/services/github_api_service.dart';
import '../data/repositories/issue_repository_impl.dart';
import '../domain/usecases/issue_usecase.dart';
import '../ui/feature/view_models/issue_list_view_model.dart';
import '../ui/feature/view_models/issue_detail_view_model.dart';
import '../ui/feature/view_models/issue_form_view_model.dart';
import '../ui/feature/view_models/app_config_view_model.dart';
import 'constants.dart';

/// プロバイダー設定
class DependenciesSetup {
  /// 全体のプロバイダー設定
  static List<ChangeNotifierProvider> get providers => [
        // アプリ設定
        ChangeNotifierProvider<AppConfigViewModel>(
          create: (context) => AppConfigViewModel(),
        ),
        
        // ViewModel プロバイダー
        ChangeNotifierProvider<IssueListViewModel>(
          create: (context) => IssueListViewModel(
            IssueUsecase(
              IssueRepositoryImpl(
                GitHubApiService(_createDio()),
              ),
            ),
          ),
        ),
        ChangeNotifierProvider<IssueDetailViewModel>(
          create: (context) => IssueDetailViewModel(
            IssueUsecase(
              IssueRepositoryImpl(
                GitHubApiService(_createDio()),
              ),
            ),
          ),
        ),
        ChangeNotifierProvider<IssueFormViewModel>(
          create: (context) => IssueFormViewModel(
            IssueUsecase(
              IssueRepositoryImpl(
                GitHubApiService(_createDio()),
              ),
            ),
          ),
        ),
      ];

  /// Dio インスタンス作成
  static Dio _createDio() {
    final dio = Dio();
    
    // ベースURL設定
    dio.options.baseUrl = AppConstants.githubApiBaseUrl;
    
    // タイムアウト設定
    dio.options.connectTimeout = AppConstants.requestTimeout;
    dio.options.receiveTimeout = AppConstants.requestTimeout;
    
    // ヘッダー設定
    dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/vnd.github+json',
      'X-GitHub-Api-Version': '2022-11-28',
      if (AppConstants.githubToken.isNotEmpty)
        'Authorization': 'Bearer ${AppConstants.githubToken}',
    };

    // ログ機能（デバッグ時のみ）
    dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        logPrint: (object) => debugPrint(object.toString()),
      ),
    );

    return dio;
  }
}