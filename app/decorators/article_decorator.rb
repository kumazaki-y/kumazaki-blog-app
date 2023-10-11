module ArticleDecorator

# ArticleテーブルのDBからデータがcreateされた時間を取得し表示。
  # I18nにより国際化し、ja.ymlファイルで指定したdefaultの仕様で各国の時間表記に合わせて表示できる
  # というメソッドを作成しておくとerbやコントローラで呼び出せる（MVCのルールによって）。コントローラにはリクエストが来た際に実行するメソッドを書いておく。
  # モデルにはリクエストが来なくとも常に実行する繰り返しメソッドを書いておくと管理しやすい（コントローラに集約させるとコード読みづらい）。
  def display_created_at
    I18n.l(created_at, format: :default)
  end

  def author_name #haml側での記述量を減らすためにメソッド作成
    user.display_name
  end

  def like_count
    likes.count #has_many:likesしているのでlikeテーブル情報を取得し、数を数える。
  end

end