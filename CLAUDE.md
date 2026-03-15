# GitHub Issues アプリ - CLAUDE.md

## プロジェクト概要

GitHub REST API を利用して Issues を管理する Flutter モバイルアプリ。
Issue の一覧表示・作成・更新を行うことができる。

## 必須要件

- Issue の一覧取得と表示
- Issue の作成
- Issue の更新
- テストコードの作成

## アーキテクチャ

**レイヤー構成**: UI → Domain → Data

compass_app（https://github.com/flutter/samples/tree/main/compass_app/app/lib）の構成に準拠する。

### ディレクトリ構成

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
| 状態管理 | provider |
| HTTP通信 | dio |
| APIクライアント生成 | retrofit + retrofit_generator |
| イミュータブルモデル | freezed + freezed_annotation |
| JSONシリアライズ | json_serializable + json_annotation |
| ルーティング | go_router |
| コード生成 | build_runner |

## コード生成

モデルクラスやAPIクライアントを変更した場合は必ずコード生成を実行する：

```bash
# 一回実行
dart run build_runner build --delete-conflicting-outputs

# ファイル監視（開発中）
dart run build_runner watch --delete-conflicting-outputs
```

コード生成対象：
- `*.freezed.dart` - Freezedモデル
- `*.g.dart` - json_serializable / Retrofitクライアント

## GitHub API

- Base URL: `https://api.github.com`
- 認証: Personal Access Token（PAT）を `Authorization: Bearer <token>` ヘッダーで送信

### 主要エンドポイント

| 操作 | メソッド | パス |
|------|---------|------|
| Issues一覧取得 | GET | `/repos/{owner}/{repo}/issues` |
| Issue作成 | POST | `/repos/{owner}/{repo}/issues` |
| Issue更新 | PATCH | `/repos/{owner}/{repo}/issues/{number}` |

## 画面構成

| 画面 | ルート | 役割 |
|------|--------|------|
| Issue一覧画面 | `/issues` | Issues を一覧表示。タップで詳細へ遷移 |
| Issue詳細画面 | `/issues/:number` | Issue の内容を表示。編集ボタンで編集画面へ |
| Issue作成画面 | `/issues/new` | タイトル・本文を入力して Issue を POST |
| Issue編集画面 | `/issues/:number/edit` | 既存 Issue を PATCH |

- 設定画面は不要。認証情報はビルド時の環境変数で渡す（後述）
- アプリ起動時のデフォルトルートは `/issues`（一覧画面）

## セキュリティ上の注意

**認証情報（PATトークン、リポジトリのowner/repo名など）はコードにハードコードしない。**

ビルド時に `--dart-define` で渡し、コード内では `String.fromEnvironment()` で参照する：

```bash
flutter run \
  --dart-define=GITHUB_TOKEN=your_pat \
  --dart-define=GITHUB_OWNER=your_username \
  --dart-define=GITHUB_REPO=your_repo
```

```dart
// lib/config/constants.dart
const githubToken = String.fromEnvironment('GITHUB_TOKEN');
const githubOwner = String.fromEnvironment('GITHUB_OWNER');
const githubRepo  = String.fromEnvironment('GITHUB_REPO');
```

- `.env` ファイルは使用しない
- `git add` 前に機密情報が含まれていないか確認する

## テスト方針

```bash
# 全テスト実行
flutter test

# カバレッジ付き
flutter test --coverage
```

テストの対象・粒度：
- **ユニットテスト**: ViewModel、UseCase、Repository（モックを使用）
- **ウィジェットテスト**: 主要な画面・コンポーネントの表示・操作

## 開発コマンド

```bash
# 依存関係インストール
flutter pub get

# アプリ起動
flutter run

# 静的解析
flutter analyze

# フォーマット
dart format lib/ test/
```

## コーディング規約

- コメントは日本語で記述する
- `part` ファイル（`.g.dart`, `.freezed.dart`）は手動編集しない
- Provider は `ChangeNotifierProvider` を基本とし、`config/dependencies.dart` で一元管理する
- リポジトリはインターフェース（抽象クラス）を定義し、テスト時にモックに差し替え可能にする
