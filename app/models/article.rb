class Article < ApplicationRecord
    validates :title, presence: true #validatesで指定したカラムについて検証できる。presence:trueで、titleが空欄の時は保存できないようにする
    validates :content, presence: true
    #validatesの種類。length:長さを検証,format:正規表現か検証,numericality:数字の検証,presence:入力の有無を検証,uniqueness:唯一性を検証

    #ArticleモデルのDBからデータがcreateされた時間を取得し表示。
    #I18nにより国際化し、ja.ymlファイルで指定したdefaultの仕様で各国の時間表記に合わせて表示できる
    #というメソッドを作成しておくとerbやコントローラで呼び出せる（MVCのルールによって）。コントローラにはリクエストが来た際に実行するメソッドを書いておく。
    #モデルにはリクエストが来なくとも常に実行する繰り返しメソッドを書いておくと管理しやすい（コントローラに集約させるとコード読みづらい）。
    def display_created_at 
        I18n.l(self.created_at, format: :default)
    end
end
