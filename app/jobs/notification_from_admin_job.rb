class NotificationFromAdminJob < ApplicationJob
    queue_as :default #どのキューを使うか指定
  
    def perform(msg) #jobファイルを使うために絶対必要なメソッド。この内部に処理を書く
        User.all.each do |user| #すべてのユーザーを取得して個別に
          NotificationFromAdminMailer.notify(user, msg).deliver_later #mailerファイルに書かれたメソッドを非同期処理
        end
    end
end