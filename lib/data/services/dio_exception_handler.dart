import 'package:dio/dio.dart';
import '../../core/exception/app_exception.dart';

/// DioException を AppException に変換する
///
/// HTTP ステータスコードに応じて適切なサブクラスを返す。
/// ステータスコードがない場合（接続エラーなど）は NetworkException を返す。
AppException handleDioException(DioException e) {
  final statusCode = e.response?.statusCode;

  if (statusCode == 401) {
    return const AuthException('認証エラー: GitHub トークンが無効または未設定です');
  }
  if (statusCode == 404) {
    return const NotFoundException('リポジトリが見つかりません');
  }
  if (statusCode != null) {
    return ApiException(statusCode, 'APIエラー (HTTP $statusCode): ${e.message}');
  }
  return NetworkException('通信エラー: ${e.message}');
}
