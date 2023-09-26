# == Schema Information
#
# Table name: likes
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  article_id :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_likes_on_article_id  (article_id)
#  index_likes_on_user_id     (user_id)
#
class Like < ApplicationRecord
    belongs_to :user #中間テーブルから見たら記事とユーザーは個別なのでこの書き方で紐づける
    belongs_to :article
end
