class Article < ApplicationRecord
    validates :title, presence: true #validatesで指定したカラムについて検証できる。presence:trueで、titleが空欄の時は保存できないようにする
    validates :content, presence: true
    #validatesの種類。length:長さを検証,format:正規表現か検証,numericality:数字の検証,presence:入力の有無を検証,uniqueness:唯一性を検証

end
