class CreateLikes < ActiveRecord::Migration[6.0]
  def change
    create_table :likes do |t| #複数の記事と複数ユーザーを紐づけるいいね機能の実装。中間テーブルにより両者のidを紐づける。
      t.references :user, null: false
      t.references :article, null: false
      t.timestamps
    end
  end
end
