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
