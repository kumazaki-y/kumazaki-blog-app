require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module KumazakiBlogApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    if Rails.env.development? || Rails.env.test? #開発とテスト環境の時だけ下記を実行。環境変数に関する設定。
      Bundler.require(*Rails.groups)
      Dotenv::Railtie.load
    end

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    config.i18n.default_locale = :ja # デフォルト言語を日本語にするという内容。config→locales→にja.ymlファイルを作成し日本語設定を要記述
    # application.rbファイルはサーバーを再起動しないと読み込まれないため、ターミナルにて⌘Cで終了しrails sで再起動させる必要がある。

    config.active_job.queue_adapter = :sidekiq
  end
end
