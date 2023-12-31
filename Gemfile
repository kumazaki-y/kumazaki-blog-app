source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.7'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.2', '>= 6.0.2.1'
# Use sqlite3 as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'#SQLite3から変更。
# Use Puma as the app server
gem 'puma', '~> 4.1'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 5.0'#5にアップグレード
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

gem 'faker' # 記述後、ターミナルで「bundle install」を実行するとfakerツールをインストールできる
# gemとは 先人の作った便利なツール（ライブラリー）。githubに使い方など書かれている。
# gemfile.lockのファイルでgemのバージョンを管理して、特定のバージョンしか使えないようにロックされている。

gem 'annotate' # データベースの内容を取り込んでarticle.rbにコメントで表示するライブラリ。
gem 'hamlit' # hamlを読み込みrailsで記述できるようにする。
# 記述後にターミナルで「bundle install」「rails g annotate:install」「rails db:migrate」の順に実行

gem 'active_decorator' #viewに関するメソッドをまとめられる。helperよりも直感的に記述できる。「rails g decotator　〇〇」でdecoratorファイルを作成できる。

gem 'active_model_serializers' #jsにデータを渡す際に通常はすべてのデータが一斉に送られるが、これがあるとserializerファイルに指定した特定の情報だけ渡せるようになる。

gem 'devise'
# gemのインストール、railsでの設定、DBからデータを取得をそれぞれ行っている

gem 'aws-sdk-s3', require: false #AWSにアップロードできるようになる
gem 'sidekiq' #非同期処理できるようになる。RedisのDBを起動する必要あり。

# Use Active Storage variant
gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'pry-byebug' # デバッグの際に任意のコードの下に「binding.pry」を記述することで以降の処理を実行できなくさせ、どこまで有効に動いているか確認できる。
  # 代わりにターミナル上でコードを実行できるようになるのでそこで様々な処理を試してバグを見つける。
  gem 'better_errors'#エラーメッセージを見やすくするライブラリ
  gem 'binding_of_caller'#エラーメッセージの画面でconsoleを実行できるようになるライブラリ
  gem 'rubocop-rails' # ターミナルで「bundle install」後、vendorディレクトリに.rubocop.ymlを作成。そこにコードチェックの基準を記述する。
  gem 'dotenv-rails' #環境変数について設定するライブラリ。configのappファイルにも設定記述が必要。
  gem 'rspec-rails' #テストを行うためのライブラリ。「rails g rspec:install」で必要なツールを作成。「rails g rspec:model article」等でテストしたいファイルを作成。
  gem 'factory_bot_rails' #ダミーデータを作成する。「spec/rails_helper.rb」に「config.include FactoryBot::Syntax::Methods」の記載が必要。
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'web-console', '>= 3.3.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'erb2haml' # 記述したerbをhamlに変換する。「bundle exec rake haml:replace_erbs」をターミナルで実行すると変換が行われる。
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'letter_opener' #メールを開くためのgem
  gem 'letter_opener_web', '~> 1.0' #ブラウザでメールを開くためのgem
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
