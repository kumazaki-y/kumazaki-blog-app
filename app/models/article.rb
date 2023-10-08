# == Schema Information
#
# Table name: articles
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_articles_on_user_id  (user_id)
#
class Article < ApplicationRecord
  validates :title, length: { minimum: 2, maximum: 100 } #文字の長さを検証。今回は二文字以上でないと登録できない
  validates :title, presence: true # validatesで指定したカラムについて検証できる。presence:trueで、titleが空欄の時は保存できないようにする
  validates :title, format: { with: /\A(?!\@)/ } #「titleの先頭は@以外」でないと登録できない処理。
                                                #\Aは先頭を表し、\@を(?!)の前に置くことで「＠以外」を指定。(?!)が無ければ先頭が＠でないと登録できない。

  validates :content, presence: true


  # validates :content, length: { minimum: 10}
  # validates :content, uniqueness: true #同じ内容があるか検証
  # # validatesの種類。length:長さを検証,format:正規表現か検証,numericality:数字の検証,presence:入力の有無を検証,uniqueness:唯一性を検証
  # validate :validat_title_and_content_length #独自に検証機能をつける場合は「validate」で実装する。複数形でないことに注意。検証内容は別に要定義
  #↑Action text実装に併せてまとめてコメントアウト。エラーになるらしい


  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy #記事から見たら中間テーブルのいいねは複数対象なのでこの書き方で紐付け
  belongs_to :user #記事はユーザーに紐付けられている、というような意味。記事から見たユーザーは一人なので単数系で書く。
  has_one_attached :eyecatch #記事に画像UPできるメソッドを定義
  has_rich_text :content #contentに対してAction textを使えるようにする設定



  # private
  # def validat_title_and_content_length
  #   char_count = self.title.length + self.content.length #chraは文字。タイトルとコンテントの文字数を検証。
  #   errors.add(:content, '100文字いじょうで！') unless char_count > 100 #文字数が100字以下だったら、エラー文を追加する処理。
  #                                                                   #独自の定義なのでエラー文も用意しないといけない
  # end
  #↑Action text実装に併せてコメントアウト。エラーになるらしい

end
