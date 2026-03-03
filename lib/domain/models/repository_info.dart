import 'package:freezed_annotation/freezed_annotation.dart';

part 'repository_info.freezed.dart';
part 'repository_info.g.dart';

/// リポジトリ情報モデル
@freezed
abstract class RepositoryInfo with _$RepositoryInfo {
  const factory RepositoryInfo({
    required String owner,
    required String repo,
  }) = _RepositoryInfo;

  factory RepositoryInfo.fromJson(Map<String, dynamic> json) => 
      _$RepositoryInfoFromJson(json);
}