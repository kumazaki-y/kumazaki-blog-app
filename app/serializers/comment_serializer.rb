class CommentSerializer < ActiveModel::Serializer #ターミナルでrails g serializer Commentで作成
  attributes :id, :content #jsに渡したいデータを記述
end
