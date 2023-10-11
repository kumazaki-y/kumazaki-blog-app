class RemoveContentFromArticles < ActiveRecord::Migration[6.0]
  def change
    remove_column :articles, :content, :text
    #articleモデルのカラムを削除。ロールバックは逆の処理（追加）を行うが、型（text等）を指定しないといけないので記載。
  end
end
