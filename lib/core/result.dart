import 'exception/app_exception.dart';

export 'exception/app_exception.dart';

/// 処理結果を表す sealed class
///
/// Success または Failure のいずれかを返すことで、
/// 例外を throw せずにエラーを型安全に扱う。
sealed class Result<T> {
  const Result();

  /// 成功を表す Result を生成するファクトリ
  factory Result.success(T value) => Success(value);

  /// 失敗を表す Result を生成するファクトリ
  factory Result.failure(AppException exception) => Failure(exception);
}

/// 成功を表すクラス
class Success<T> extends Result<T> {
  /// 成功時の値
  final T value;
  const Success(this.value);
}

/// 失敗を表すクラス
class Failure<T> extends Result<T> {
  /// 失敗時の例外
  final AppException exception;
  const Failure(this.exception);
}
