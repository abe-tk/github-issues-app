---
description: >
  実装済みコードをレビューする。
  flutter-reviewer エージェントを呼び出してアーキテクチャ・セキュリティ・
  コード品質・テスト網羅性を多角的にレビューする。
model: sonnet
---

# コードレビューコマンド

## ワークフロー

### Step 1: レビュー対象を確認する

`AskUserQuestion` ツールで以下を確認する：
- レビューしたい対象（特定ファイル・機能・全体）
- 特に重点的に見てほしい観点があれば（セキュリティ・パフォーマンス・テストなど）

### Step 2: レビューを実施する（flutter-reviewer）

`Agent` ツールで `flutter-reviewer` エージェントを呼び出す：
- subagent_type: flutter-reviewer
- description: コードレビューの実施
- prompt: レビュー対象のファイルパスと重点観点を渡す。以下の5観点でレビューするよう指示する：
  1. アーキテクチャ適合性（CLAUDE.md の方針との整合）
  2. セキュリティ（認証情報の扱い・入力バリデーション）
  3. コード品質（エラーハンドリング・コメント・デッドコード）
  4. テスト網羅性（正常系・異常系・カバレッジ）
  5. Flutter / Dart ベストプラクティス（const・mounted チェック等）

### Step 3: レビュー結果をユーザーに報告する

flutter-reviewer の出力をそのままユーザーに伝える。

### Step 4: 修正対応を確認する（任意）

`AskUserQuestion` ツールで確認する：
- Critical / Warning の指摘について修正を行うか
- 修正する場合は `flutter-implementer` エージェントに引き継ぐ

## 重要な制約

1. **flutter-reviewer はコードを修正しない**: 指摘・提案のみを行う
2. **修正が必要な場合は別途 flutter-implementer を使う**
3. **レビュー対象が広い場合は機能単位に分けて実施する**

## 完了後の出力

ユーザーに以下を報告する：
- レビューの総評
- Critical / Warning / Suggestion の件数サマリ
- 特に重要な指摘のハイライト
