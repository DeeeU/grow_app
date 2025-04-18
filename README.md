# README

This README would normally document whatever steps are necessary to get the
application up and running.

## Development Environment

### Traditional Setup

Things you may want to cover:

- Ruby version: 3.3.0
- Rails version: 7.1.3.4
- System dependencies
- Configuration
- Database: SQLite3
- Database creation
- Database initialization
- How to run the test suite
- Services (job queues, cache servers, search engines, etc.)
- Deployment instructions

### Docker Setup (Recommended)

This application can be run using Docker, which simplifies the setup process and ensures consistent environments across all development machines.

#### Prerequisites

- Docker
- Docker Compose

#### Getting Started

1. Clone the repository
2. Run the application with Docker Compose:

```bash
docker-compose up -d
```

3. Access the application at http://localhost:3000

#### Useful Commands

```bash
# Start the application
docker-compose up -d

# View logs
docker-compose logs -f

# Stop the application
docker-compose down

# Run tests
docker-compose exec web bin/rails test

# Run RSpec tests
docker-compose exec web bundle exec rspec

# Access Rails console
docker-compose exec web bin/rails console

# Run database migrations
docker-compose exec web bin/rails db:migrate
```

## 作者 memo

### 1. ページの設計

やりたいこと

- ログインしたユーザーは日記を書ける
- ログイン完了後は日記一覧画面に遷移する（作成された日付順に日記が並ぶ）
- 右上に作成ボタンを作る
- 作成ボタンを押すとテンプレで日記が書ける
- 作成後、日記が一覧画面に表示される
- 一覧画面から作成した日記を押すと以下の要素が見える
  - 日記の内容
  - 編集ボタン（編集できる項目はまだ決めていない）
  - 削除ボタン

（開発版）やりたいこと

- Rspec のヘッドレス Chrome ブラウザのテストへの切り替え
- フラッシュメッセージの追加
- ✅ Docker 環境の導入
- Circle/CI の追加
- リファクタ
- UI 整え
