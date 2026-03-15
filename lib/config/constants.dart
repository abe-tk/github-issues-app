// ビルド時の環境変数から読み込むアプリ定数
//
// 使用方法:
// flutter run \
//   --dart-define=GITHUB_TOKEN=your_pat \
//   --dart-define=GITHUB_OWNER=your_username \
//   --dart-define=GITHUB_REPO=your_repo

/// GitHub Personal Access Token
const String githubToken = String.fromEnvironment('GITHUB_TOKEN');

/// リポジトリのオーナー名
const String githubOwner = String.fromEnvironment('GITHUB_OWNER');

/// リポジトリ名
const String githubRepo = String.fromEnvironment('GITHUB_REPO');
