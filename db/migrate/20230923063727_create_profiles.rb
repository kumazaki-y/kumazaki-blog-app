class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.references :user, null: false #ユーザーがいないとダメ
      t.string :nickname
      t.text :introduction
      t.integer :gender
      t.date :birthday
      t.boolean :subscribed, default: false #trueかfalseだけが値になるカラムを作成。何も入力なければデフォルトの値をfalseにする
      t.timestamps
    end
  end
end
