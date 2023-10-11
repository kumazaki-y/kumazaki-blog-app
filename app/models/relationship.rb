# == Schema Information
#
# Table name: relationships
#
#  id           :bigint           not null, primary key
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  follower_id  :bigint           not null
#  following_id :bigint           not null
#
# Indexes
#
#  index_relationships_on_follower_id   (follower_id)
#  index_relationships_on_following_id  (following_id)
#
# Foreign Keys
#
#  fk_rails_...  (follower_id => users.id)
#  fk_rails_...  (following_id => users.id)
#
class Relationship < ApplicationRecord
    belongs_to :follower, class_name: 'User'
    belongs_to :following, class_name: 'User' #follower,followingカラムにそれぞれ紐付け。どのテーブルかも指定する必要がある。

    after_create :send_email #コールバック機能。relationshipに関するcreateメソッド（フォロー）が実行された際にsend_emailメソッドを実行する。

    private
    def send_email #フォローが発生した時にメール送信するメソッドを定義。ここに書いておくことで、個別のコントローラで複数のフォロー機能が合っても、それらすべてに送付機能を与えられる。
        RelationshipMailer.new_follower(following, follower).deliver_later #deliverはメールを送信するメソッド。nowは同期処理・laterは非同期処理
    end

end
