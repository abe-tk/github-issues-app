import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'config/dependencies.dart';
import 'config/constants.dart';
import 'routing/app_router.dart';
import 'ui/core/themes/app_theme.dart';

void main() {
  runApp(const GitHubIssuesApp());
}

/// GitHub Issues 管理アプリ
class GitHubIssuesApp extends StatelessWidget {
  const GitHubIssuesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: DependenciesSetup.providers,
      child: MaterialApp.router(
        title: AppConstants.appName,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
