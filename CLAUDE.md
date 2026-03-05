# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## プロジェクト概要

**Kebab TOKYO** - ケバブ特化型レビュー共有アプリ。ユーザーがケバブ店舗を投稿・レビューし、地図ベースで探せるサービス。

## 技術スタック

- **Backend**: Ruby 3.3.6 / Rails 8.1.2
- **Database**: PostgreSQL 16
- **Frontend**: Tailwind CSS 4.4 + Stimulus.js + Turbo Rails
- **認証**: Devise
- **デプロイ**: Kamal + Docker

## 開発コマンド

```bash
# セットアップ
bin/setup                  # 初期化（依存関係 + DB準備 + サーバー起動）
bin/setup --skip-server    # サーバー非起動
bin/setup --reset          # DBリセット

# 開発サーバー
bin/dev                    # Foreman経由で起動（Rails + Tailwind watch）

# テスト
bin/rails test             # ユニット・統合テスト
bin/rails test test/models/user_test.rb  # 単一テスト実行

# リント・セキュリティ
bin/rubocop                # RuboCop（Omakase スタイル）
bin/brakeman               # セキュリティスキャン
bin/bundler-audit          # gem脆弱性チェック
```

## Docker開発

```bash
docker-compose build
docker-compose up          # PostgreSQL + Rails（ポート3000）
```

## アーキテクチャ

### モデル構造（計画）

- **User**: Devise認証（実装済み）
- **Shop**: 店舗情報（店名、位置情報、画像）
- **Review**: レビュー（評価項目：肉の種類/味、ソース、野菜量、総合評価等）

### ビュー構成

- `app/views/layouts/application.html.erb` - PWA対応メインレイアウト
- `app/views/shared/_header.html.erb` - 共通ヘッダー
- `app/views/devise/` - 認証関連ビュー（カスタマイズ済み）

### CI/CD

GitHub Actions（`.github/workflows/ci.yml`）:
1. **Scan Ruby**: Brakeman + bundler-audit
2. **Lint**: RuboCop
3. **Test**: 並列テスト実行

## 開発時の注意点

- Tailwind CSSは`bin/dev`実行時に自動ビルド（Procfile.dev参照）
- テストは並列実行有効（`parallelize(workers: :number_of_processors)`）
- RuboCopはOmakaseスタイル（`.rubocop.yml`）

## フロントエンドデザインガイドライン

UIの変更・作成時は以下に従うこと。

### デザイン方針

- モバイルファースト
- シンプル・モダン・視認性が高い
- 一貫性のあるデザイン（全ページで統一パターンを使用）

### 配色（ブランドカラー）

- **メイン背景**: `bg-amber-50`
- **ヒーローヘッダー**: `bg-stone-900`（SVGパターン背景 + 絵文字アイコン）
- **カード**: `bg-white rounded-2xl shadow-lg border border-stone-200`
- **テキスト**: `text-stone-800`（主要）、`text-amber-700`（補助）
- **アクセント**: `amber-800` / `amber-100`（ボタン・バッジ）
- **危険系**: `red-50` / `red-600`（削除・エラー）

### 共通UIパターン

- **ページ構造**: ヒーローヘッダー → `-mt-6` でカードをオーバーラップ → `max-w-lg` コンテンツ
- **入力フィールド**: `px-4 py-3 rounded-xl border-2 border-stone-200 bg-amber-50 focus:border-amber-400`
- **送信ボタン**: `rounded-2xl font-black text-amber-900 bg-amber-100 border-2 border-amber-800 hover:bg-amber-800 hover:text-white`
- **リスト項目**: アイコン + テキスト + シェブロン（`M9 5l7 7-7 7`）、`hover:bg-amber-50`
- **セクションヘッダー**: 絵文字（`rounded-full bg-amber-100`） + `font-bold text-stone-800`
- **スコアバッジ**: `bg-stone-900/80 backdrop-blur-sm text-amber-50 rounded-full`

### 改善対象

ヘッダー、ナビゲーション、ボトムナビ、カードUI、ボタン、フォーム、一覧ページ、詳細ページ
