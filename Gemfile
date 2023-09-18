source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.7'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.2', '>= 6.0.2.1'
# Use sqlite3 as the database for Active Record
gem 'sqlite3', '~> 1.4'
# Use Puma as the app server
gem 'puma', '~> 4.1'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 4.0'
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
# gemのインストール、railsでの設定、DBからデータを取得をそれぞれ行っている

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

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
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'web-console', '>= 3.3.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'erb2haml' # 記述したerbをhamlに変換する。「bundle exec rake haml:replace_erbs」をターミナルで実行すると変換が行われる。
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
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
