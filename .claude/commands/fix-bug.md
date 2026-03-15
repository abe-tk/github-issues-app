---
description: >
  バグを修正する。再現手順の確認 → 原因特定 → 修正実装 → テスト の順で進める。
  flutter-implementer と flutter-tester エージェントを呼び出す。
model: sonnet
---

# バグ修正コマンド

## ワークフロー

### Step 1: バグの詳細を確認する

`AskUserQuestion` ツールで以下を確認する：
- バグの症状（何が起きているか）
- 再現手順
- 期待する動作

### Step 2: 原因を特定する

関連ファイルを読み込み、バグの原因を特定する。
以下の観点で調査する：
- エラーメッセージやスタックトレース
- 状態管理の問題（ViewModel の状態遷移）
- API レスポンスの処理
- 非同期処理のエラーハンドリング漏れ

原因を特定したら、修正方針をユーザーに説明する。

### Step 3: 修正を実装する（flutter-implementer）

`Task` ツールで `flutter-implementer` エージェントを呼び出す：
- subagent_type: flutter-implementer
- description: バグ修正の実装
- prompt: 特定したバグの原因と修正箇所を渡す。最小限の変更で修正すること。コード生成が必要な場合は build_runner を実行すること。

### Step 4: テストで修正を確認する（flutter-tester）

`Task` ツールで `flutter-tester` エージェントを呼び出す：
- subagent_type: flutter-tester
- description: バグ修正のテスト追加
- prompt: 修正したバグが再発しないことを確認するテストを追加するよう指示する。既存テストも全て pass することを確認する。

## 重要な制約

1. **最小限の変更**: バグ修正に関係ない箇所は変更しない
2. **テストで確認**: 修正後は必ずテストを実行・追加する
3. **Task ツールを使うこと**: エージェントの呼び出しに bash コマンドを使わない

## 完了後の出力

ユーザーに以下を報告する：
- バグの原因
- 修正した箇所（ファイル名・行数）
- 追加・修正したテスト
