# frozen_string_literal: true

# メーラーのテスト用ヘルパー
RSpec.configure do |config|
  # すべてのテストタイプでURLホスト設定を適用
  config.before(:each) do
    # テスト環境でURLを生成する際のホスト設定
    default_url_options = { host: 'example.com' }
    ActionMailer::Base.default_url_options = default_url_options
    Rails.application.routes.default_url_options = default_url_options
  end
end