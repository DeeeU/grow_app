FROM ruby:3.3.0

# 必要なパッケージのインストール
RUN apt-get update -qq && apt-get install -y nodejs sqlite3 libsqlite3-dev

# 作業ディレクトリの作成
WORKDIR /app

# GemfileとGemfile.lockをコピー
COPY Gemfile Gemfile.lock ./

# Bundlerでgemをインストール
RUN gem install bundler && bundle install

# アプリケーションのコピー
COPY . .

# SQLite3のデータベースディレクトリ
RUN mkdir -p storage

# Railsサーバー起動時の設定
EXPOSE 3000

# アプリケーションの起動コマンド（開発環境用）
CMD ["rails", "server", "-b", "0.0.0.0"]
