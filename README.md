# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

- Ruby version

- System dependencies

- Configuration

- Database creation

- Database initialization

- How to run the test suite

- Services (job queues, cache servers, search engines, etc.)

- Deployment instructions

- ...

# 作者 memo

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
- Circle/CI の追加
  - Docker コンテナでの開発が好まれる為、切り替えが必要そう
- リファクタ
- UI 整え
