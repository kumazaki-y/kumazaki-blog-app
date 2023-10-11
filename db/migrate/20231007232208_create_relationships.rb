class CreateRelationships < ActiveRecord::Migration[6.0]
  def change
    create_table :relationships do |t|
      t.references :following, null: false, foreign_key: { to_table: :users }
      t.references :follower, null: false, foreign_key: { to_table: :users }
      # foreign_key: { to_table: :users }を記述し、このカラムがuserテーブルと紐づくように指定。
      t.timestamps
    end
  end
end

#フォロー機能を追加する手順。
# １　ターミナルで中間テーブル作成。中間テーブルは通常のn対nとは異なる形式で、followingIDとfollowerIDカラムを作成する。
# ２　ユーザーAがユーザーBをフォローした時、「followingID：B,followerID：A」という形式になる。この時のAの外部キーはfollowerIDとなる。
# ３　外部キーとは、関連するテーブルからデータを取得する際に使う値。