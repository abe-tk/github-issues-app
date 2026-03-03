/// アプリ全体で使用する定数を定義
class AppConstants {
  /// GitHub API ベースURL
  static const String githubApiBaseUrl = 'https://api.github.com';

  /// アプリ名
  static const String appName = 'GitHub Issues 管理アプリ';

  /// デフォルトのリポジトリオーナー
  static const String defaultOwner = 'abe-tk';

  /// デフォルトのリポジトリ名
  static const String defaultRepo = 'github-issues-app';

  /// GitHub Personal Access Token（実際のアプリではセキュアな場所に保存）
  static const String githubToken = '';

  /// ページネーションのデフォルトサイズ
  static const int defaultPageSize = 30;

  /// タイムアウト設定（秒）
  static const Duration requestTimeout = Duration(seconds: 30);
}