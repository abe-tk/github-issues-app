---
description: >
  Flutter アプリに新機能を実装する。設計 → 実装 → テスト の順で
  flutter-architect / flutter-implementer / flutter-tester エージェントを順番に呼び出す。
model: sonnet
---

# 機能実装コマンド

Flutter GitHub Issues アプリに新機能を実装します。

## ワークフロー

### Step 1: 実装する機能を確認する

`AskUserQuestion` ツールで以下を確認する：
- 実装する機能の概要
- 対象の画面・操作（例: Issue一覧表示、Issue作成、Issue更新）

### Step 2: 設計（flutter-architect）

`Task` ツールで `flutter-architect` エージェントを呼び出す：
- subagent_type: flutter-architect
- description: 機能設計の実施
- prompt: ユーザーから確認した機能概要を渡し、作成すべきファイル一覧・クラス設計・依存関係を設計ドキュメントとして出力するよう指示する

エージェントの完了を待ち、設計ドキュメントを受け取る。

### Step 3: 実装（flutter-implementer）

`Task` ツールで `flutter-implementer` エージェントを呼び出す：
- subagent_type: flutter-implementer
- description: 設計に基づくコード実装
- prompt: Step 2 の設計ドキュメントを渡し、Data層 → UI層 の順で実装するよう指示する。コード生成（build_runner）も含む。

エージェントの完了を待つ。

### Step 4: テスト作成（flutter-tester）

`Task` ツールで `flutter-tester` エージェントを呼び出す：
- subagent_type: flutter-tester
- description: テストコードの作成
- prompt: 実装された機能のファイルパスを渡し、ViewModel・Repository のユニットテストと主要画面のウィジェットテストを作成するよう指示する

エージェントの完了を待つ。

## 重要な制約

1. **Task ツールを使うこと**: エージェントの呼び出しに bash コマンドを使わない
2. **順番を守ること**: 設計 → 実装 → テスト の順に実行する（並列不可）
3. **設計ドキュメントを引き継ぐこと**: 各ステップの出力を次のエージェントに渡す

## 完了後の出力

ユーザーに以下を報告する：
- 実装した機能の概要
- 作成・変更したファイル一覧
- テスト実行結果（pass/fail）
