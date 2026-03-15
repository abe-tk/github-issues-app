# GitHub Issues アプリ

GitHub REST API を利用して Issues を管理する Flutter モバイルアプリ。

## 機能・画面構成

| 画面 | 機能 |
|------|------|
| Issue一覧 | Issues を一覧表示 |
| Issue詳細 | Issue の内容を表示 |
| Issue作成 | タイトル・本文を入力して新規作成 |
| Issue編集 | 既存 Issue を更新 |

## セットアップ

### 必要な環境

- Flutter SDK `^3.10.8`
- Dart SDK `^3.10.8`

### 手順

1. リポジトリをクローン

```bash
git clone <repository-url>
cd github-issues-app
```

2. 依存関係をインストール

```bash
flutter pub get
```

3. アプリを起動

GitHub PAT は [Settings > Developer settings > Personal access tokens](https://github.com/settings/tokens) から発行する。
必要なスコープ: `repo`

認証情報はビルド時に `--dart-define` で渡す：

```bash
flutter run \
  --dart-define=GITHUB_TOKEN=your_personal_access_token \
  --dart-define=GITHUB_OWNER=your_github_username \
  --dart-define=GITHUB_REPO=your_repository_name
```

## 開発

### コード生成

モデルクラスや API クライアントを変更した場合はコード生成を再実行する。

```bash
dart run build_runner build --delete-conflicting-outputs
```

開発中はウォッチモードが便利。

```bash
dart run build_runner watch --delete-conflicting-outputs
```

### テスト

```bash
flutter test
```

### 静的解析・フォーマット

```bash
flutter analyze
dart format lib/ test/
```

## アーキテクチャ

レイヤー構成は **UI → Domain → Data** とし、[compass_app](https://github.com/flutter/samples/tree/main/compass_app/app/lib) の構成に準拠する。

```
lib/
├── main.dart
├── config/
│   ├── dependencies.dart        # Provider設定
│   └── constants.dart           # アプリ定数
├── data/
│   ├── models/                  # データモデル（freezed + json_serializable）
│   ├── services/                # APIサービス（Retrofit生成）
│   └── repositories/            # リポジトリ実装
├── domain/
│   ├── models/                  # ドメインモデル
│   └── usecases/                # ビジネスロジック
├── routing/
│   ├── app_router.dart          # go_router設定
│   └── routes.dart              # ルート定義
├── ui/
│   ├── core/                    # 共通UIコンポーネント
│   │   ├── themes/
│   │   └── widgets/
│   └── {feature}/               # 機能単位（例: issues/）
│       ├── view_models/         # ViewModel（ChangeNotifier）
│       └── widgets/             # 画面・コンポーネント
└── utils/
```

## 技術スタック

| 用途 | パッケージ |
|------|-----------|
| 状態管理 | [provider](https://pub.dev/packages/provider) |
| HTTP通信 | [dio](https://pub.dev/packages/dio) |
| APIクライアント生成 | [retrofit](https://pub.dev/packages/retrofit) |
| イミュータブルモデル | [freezed](https://pub.dev/packages/freezed) |
| JSONシリアライズ | [json_serializable](https://pub.dev/packages/json_serializable) |
| ルーティング | [go_router](https://pub.dev/packages/go_router) |
