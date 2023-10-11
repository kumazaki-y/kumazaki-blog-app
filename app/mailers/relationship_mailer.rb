class RelationshipMailer < ApplicationMailer
    def new_follower(user, follower) #フォローを通知するメソッド。第一引数にフォローされた人（ユーザー自身）、第二引数はフォローした人。
        @user = user #引数で取得した値をhamlで使えるようにインスタンス化
        @follower = follower
        mail to: user.email, subject: '【お知らせ】フォローされました' #メールを送るメソッド。ユーザーのアドレスに送られるようにし、タイトルを設定。
      end
end