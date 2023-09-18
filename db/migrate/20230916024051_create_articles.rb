class CreateArticles < ActiveRecord::Migration[6.0] # DBはターミナルでMigrationを実行し行や列の形を変更。記録が残りチーム開発しやすい
  def change
    create_table :articles do |t| # ターミナルで実行したコードによりテーブルが作られる。
      t.string :title # テーブルに追加したいカラムを書く。tはtextの略。stringは短い文字列を保存する
      t.text :content # textは長い文字列を保存する
      t.timestamps # 日時が記録される。お決まりのコード
    end
  end
end

# データベースをターミナルで作成する流れ
# rails generate model Articleを実行。レイルズでArticleというモデルを作る宣言
# 上記のようにxcodeで追加したいカラムを記述してから、ターミナルでrails db:migrateを実行

# データベースをターミナルで保存する流れ
# rails cでコンソールを立ち上げ、データベースへアクセスしたりruby等のコードを実行できるようにする
# Article.create(title: 'title',content: 'ブログだよ')を実行するとrailsがSQLのINSERT等を実行しテーブルに情報を記録する
# Article.firstを実行するとデータが表示される。

# MVCについて
# Model View ArticlesControllerの略
# ブラウザのリクエストをroutesが受けてACに処理を命令
# ACがDBモデルからデータを取得しHTMLを作成しブラウザに表示を返している。
