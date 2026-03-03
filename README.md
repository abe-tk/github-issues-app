# GitHub Issues 管理 アプリ

## 概要

GitHub Issues APIを使用したCRUD処理ができるFlutterアプリを成してください。

## 機能要件

### Core機能

- **Issues CRUD操作**: Issue取得・作成・編集・削除・コメン（GitHub PAT(Personal Access Token)を使用）

### UI/UX要件

- **Material Design 3**: Flutter標準のMaterial 3デザイン
- **エラーハンドリング**: 適切なエラー表示とローディング状態

## 技術仕様

### アーキテクチャ

- **Flutter Architecture**: https://docs.flutter.devresources/architectural-overview
に準拠
- **参考実装**: compass_app
(https://github.com/flutter/samples/tree/maincompass_app/app/lib)
- **状態管理**: Provider
- **レイヤー構成**: UI → Domain → Data

### 実装指定

#### 1. APIクライアント
- HTTP通信: Dioを使用
- コード生成: RetrofitでタイプセーフなAPIクライアント自動生成

#### 2. モデルクラス
- freezed: イミュータブルなモデルクラス生成
- json_serializable: JSONシリアライゼーション自動生成

#### 3. ルーティング
- go_router: 宣言的ルーティング
- go_router_builder: ルート定義のコード生成

### ディレクトリ構成（compass_app準拠）

```
  lib/
├── main.dart
├── config/
│   ├── dependencies.dart        # providers設定
│   └── constants.dart           # アプリ定数
├── data/
│   ├── models/                  # データモデル
│   ├── services/                # データサービス
│   └── repositories/            # リポジトリパターン
├── domain/
│   ├── models/                  # ドメインモデル
│   └── usecases/                # ビジネスロジック
├── routing/
│   ├── app_router.dart          # go_router設定
│   └── routes.dart              # ルート定（go_router_builder）
├── ui/
│   ├── core/                    # 共通UIコンポーネント
│   │   ├── themes/
│   │   ├── widgets/
│   └── feature/                 # 機能単位
│       ├── view_models/         # ViewModel
│       └── widgets/             # 画面やコンポーネント
└── utils/
```

## GitHub API仕様

- Base URL: https://api.github.com
- 主要エンドポイント:
  - GET /repos/{owner}/{repo}/issues - Issues一覧
  - POST /repos/{owner}/{repo}/issues - Issue作成
  - PATCH /repos/{owner}/{repo}/issues/{number} - Issue更新と削除
