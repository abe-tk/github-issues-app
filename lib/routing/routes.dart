/// アプリのルートパス定数
class Routes {
  Routes._();

  /// Issue 一覧画面
  static const String issues = '/issues';

  /// Issue 詳細画面（実際のパスを生成するメソッド）
  static String issueDetail(int number) => '/issues/$number';

  /// Issue 編集画面（実際のパスを生成するメソッド）
  static String issueEdit(int number) => '/issues/$number/edit';
}
