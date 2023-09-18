# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movi
#

# ダミーデータを作るためのファイル
# Article.create(title:'新しい記事',content:'素晴らしい記事です') #articleモデルを作り、ハッシュ（カラム名）と内容を与える処理
# Article.create(title:'素晴らしい記事',content:'すごい記事です') #これを記述後、ターミナルで「rails db:seed」を実行すると本ファイルの処理が実行される
# ↑fakerを使うためコメントアウト

10.times do # 下記の処理を10回行う
  Article.create(
    title: Faker::Lorem.sentence(word_count: 5), # 長文を作るメソッド（引数に単語数を指定）。fakerのサイトからコピペ可能
    content: Faker::Lorem.sentence(word_count: 100) # 本記述後にターミナルで「rails db:seed」を実行すると本記述が処理される
  )
end
