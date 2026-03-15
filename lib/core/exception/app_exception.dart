/// アプリケーション固有の例外を表す sealed class
///
/// 各サブクラスがエラーの種別を型として表現する。
sealed class AppException {
  /// エラーメッセージ
  final String message;
  const AppException(this.message);
}

/// 認証エラー（HTTP 401）
class AuthException extends AppException {
  const AuthException(super.message);
}

/// リソース未発見エラー（HTTP 404）
class NotFoundException extends AppException {
  const NotFoundException(super.message);
}

/// APIエラー（その他の HTTP エラー）
class ApiException extends AppException {
  /// HTTP ステータスコード
  final int statusCode;
  const ApiException(this.statusCode, super.message);
}

/// 通信エラー（ネットワーク接続失敗など）
class NetworkException extends AppException {
  const NetworkException(super.message);
}

/// 予期しないエラー（上記以外の例外）
class UnknownException extends AppException {
  const UnknownException(super.message);
}
