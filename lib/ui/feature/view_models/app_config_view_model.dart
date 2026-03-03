import 'package:flutter/foundation.dart';
import '../../../domain/models/repository_info.dart';

/// アプリ設定管理のViewModel
class AppConfigViewModel extends ChangeNotifier {
  /// 現在のリポジトリ情報
  RepositoryInfo? _currentRepository;
  RepositoryInfo? get currentRepository => _currentRepository;

  /// リポジトリが設定されているかどうか
  bool get hasRepository => _currentRepository != null;

  /// リポジトリ情報を設定
  void setRepository(String owner, String repo) {
    if (owner.trim().isEmpty || repo.trim().isEmpty) {
      _currentRepository = null;
    } else {
      _currentRepository = RepositoryInfo(
        owner: owner.trim(),
        repo: repo.trim(),
      );
    }
    notifyListeners();
  }

  /// リポジトリ情報をクリア
  void clearRepository() {
    _currentRepository = null;
    notifyListeners();
  }

  /// リポジトリのフルネームを取得
  String get repositoryFullName {
    if (_currentRepository == null) return '';
    return '${_currentRepository!.owner}/${_currentRepository!.repo}';
  }
}