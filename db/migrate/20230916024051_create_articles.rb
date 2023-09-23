class CreateArticles < ActiveRecord::Migration[6.0] # DBはターミナルでMigrationを実行し行や列の形を変更。記録が残りチーム開発しやすい
  def change
    create_table :articles do |t| # ターミナルで実行したコードによりファイルが自動で作られる。
      t.references :user, null: false #ユーザーIDが存在しないと絶対記事を作れない処理。validationはあくまでアクティブレコードに対する制限なので、DB側に制限をかける方が安心。
      t.string :title, null: false # テーブルに追加したいカラムを書く。tはtextの略。stringは短い文字列を保存する
      t.text :content, null: false # textは長い文字列を保存する
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


#↓DAY20でファイルごと削除。DBをrollbackでリセットしてuserありきの記事がある状態に変更した際に不要となった。
  #articleテーブルに下記の処理と同様のt.references :userを追加した。

# class AddUserIdToArticles < ActiveRecord::Migration[6.0] #ユーザーと記事を紐づけるために「rails g migrate クラス名」でマイグレーションファイルを作成
#   def change
#     add_reference :articles, :user #articlesにuserカラムを追加するメソッド。便利な機能を内包するので他の追加方法より推奨
#     #マイグレーションファイルはDBの設計図なので、これを記述後に「rails db:migrate」でDBに反映させる。
    #カラムを追加しただけでは紐づけは完了しない。DBにどのような動きをするか指示するモデル（アクティブレコード）ディレクトリに記述が必要。
    #アクティブレコードはRubyに書いたコードをSQLで実行してくれるアシスタントみたいなやつ
#   end
# end

